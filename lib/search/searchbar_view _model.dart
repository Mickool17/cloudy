import 'dart:convert';

import 'package:connectivity/connectivity.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked/stacked.dart';
import 'package:http/http.dart' as http;

class SearchViewModel extends BaseViewModel {
  
  String _searchQuery = '';

  String get searchQuery => _searchQuery;

  void setSearchQuery(String value) {
    _searchQuery = value;
    print('Search Query Updated: $_searchQuery'); // Add print statement
    notifyListeners();
  }
  // ...

  void updateSearchQuery(String searchQuery) {
    setSearchQuery(searchQuery);
    print('Updated Search Query: $searchQuery'); // Add print statement
  }

  //  String animal = '';
  // String temperature = '';
  // String moment = '';
  // String userLocation = '';
  // dynamic weatherIcon = '';
  String searchairQuality = '';
  String time = '';
  int searchusEpaIndex = 0;
  double searchuv = 0.0;
  String searchsunrise = '';
  String searchsunset = '';
  String searchwindspeed = '';
  String searchfeelsLike = '';
  String searchhumidity = '';
  String searchpressure = '';
  int searchdewPoint = 0;

  final apiKey = '1ff1b236a7714ad29e5160802230104';

  String get apiUrlTemplate =>
      'http://api.weatherapi.com/v1/current.json?key=$apiKey&q=$_searchQuery&aqi=yes';

  static SearchViewModel? _instance;

  static SearchViewModel get instance {
    _instance ??= SearchViewModel();
    return _instance!;
  }

  SearchViewModel() {
    getSearchWeatherDetails();
  }

  Future<void> getSearchWeatherDetails() async {
    final prefs = await SharedPreferences.getInstance();
    final cachedWeatherData = prefs.getString('weatherSearchData');

    if (cachedWeatherData != null) {
      final weatherData = jsonDecode(cachedWeatherData);
      updateWeatherData(weatherData);
    }

    final apiUrl = apiUrlTemplate;

    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      updateWeatherData(data);
      prefs.setString('weatherSearchData', jsonEncode(data));
    } else {
      throw Exception('Failed to load searchtemperature');
    }
  }

  void updateWeatherData(Map<String, dynamic> data) {
    final airQualityData = data['current']['air_quality'];
    final uvValue = data['current']['uv'];
    final sunriseData = data['forecast']['forecastday'][0]['astro']['sunrise'];
    final sunsetData = data['forecast']['forecastday'][0]['astro']['sunset'];
    final windSpeedData = data['current']['wind_kph']?.toString() ?? '';
    final feelsLikeddata = data['current']['feelslike_c']?.toString() ?? '';
    final humidityData = data['current']['humidity']?.toString() ?? '';
    final pressureData = data['current']['pressure_mb']?.toString() ?? '';

    searchairQuality = airQualityData.toString();
    searchusEpaIndex = airQualityData.containsKey('us-epa-index')
        ? airQualityData['us-epa-index']
        : 0;
    searchuv = uvValue?.toDouble() ?? 0.0;
    searchsunrise = sunriseData?.toString() ?? '';
    searchsunset = sunsetData?.toString() ?? '';
    searchwindspeed = windSpeedData;
    searchfeelsLike = feelsLikeddata;
    searchhumidity = humidityData;
    searchpressure = pressureData;

    notifyListeners();
  }
}