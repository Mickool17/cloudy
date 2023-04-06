import 'dart:convert';

import 'package:stacked/stacked.dart';
import 'package:http/http.dart' as http;

class BaseModel extends BaseViewModel {
  String temperature = '';
  String Moment = "";
  dynamic weathericony = "";

  Future<void> getTemperature() async {
    final apiKey = '1ff1b236a7714ad29e5160802230104';
    final apiUrl =
        'http://api.weatherapi.com/v1/current.json?key=$apiKey&q=Lagos';

    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final temp = data['current']['temp_c'];
      final conditiontext = data['current']['condition']['text'];
      final conditionicon = data['current']['condition']['icon'];

      // Moment = '$conditiontext\u00B0';
      Moment = conditiontext;
      temperature = '$temp\u00B0';
      weathericony = 'https:$conditionicon';
      // weathericony = conditionicon;
      notifyListeners();
    } else {
      throw Exception('Failed to load temperature');
    }
  }
}
