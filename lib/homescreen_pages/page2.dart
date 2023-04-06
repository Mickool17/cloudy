import 'dart:convert';

import 'package:cloudy/const.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

class Page2 extends StatefulWidget {
  const Page2({Key? key}) : super(key: key);

  @override
  State<Page2> createState() => _Page2State();
}

class _Page2State extends State<Page2> {
  List<String> temperatureList = [];
  List<String> momentList = [];
  List<String> weatherIconList = [];

  Future<void> _getTemperature(String location) async {
    final apiKey = '1ff1b236a7714ad29e5160802230104';
    final apiUrl =
        'http://api.weatherapi.com/v1/current.json?key=$apiKey&q=$location';

    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final temp = data['current']['temp_c'];
      final conditiontext = data['current']['condition']['text'];
      final conditionicon = data['current']['condition']['icon'];

      setState(() {
        momentList.add(conditiontext + '\u00B0');
        temperatureList.add(temp.toString() + '\u00B0');
        weatherIconList.add('https:$conditionicon');
      });
    } else {
      throw Exception('Failed to load temperature');
    }
  }

  @override
  void initState() {
    super.initState();
    _getTemperature('lagos');
    _getTemperature('ibadan');
    _getTemperature('abeokuta');
    _getTemperature('ogun state');
    _getTemperature('osun state');
  }

 @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(25.0.r),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Hello Yussuf,',
                      style: GoogleFonts.poppins(
                          fontSize: 25.sp, fontWeight: FontWeight.w700),
                    ),
                    Text(
                      'Discover the weather',
                      style: GoogleFonts.poppins(fontSize: 18.sp),
                    ),
                  ],
                ),
                const Icon(Icons.search_rounded),
              ],
            ),
            SizedBox(
              height: 30.h,
            ),
            Expanded(
              child: ListView(
                children: [
                  _buildContainerWithColumn(
                      context,
                      'Current location',
                      'Lagos',
                      momentList.isNotEmpty ? momentList[0] : '',
                      temperatureList.isNotEmpty ? temperatureList[0] : '',
                      weatherIconList.isNotEmpty ? weatherIconList[0]:''),
                  SizedBox(
                    height: 30.h,
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0.r),
                    child: Text(
                      'Around Nigeria',
                      style: GoogleFonts.poppins(fontSize: 18.sp),
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  _buildContainerWithColumn(
                      context,
                      'Nigeria',
                      'Ibadan',
                      momentList.length > 1 ? momentList[1] : '',
                      temperatureList.length > 1 ? temperatureList[1] : '',
                      weatherIconList.length > 1 ? weatherIconList[1]:''),
                      
                  SizedBox(
                    height: 30.h,
                  ),
                  _buildContainerWithColumn(
                      context,
                      "Nigeria",
                      "Abeokuta",
                      momentList.length > 2 ? momentList[2] : '',
                      temperatureList.length > 2 ? temperatureList[2] : '',
                      weatherIconList.length > 2 ? weatherIconList[2]:''),
                  SizedBox(
                    height: 30.h,
                  ),
                  _buildContainerWithColumn(
                      context,
                      "Nigeria ",
                      "Ogun state",
                      momentList.length > 3 ? momentList[3] : '',
                      temperatureList.length > 3 ? temperatureList[3] : '',
                      weatherIconList.length > 3 ? weatherIconList[3]:''),
                  SizedBox(
                    height: 20.h,
                  ),
                  _buildContainerWithColumn(
                      context,
                      "Nigeria ",
                      "osun state ",
                      momentList.length > 4 ? momentList[4] : '',
                      temperatureList.length > 4 ? temperatureList[4] : '',
                      weatherIconList.length > 4 ? weatherIconList[4]:''),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }


  Widget _buildContainerWithColumn(
  BuildContext context,
  String title1,
  String title2,
  String title3,
  String title4,
  String title5,
) {
  return Container(
    height: 144.h,
    width: 338.w,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(30.r),
      color: kPrimaryClr,
    ),
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 16),
      child: Stack(
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: Text(
              title1,
              style: GoogleFonts.poppins(
                fontSize: 18.sp,
                fontWeight: FontWeight.w400,
                color: Colors.white,
              ),
            ),
          ),

          ///////
          Align(
            alignment: Alignment.topRight,
            child: title5 != null
                ? Image.network(
                    title5,
                    scale: 0.8,
                  )
                : Placeholder(
                  child: Image.asset("images/sunny.png"),
                ),
          ),

          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              title2,
              style: GoogleFonts.poppins(
                fontSize: 28.sp,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
            ),
          ),

          Align(
            alignment: Alignment.bottomLeft,
            child: Text(
              title3,
              style: GoogleFonts.poppins(
                fontSize: 18.sp,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
            ),
          ),

          Align(
            alignment: Alignment.bottomRight,
            child: Text(
              title4,
              style: GoogleFonts.poppins(
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    ),
  );
}


}
