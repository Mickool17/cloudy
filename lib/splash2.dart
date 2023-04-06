import 'package:cloudy/const.dart';
import 'package:cloudy/homescreen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class splash2 extends StatefulWidget {
  const splash2({super.key});

  @override
  State<splash2> createState() => _splash2State();
}

// ignore: camel_case_types
class _splash2State extends State<splash2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Align(
            alignment: Alignment.topRight,
            child: Positioned(
                height: 343.h,
                width: 343.sp,
                top: -137.h,
                left: 162.w,
                child: Image.asset('images/splash2_star.png')),
          ),
          Positioned(
            //bottom: 70.sp,
            top: 312.sp,
            left: 61.sp,

            child: Column(
              children: [
                Text("Let’s See\nThe\nWeather\nAround you",
                    style: GoogleFonts.poppins(
                        fontSize: 42.sp,
                        fontWeight: FontWeight.w700,
                        color: kPrimaryClr)),
              ],
            ),
          ),
          Positioned(
            top: 673.h,
            left: 42.w,
            child: Column(
              children: [
                MaterialButton(
                  height: 62.h,
                  minWidth: 291.w,
                  color: kPrimaryClr,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.sp)),
                  onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => homescreen()),
                );},
                  child: Text(
                    "Get started  ",
                    style: GoogleFonts.poppins(
                        fontSize: 20.sp,
                        color: Colors.white,
                        fontWeight: FontWeight.w400),
                  ),
                ),
                SizedBox(
                  height: 15.sp,
                ),
                Text(
                  "Already have an account? Sign in",
                  style: GoogleFonts.poppins(
                      fontSize: 13, fontWeight: FontWeight.w400),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
