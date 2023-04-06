import 'dart:convert';
import 'package:http/http.dart' as http;

final apiKey = ' 1ff1b236a7714ad29e5160802230104';
final apiUrl = 'http://api.weatherapi.com/v1=$apiKey';

Future<double> getLagosTemperature() async {
  final response = await http.get(Uri.parse(apiUrl));
  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    final temperature = data['main']['temp'] - 273.15; // Convert from Kelvin to Celsius
    return temperature;
  } else {
    throw Exception('Failed to retrieve temperature data');
  }
}
