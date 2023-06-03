class WeatherData {
  final double temperature;
  final String moment;
  final dynamic weathericone;
  final String locationname;

  WeatherData(
      {required this.temperature,
      required this.moment,
      required this.weathericone,
      required this.locationname});

  factory WeatherData.fromJson(Map<String, dynamic> json) {
    String iconUrl = "https:${json['current']['condition']['icon']}";
    return WeatherData(
      temperature: json['current']['temp_c'].toDouble(),
      moment: json['current']['condition']['text'].toString(),
      weathericone: iconUrl,
      locationname: json['location']['name'].toString(),
    );
  }
}
