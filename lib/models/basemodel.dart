import 'dart:convert';
import 'dart:io';
import 'package:connectivity/connectivity.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked/stacked.dart';

class BaseModel extends BaseViewModel {
  String animal = '';
  String temperature = '';
  String moment = '';
  String userLocation = '';
  dynamic weatherIcon = '';
  String airQuality = '';
  String time = '';
  int usEpaIndex = 0;
  double uv = 0.0;
  String sunrise = '';
  String sunset = '';
  String windspeed = '';
  String feelsLike = '';
  String humidity = '';
  String pressure = '';
  int dewPoint = 0;

  List<HourlyWeather> hourlyWeather = [];
  List<WeatherDay> weeklyWeather = [];

  final apiKey = '1ff1b236a7714ad29e5160802230104';
  final refreshInterval = const Duration(minutes: 15);

  String get apiUrlTemplate =>
      'http://api.weatherapi.com/v1/forecast.json?key=$apiKey&q={latitude},{longitude}&days=10&aqi=yes&alerts=yes';

  static BaseModel? _instance;

  static BaseModel get instance {
    _instance ??= BaseModel();
    return _instance!;
  }

  BaseModel() {
    // Initialize the data when the BaseModel is created
    getTemperature();
    fetchHourlyWeather();
    fetchWeeklyWeather();
  }

  Future<void> getTemperature() async {
    final prefs = await SharedPreferences.getInstance();
    final cachedWeatherData = prefs.getString('weatherData');

    if (cachedWeatherData != null) {
      final weatherData = jsonDecode(cachedWeatherData);
      updateWeatherData(weatherData);
    }

    final connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      return;
    }

    try {
      PermissionStatus status = await Permission.location.status;
      if (!status.isGranted) {
        status = await Permission.location.request();
        if (!status.isGranted) {
          return;
        }
      }

      final position = await Geolocator.getCurrentPosition();
      final latitude = position.latitude;
      final longitude = position.longitude;

      final apiUrl = apiUrlTemplate
          .replaceFirst('{latitude}', '$latitude')
          .replaceFirst('{longitude}', '$longitude');

      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        updateWeatherData(data);
        prefs.setString('weatherData', jsonEncode(data));

        await fetchHourlyWeather();
        await fetchWeeklyWeather();
      } else {
        throw Exception('Failed to load temperature');
      }
    } on SocketException catch (_) {
    } on HttpException catch (_) {
    } on FormatException catch (_) {
    } catch (error) {
    }
  }






  void updateWeatherData(Map<String, dynamic> data) {
    final temp = data['current']['temp_c'];
    final conditionText = data['current']['condition']['text'];
    final conditionIcon = data['current']['condition']['icon'];
    final currentUserLocation = data['location']['name'];
    final usertime = data['location']['localtime'].toString();
    final airQualityData = data['current']['air_quality'];
    final uvValue = data['current']['uv'];
    final sunriseData = data['forecast']['forecastday'][0]['astro']['sunrise'];
    final sunsetData = data['forecast']['forecastday'][0]['astro']['sunset'];
    final datetime = DateFormat('yyyy-MM-dd HH:mm').parse(usertime);
    final timeString = DateFormat('HH:mm').format(datetime);
    final windSpeedData = data['current']['wind_kph'].toString();
    final feelsLikeddata = data['current']['feelslike_c'].toString();
    final humidityData = data['current']['humidity'].toString();
    final pressureData = data['current']['pressure_mb'].toString();

    temperature = '$temp\u00B0';
    moment = conditionText;
    weatherIcon = 'https:$conditionIcon';
    userLocation = currentUserLocation;
    airQuality = airQualityData.toString();
    usEpaIndex = airQualityData['us-epa-index'];
    uv = uvValue;
    time = timeString;
    sunrise = sunriseData;
    sunset = sunsetData;
    windspeed = windSpeedData;
    feelsLike = feelsLikeddata;
    humidity = humidityData;
    pressure = pressureData;

    notifyListeners();
  }

  Future<void> fetchHourlyWeather() async {
    final prefs = await SharedPreferences.getInstance();
    final cachedHourlyWeatherData = prefs.getString('hourlyWeather');

    if (cachedHourlyWeatherData != null) {
      final List<dynamic> decodedData = jsonDecode(cachedHourlyWeatherData);
      final List<HourlyWeather> weatherList =
          decodedData.map((item) => HourlyWeather.fromJson(item)).toList();
      hourlyWeather = weatherList;
      notifyListeners();
      return;
    }

    try {
      final position = await Geolocator.getCurrentPosition();
      final latitude = position.latitude;
      final longitude = position.longitude;

      final apiUrl = apiUrlTemplate
          .replaceFirst('{latitude}', '$latitude')
          .replaceFirst('{longitude}', '$longitude');

      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        if (data.containsKey('forecast') &&
            data['forecast'].containsKey('forecastday')) {
          final forecastDays = data['forecast']['forecastday'];
          if (forecastDays is List && forecastDays.isNotEmpty) {
            final todayForecast = forecastDays[0];
            if (todayForecast.containsKey('hour') &&
                todayForecast['hour'] is List) {
              final hourlyData = todayForecast['hour'] as List<dynamic>;

              final currentTime = DateTime.now().hour;
              final startIndex = currentTime + 1;

              hourlyWeather =
                  hourlyData.skip(startIndex).map<HourlyWeather>((hourData) {
                final time = hourData['time']?.toString().split(' ')[1] ?? '';
                final conditionIcon = 'https:${hourData['condition']['icon']}';
                final temperature = (hourData['temp_c'] as double).round();

                return HourlyWeather(
                  time: time,
                  hourimageName: conditionIcon,
                  hourtemperature: temperature,
                );
              }).toList();

              prefs.setString('hourlyWeather',
                  jsonEncode(hourlyWeather.map((e) => e.toJson()).toList()));

              notifyListeners();
            }
          }
        }
      } else {
      }
    } catch (error) {
    }
  }

  bool isWeeklyWeatherFetched = false; // Add this variable

  Future<void> fetchWeeklyWeather() async {
    if (isWeeklyWeatherFetched) {
      return; // Return early if weather data is already fetched
    }

    final prefs = await SharedPreferences.getInstance();

    final cachedWeeklyWeatherData = List<WeatherDay?>.generate(7, (index) {
      final cachedData = prefs.getString('weeklyWeather$index');
      if (cachedData != null) {
        final decodedData = jsonDecode(cachedData);
        return WeatherDay.fromJson(decodedData);
      } else {
        return null;
      }
    });

    if (cachedWeeklyWeatherData.every((day) => day != null)) {
      weeklyWeather = cachedWeeklyWeatherData as List<WeatherDay>;
      notifyListeners();
      isWeeklyWeatherFetched =
          true; // Set the flag to indicate weather data is fetched
      return;
    }

    try {
      final position = await Geolocator.getCurrentPosition();
      final latitude = position.latitude;
      final longitude = position.longitude;

      final apiUrl = apiUrlTemplate
          .replaceFirst('{latitude}', '$latitude')
          .replaceFirst('{longitude}', '$longitude');

      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        if (data.containsKey('forecast') &&
            data['forecast'].containsKey('forecastday')) {
          final forecastDays = data['forecast']['forecastday'];

          if (forecastDays is List && forecastDays.length >= 7) {
            final currentTime = DateTime.now();
            final nextDay = DateTime(
              currentTime.year,
              currentTime.month,
              currentTime.day + 1,
            );

            weeklyWeather = forecastDays
                .skipWhile((dayData) {
                  final date = DateTime.parse(dayData['date']);
                  return date.isBefore(nextDay);
                })
                .take(7)
                .map<WeatherDay>((dayData) {
                  final conditionIcon =
                      'https:${dayData['day']['condition']['icon']}';
                  final temperature =
                      (dayData['day']['maxtemp_c'] as double).round();
                  final date = DateTime.parse(dayData['date']);
                  final dayOfWeek = DateFormat('E').format(date);

                  return WeatherDay(
                    iptemperature: temperature,
                    imageName: conditionIcon,
                    dayOfWeek: dayOfWeek,
                  );
                })
                .toList();

            for (var i = 0; i < weeklyWeather.length; i++) {
              prefs.setString(
                'weeklyWeather$i',
                jsonEncode(weeklyWeather[i].toJson()),
              );
            }

            notifyListeners();
            isWeeklyWeatherFetched =
                true; // Set the flag to indicate weather data is fetched
          }
        }
      } else {
      }
    } catch (error) {
    }
  }
}

class HourlyWeather {
  final String time;
  final String hourimageName;
  final int hourtemperature;

  HourlyWeather({
    required this.time,
    required this.hourimageName,
    required this.hourtemperature,
  });

  factory HourlyWeather.fromJson(Map<String, dynamic> json) {
    return HourlyWeather(
      time: json['time'],
      hourimageName: json['hourimageName'],
      hourtemperature: json['hourtemperature'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'time': time,
      'hourimageName': hourimageName,
      'hourtemperature': hourtemperature,
    };
  }
}

class WeatherDay {
  final String imageName;
  final int iptemperature;
  final String dayOfWeek;

  WeatherDay({
    required this.iptemperature,
    required this.imageName,
    required this.dayOfWeek,
  });

  factory WeatherDay.fromJson(Map<String, dynamic> json) {
    return WeatherDay(
      iptemperature: json['iptemperature'],
      imageName: json['imageName'],
      dayOfWeek: json['dayOfWeek'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'iptemperature': iptemperature,
      'imageName': imageName,
      'dayOfWeek': dayOfWeek,
    };
  }
}



 class FaraheitModel {
  int temperature; // Celsius

  FaraheitModel(this.temperature);

  double calculateFahrenheit() {
    return this.temperature * 9 / 5 + 32;

  
  }
}
