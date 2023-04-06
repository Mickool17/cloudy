import 'package:cloudy/homescreen.dart';
import 'package:cloudy/homescreen_pages/page1_viewmodel.dart';
import 'package:cloudy/homescreen_pages/page3.dart';
import 'package:cloudy/widgets/rainfall_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:stacked/stacked.dart';

class page1 extends StatefulWidget {
  const page1({
    super.key,
  });

  @override
  _page1State createState() => _page1State();
}

class _page1State extends State<page1> {
  // String temperature = '';
  // String Moment = "";
  // String weathericony = "";

  // Future<void> _getTemperature() async {
  //   final apiKey = '1ff1b236a7714ad29e5160802230104';
  //   final apiUrl =
  //       'http://api.weatherapi.com/v1/current.json?key=$apiKey&q=Lagos';

  //   final response = await http.get(Uri.parse(apiUrl));

  //   if (response.statusCode == 200) {
  //     final data = jsonDecode(response.body);
  //     final temp = data['current']['temp_c'];
  //     final conditiontext = data['current']['condition']['text'];
  //     final conditionicon = data['current']['condition']['icon'];
  //     setState(() {
  //       // Moment = '$conditiontext\u00B0';
  //       Moment = conditiontext;
  //     });
  //     setState(() {
  //       temperature = '$temp\u00B0';
  //     });
  //     setState(() {
  //       weathericony = '$conditionicon\u00B0';
  //     });
  //   } else {
  //     throw Exception('Failed to load temperature');
  //   }
  // }

  // @override
  // void initState() {
  //   super.initState();
  //   _getTemperature();
  // }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<Page1ViewModel>.reactive(
        viewModelBuilder: () => Page1ViewModel(),
        onViewModelReady: (p1) {
          p1.setInitialised(true);
          p1.getTemperature();
        },
        builder: (context, model, child) {
          return Scaffold(
            body: SingleChildScrollView(
              child: SafeArea(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Container(
                                height: 40.11,
                                width: 38,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Image.asset("images/profilepic.png"),
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              Column(
                                crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Olaide Yussuf",
                                    style: GoogleFonts.poppins(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    "Lagos, Nigeria",
                                    style: GoogleFonts.poppins(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          InkWell(
                              onTap: (() {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: ((context) =>
                                            (homescreen()))));
                              }),
                              child: Image.asset("images/Dashboard.png")),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 50, horizontal: 20),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Opacity(
                          opacity: 0.3,
                          child: Text(
                            "Today’s report",
                            style: GoogleFonts.poppins(
                                fontSize: 24, fontWeight: FontWeight.w800),
                          ),
                        ),
                      ),
                    ),
                    // Image.network(
                    //     "//cdn.weatherapi.com/weather/64x64/day/119.png"),
                    Image.network(
  model.weathericony,
  scale: 1.0,
),

                    const SizedBox(height: 20),
                    Text(
                      model.Moment,
                      style: GoogleFonts.poppins(fontSize: 25),
                    ),
                    Text(
                      model.temperature,
                      style: GoogleFonts.poppins(fontSize: 50.sp),
                    ),
                    model.Moment == 'Partly cloudy'
                        ? Rainfall(
                            viewModel: model,
                          )
                        : Text('Not working'),
                    SizedBox(
                      height: 25.sp,
                    ),
                 
                    Column(
                      // mainAxisAlignment: MainAxisAlignment.center,
                      // crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              "TIME",
                              style: GoogleFonts.poppins(fontSize: 20.sp),
                            ),
                            Text(
                              "UV",
                              style: GoogleFonts.poppins(fontSize: 20.sp),
                            ),
                            Text(
                              "%RAIN",
                              style: GoogleFonts.poppins(fontSize: 20.sp),
                            ),
                            Text(
                              "AQ",
                              style: GoogleFonts.poppins(fontSize: 20.sp),
                            ),
                          ],
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              "11:25AM",
                              style: GoogleFonts.poppins(fontSize: 16.sp),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 20),
                              child: Text(
                                "4",
                                style: GoogleFonts.poppins(fontSize: 16.sp),
                                textAlign: TextAlign.end,
                              ),
                            ),
                            Text(
                              "58%",
                              style: GoogleFonts.poppins(fontSize: 16.sp),
                            ),
                            Text(
                              "22",
                              style: GoogleFonts.poppins(fontSize: 16.sp),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Container(
                      height: 229.h,
                      width: 327.w,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 5,
                            blurRadius: 10,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Padding(
                        padding:  EdgeInsets.symmetric(
                            horizontal: 30.w, vertical: 10.h),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "SUNRISE & SUNSET",
                              style: GoogleFonts.poppins(
                                fontSize: 15,
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Center(
                                child: Image.asset("images/sunny_day.png")),
                            Text(
                              "Length of day: 13H 12M",
                              style: GoogleFonts.poppins(
                                fontSize: 10,
                              ),
                            ),
                            Text(
                              "Remaining daylight : 9H 22M",
                              style: GoogleFonts.poppins(
                                fontSize: 10,
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }
}
