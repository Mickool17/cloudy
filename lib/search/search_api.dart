import 'dart:convert';
import 'package:cloudy/search/weatherdata.dart';
import 'package:http/http.dart' as http;

class WeatherApi {
  static const String apiKey = '1ff1b236a7714ad29e5160802230104';
  static const String baseUrl = 'http://api.weatherapi.com/v1/current.json';

  static Future<WeatherData> fetchWeatherData(String query) async {
    final url = '$baseUrl?key=$apiKey&q=$query';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      return WeatherData.fromJson(json);
    } else {
      throw Exception('Failed to load weather data');
    }
  }
   static Future<List<String>> fetchLocationSuggestions(String query) async {
    final url = 'http://api.weatherapi.com/v1/search.json?key=$apiKey&q=$query';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      List<dynamic> json = jsonDecode(response.body);
      List<String> suggestions = json.map<String>((location) => location['name'].toString()).toList();
      return suggestions;
    } else {
      throw Exception('Failed to load location suggestions');
    }
  }
}

