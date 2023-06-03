// ignore_for_file: library_private_types_in_public_api

import 'package:cloudy/const.dart';
import 'package:cloudy/Screens/no_connection.dart';
import 'package:cloudy/models/airqualitymodel.dart';
import 'package:cloudy/models/basemodel.dart';
import 'package:cloudy/models/uvindexmodel.dart';
import 'package:cloudy/widgets/aqslider.dart';
import 'package:cloudy/widgets/uvslider.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:stacked/stacked.dart';
import 'package:cloudy/models/page1_viewmodel.dart';
import '../main.dart';

class Page1 extends StatefulWidget {
  const Page1({Key? key}) : super(key: key);

  @override
  _Page1State createState() => _Page1State();
}

class _Page1State extends State<Page1> {
  bool _isHourly = false;
  bool isConnected = true;
  late final FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    checkConnectivity();
    _focusNode = FocusNode();
  }

  Future<void> checkConnectivity() async {
    final result = await Connectivity().checkConnectivity();
    setState(() {
      isConnected = result != ConnectivityResult.none;
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!isConnected) {
      return const NoConnection(); // Navigate to the NoConnection page
    }
    return ViewModelBuilder<Page1ViewModel>.reactive(
      viewModelBuilder: () => Page1ViewModel(),
      onViewModelReady: (model) {
        model.setInitialised(true);
        model.getTemperature();
      },
      builder: (context, model, child) {
        // final themeProvider = Provider.of<ThemeProvider>(context);
        return Scaffold(
            body: RefreshIndicator(
          onRefresh: model.getTemperature,
          child: SingleChildScrollView(
            child: SafeArea(
              child: Column(children: [
                SizedBox(height: 10.h),
                SizedBox(height: 20.h),
                      Text(
                                      "Todays Report",
                                      style: GoogleFonts.syncopate(fontSize: 18.sp,fontWeight: FontWeight.bold),
                                    ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 200.h,
                      child: StreamBuilder<ConnectivityResult>(
                        stream: Connectivity().onConnectivityChanged,
                        builder: (BuildContext context,
                            AsyncSnapshot<ConnectivityResult> snapshot) {
                          if (snapshot.hasData &&
                              (snapshot.data == ConnectivityResult.mobile ||
                                  snapshot.data == ConnectivityResult.wifi)) {
                            if (model.moment == 'Sunny') {
                              return Lottie.network(
                                'https://assets2.lottiefiles.com/packages/lf20_xlky4kvh.json',
                                fit: BoxFit.cover,
                              );
                            } else if (model.moment == 'Partly cloudy') {
                              return Lottie.network(
                                'https://assets10.lottiefiles.com/packages/lf20_trr3kzyu.json',
                                fit: BoxFit.cover,
                              );
                            } else if (model.moment == 'Moderate') {
                              return Lottie.network(
                                'https://assets9.lottiefiles.com/packages/lf20_xiuakfxs.json',
                                fit: BoxFit.cover,
                              );
                               } else if (model.moment == 'Fog') {
                              return Lottie.network(
                                'https://assets9.lottiefiles.com/temp/lf20_HflU56.jsonll',
                                fit: BoxFit.cover,
                              );
                            } else if (model.weatherIcon.isNotEmpty) {
                              return Image.network(
                                model.weatherIcon,
                                width: 100.w,
                                height: 100.h,
                                scale: 0.1,
                              );
                            }
                          }

                          // Returning a shimmering effect when there's no internet connection
                          return Shimmer.fromColors(
                            baseColor: Colors.grey[300]!,
                            highlightColor: Colors.grey[100]!,
                            child: Container(
                              color: Colors.white,
                              width: 200.w,
                              height: 100.h,
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Flexible(
                      child: Text(
                        model.userLocation,
                        maxLines: 1,
                        style: GoogleFonts.aBeeZee(
                          fontSize: 40.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    SizedBox(width: 5.w),
                    Image.asset(
                      'images/location.png',
                      color: Theme.of(context).dividerColor,
                    ),
                  ],
                ),
                SizedBox(height: 20.h),
                Text(
                  model.moment,
                  style: GoogleFonts.syncopate(fontSize: 25.sp),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Text(
                  '${model.temperature}C',
                  style: GoogleFonts.aBeeZee(fontSize: 50.sp),
                ),
                SizedBox(height: 20.h),
                Container(
                  height: 270.h,
                  width: 300.w,
                  padding: const EdgeInsets.all(16),
                  decoration: const BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(44),
                      topRight: Radius.circular(44),
                    ),
                  ),
                  child: Column(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                _isHourly = false;
                              });
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100.r),
                                color: _isHourly ? Colors.grey : Colors.black,
                              ),
                              height: 42.h,
                              width: 111.w,
                              child: Center(
                                child: Text(
                                  'Hourly',
                                  style:
                                      GoogleFonts.poppins(color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                _isHourly = true;
                              });
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                color: _isHourly ? Colors.black : Colors.grey,
                              ),
                              height: 42.h,
                              width: 111.w,
                              child: Center(
                                child: Text(
                                  'Weekly',
                                  style:
                                      GoogleFonts.poppins(color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 16.h),
                      Expanded(
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: _isHourly
                                ? _buildWeeklyWeatherCards(model)
                                : _buildHourlyWeatherCards(model),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Align(
                      alignment: Alignment.bottomLeft,
                      child: Text(
                        "Environment",
                        style: GoogleFonts.poppins(
                            fontSize: 18.sp, fontWeight: FontWeight.bold),
                      )),
                ),
                SizedBox(
                  height: 10.h,
                ),
                SizedBox(
                  height: 160.h,
                  width: 342.w,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(22),
                      color: kPrimaryClr,
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 20.w, vertical: 20.h),
                      child: Column(
                        children: [
                          Align(
                            alignment: Alignment.topLeft,
                            child: Opacity(
                              opacity: 0.7,
                              child: Row(
                                children: [
                                  const Icon(
                                    Icons.air,
                                    color: Colors.white,
                                  ),
                                  SizedBox(width: 5.w),
                                  Text(
                                    "AIR QUALITY",
                                    style: GoogleFonts.poppins(
                                      color: Colors.white,
                                      fontSize: 15.sp,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: 5.h),
                          Row(
                            children: [
                              Text(
                                model.usEpaIndex.toString(),
                                style: GoogleFonts.poppins(
                                  color: Colors.white,
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              aqcondition(model.usEpaIndex),
                            ],
                          ),
                          SizedBox(height: 5.h),
                          AQIndexSlider(
                            viewModel:
                                AirQualityViewModel(baseModel: BaseModel()),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10.h),
                Row(
                  children: [
                    SizedBox(width: 20.w),
                    Container(
                      height: 164.h,
                      width: 164.w,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(22),
                        color: kPrimaryClr,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 20.h),
                            Opacity(
                              opacity: 0.7,
                              child: Row(
                                children: [
                                  const Icon(
                                    Icons.sunny,
                                    color: Colors.white,
                                  ),
                                  SizedBox(width: 5.w),
                                  Text(
                                    "UV INDEX",
                                    style: GoogleFonts.poppins(
                                      color: Colors.white,
                                      fontSize: 15.sp,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 10.h),
                            Text(
                              model.uv.toString(),
                              style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontSize: 25,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            uvcondition(model.uv),
                            SizedBox(height: 10.h),
                            Align(
                              alignment: Alignment.topLeft,
                              child: UVIndexSlider(
                                viewModel:
                                    UVIndexViewModel(baseModel: BaseModel()),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(width: 10.w),
                    Expanded(
                      child: Container(
                        height: 164.h,
                        width: 164.w,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(22),
                          color: kPrimaryClr,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Align(
                                alignment: Alignment.topLeft,
                                child: Opacity(
                                  opacity: 0.7,
                                  child: Row(
                                    children: [
                                      const Icon(
                                        Icons.sunny,
                                        color: Colors.white,
                                      ),
                                      SizedBox(width: 5.w),
                                      Text(
                                        "SUNRISE",
                                        style: GoogleFonts.poppins(
                                          color: Colors.white,
                                          fontSize: 15.sp,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Text(
                                model.sunrise,
                                style: GoogleFonts.poppins(
                                  color: Colors.white,
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              Container(
                                  height: 2.h, width: 150.w, color: Colors.white),
                              const Spacer(),
                              Row(
                                children: [
                                  Text(
                                    "Sunset: ",
                                    style: GoogleFonts.poppins(
                                        color: Colors.white),
                                  ),
                                  Text(
                                    model.sunset,
                                    style: GoogleFonts.poppins(
                                      color: Colors.white,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 20.w),
                  ],
                ),
                SizedBox(height: 10.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 164.h,
                      width: 164.w,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(22),
                        color: kPrimaryClr,
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: 20.h, horizontal: 20.w),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Align(
                              alignment: Alignment.topLeft,
                              child: Opacity(
                                opacity: 0.7,
                                child: Row(
                                  children: [
                                    const Icon(
                                      Icons.wind_power,
                                      color: Colors.white,
                                    ),
                                    SizedBox(width: 5.w),
                                    Text(
                                      "WIND",
                                      style: GoogleFonts.poppins(
                                        color: Colors.white,
                                        fontSize: 15,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(height: 20.h),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  model.windspeed,
                                  style: GoogleFonts.poppins(
                                      color: Colors.white, fontSize: 40),
                                ),
                                Text(
                                  " km/h",
                                  style:
                                      GoogleFonts.poppins(color: Colors.white),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(width: 10.w),
                    Container(
                      height: 164.h,
                      width: 164.w,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(22),
                        color: kPrimaryClr,
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: 10.h, horizontal: 20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Align(
                              alignment: Alignment.topLeft,
                              child: Opacity(
                                opacity: 0.7,
                                child: Row(
                                  children: [
                                    const Icon(
                                      Icons.thermostat,
                                      color: Colors.white,
                                    ),
                                    SizedBox(width: 5.w),
                                    Text(
                                      "FEELS LIKE",
                                      style: GoogleFonts.poppins(
                                        color: Colors.white,
                                        fontSize: 15.sp,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(height: 10.h),
                            Row(
                              children: [
                                Text(
                                  model.feelsLike,
                                  style: GoogleFonts.poppins(
                                      color: Colors.white, fontSize: 40),
                                ),
                                Text(
                                  ' \u00B0C',
                                  style: GoogleFonts.poppins(
                                      color: Colors.white, fontSize: 20.sp),
                                ),
                              ],
                            ),
                            Text(
                              "Similar to the actual temperature.",
                              style: GoogleFonts.poppins(
                                  color: Colors.white, fontSize: 10.sp),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 164.h,
                      width: 164.w,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(22),
                        color: kPrimaryClr,
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: 20.h, horizontal: 20.w),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Align(
                              alignment: Alignment.topLeft,
                              child: Row(
                                children: [
                                  Opacity(
                                    opacity: 0.7,
                                    child: Row(
                                      children: [
                                        const Icon(
                                          Icons.warning,
                                          color: Colors.white,
                                        ),
                                        SizedBox(width: 5.w),
                                        Text(
                                          " PRESSURE",
                                          style: GoogleFonts.poppins(
                                            color: Colors.white,
                                            fontSize: 15,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 20.h),
                            Text(
                              model.pressure,
                              style: GoogleFonts.poppins(
                                  color: Colors.white, fontSize: 40),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(width: 10.w),
                    Container(
                      height: 164.h,
                      width: 164.w,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(22),
                        color: kPrimaryClr,
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: 10.h, horizontal: 20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Align(
                              alignment: Alignment.topLeft,
                              child: Row(
                                children: [
                                  Opacity(
                                    opacity: 0.7,
                                    child: Row(
                                      children: [
                                        const Icon(
                                          Icons.water,
                                          color: Colors.white,
                                        ),
                                        SizedBox(width: 5.w),
                                        Text(
                                          "HUMIDITY",
                                          style: GoogleFonts.poppins(
                                            color: Colors.white,
                                            fontSize: 15.sp,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 10.h),
                            Text(
                              model.humidity,
                              style: GoogleFonts.poppins(
                                  color: Colors.white, fontSize: 40.sp),
                            ),
                            Row(
                              children: [
                                Text(
                                  "The dew point is ",
                                  style: GoogleFonts.poppins(
                                      color: Colors.white, fontSize: 13.sp),
                                ),
                                Text(
                                  '${model.dewPoint}',
                                  style: GoogleFonts.poppins(
                                      color: Colors.white, fontSize: 13.sp),
                                ),
                              ],
                            ),
                            Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                "right now",
                                style: GoogleFonts.poppins(
                                    color: Colors.white, fontSize: 13.sp),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ]),
            ),
          ),
        ));
      },
    );
  }

  List<Widget> _buildHourlyWeatherCards(Page1ViewModel model) {
    return model.hourlyWeather.map((weatherHour) {
      return Container(
        margin: const EdgeInsets.only(right: 12),
        height: 146.h,
        width: 60.w,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Theme.of(context).dividerColor, width: 3.0),
        ),
        child: Column(
          children: [
            SizedBox(height: 10.h),
            Text(
              weatherHour.time,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w700,
                  ),
            ),
            SizedBox(height: 15.h),
            Visibility(
              visible: weatherHour.hourimageName.isNotEmpty,
              replacement: Container(
                width: 48.w,
                height: 48.h,
                color: Colors
                    .grey, // Replace with the desired color for the container
              ),
              child: Image.network(
                weatherHour.hourimageName,
                width: 48.w,
                height: 48.h,
              ),
            ),
            SizedBox(height: 19.h),
            Text(
              '${weatherHour.hourtemperature.toString()}°C',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w700,
                  ),
            ),
          ],
        ),
      );
    }).toList();
  }

  List<Widget> _buildWeeklyWeatherCards(Page1ViewModel model) {
    return model.weeklyWeather.map((weatherDay) {
      return Container(
        margin: const EdgeInsets.only(right: 12),
        height: 146.h,
        width: 60.w,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Theme.of(context).dividerColor, width: 3.0),
        ),
        child: Column(
          children: [
            SizedBox(height: 10.h),
            Text(
              weatherDay.dayOfWeek,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w700,
                  ),
            ),
            SizedBox(height: 15.h),
            Image.network(
              weatherDay.imageName,
              width: 48.w,
              height: 48.h,
            ),
            SizedBox(height: 19.h),
            Text(
              '${weatherDay.iptemperature}°C',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w700,
                  ),
            ),
          ],
        ),
      );
    }).toList();
  }
}

Widget uvcondition(double uvValue) {
  if (uvValue == 0 || uvValue == 1 || uvValue == 2) {
    return const Text(
      "Low",
      style: TextStyle(color: Colors.white, fontSize: 20),
    );
  } else if (uvValue == 3 || uvValue == 4 || uvValue == 5) {
    return const Text(
      "Moderate",
      style: TextStyle(color: Colors.white, fontSize: 20),
    );
  } else if (uvValue == 6 || uvValue == 7) {
    return const Text(
      "High",
      style: TextStyle(color: Colors.white),
    );
  } else if (uvValue == 8 || uvValue == 9 || uvValue == 10) {
    return const Text(
      "Very High",
      style: TextStyle(color: Colors.white, fontSize: 20),
    );
  } else if (uvValue > 11) {
    return const Text(
      "Extreme",
      style: TextStyle(color: Colors.white, fontSize: 20),
    );
  } else {
    return const Text("");
  }
}

Widget aqcondition(aqValue) {
  if (aqValue == 1) {
    return const Text(
      " - Good",
      style: TextStyle(color: Colors.white, fontSize: 20),
    );
  } else if (aqValue == 2) {
    return const Text(
      " - Moderate",
      style: TextStyle(color: Colors.white, fontSize: 20),
    );
  } else if (aqValue == 3) {
    return const Text(
      " - Unhealthy for sensitive groups",
      style: TextStyle(color: Colors.white),
    );
  } else if (aqValue == 4) {
    return const Text(
      " - Unhealthy",
      style: TextStyle(color: Colors.white, fontSize: 20),
    );
  } else if (aqValue == 5) {
    return const Text(
      " - Very Unhealthy",
      style: TextStyle(color: Colors.white, fontSize: 20),
    );
  } else if (aqValue == 6) {
    return const Text(
      " - Extreme",
      style: TextStyle(color: Colors.white, fontSize: 20),
    );
  } else {
    return (const Text(""));
  }
}
