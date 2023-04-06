import 'package:cloudy/homescreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_icons/line_icon.dart';
import 'package:material_design_icons_flutter/icon_map.dart';

class page4 extends StatelessWidget {
  const page4({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 26.w, vertical: 37.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: ((context) => homescreen())));
                  },
                  child: Icon(
                    Icons.arrow_back_ios_new_sharp,
                    size: 18.sp,
                  ),
                ),
                InkWell(
                    onTap: (() {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: ((context) => homescreen())));
                    }),
                    child: Image.asset("images/Dashboard.png"))
              ],
            ),
          ),
          SizedBox(
            height: 37.h,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Align(
              alignment: Alignment.topLeft,
              child: SizedBox(
                child: Text(
                  'General Settings',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w500,
                    fontSize: 20.sp,
                    height: 1.105.h,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 30.h,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Align(
              alignment: Alignment.topLeft,
              child: Column(
                children: [
                  InkWell(
                    onTap: () {},
                    child: Row(
                      children: [
                        Icon(
                          Icons.person,
                          size: 18.sp,
                        ),
                        SizedBox(
                          width: 10.w,
                        ),
                        SizedBox(
                          height: 24.h,
                          child: Text(
                            "Account",
                            style: GoogleFonts.poppins(
                                fontSize: 18.sp, fontWeight: FontWeight.w400),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 16.h,
                  ),
                  Row(
                    children: [
                      Icon(Icons.location_on_sharp, size: 18.sp),
                      SizedBox(width: 10.w),
                      Text(
                        "Location",
                        style: GoogleFonts.poppins(
                            fontSize: 18, fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 16.h,
                  ),
                  Row(
                    children: [
                      Icon(IconlyBold.notification, size: 18.sp),
                      SizedBox(width: 10.w),
                      Text(
                        "Notifications",
                        style: GoogleFonts.poppins(
                            fontSize: 18, fontWeight: FontWeight.w400),
                      ),
                      const Spacer(),
                      Icon(
                        Icons.notifications_off_sharp,
                        size: 18.sp,
                        color: Colors.red,
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 37.h,
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 20.w,
            ),
            child: Align(
              alignment: Alignment.topLeft,
              child: Text(
                'Temperature',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w500,
                  fontSize: 20.sp,
                  height: 1.105.h,
                  color: Colors.black,
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 22.w, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      "Celsius",
                      style: GoogleFonts.poppins(
                          fontSize: 18, fontWeight: FontWeight.w400),
                    ),
                    const Spacer(),
                    Container(
                      height: 24.h,
                      width: 24.w,
                      decoration: const BoxDecoration(
                        color: Colors.green,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.check,
                        color: Colors.white,
                        size: 16.sp,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16.h),
                Row(
                  children: [
                    Text(
                      "Fahrenheit",
                      style: GoogleFonts.poppins(
                          fontSize: 18.sp, fontWeight: FontWeight.w400),
                    ),
                    const Spacer(),
                    Container(
                      height: 24.h,
                      width: 24.w,
                      decoration: const BoxDecoration(
                        color: Colors.green,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.check,
                        color: Colors.white,
                        size: 16.sp,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 30.h),
            child: Align(
              alignment: Alignment.topLeft,
              child: Column(
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.description_sharp,
                        size: 18.sp,
                      ),
                      SizedBox(
                        width: 10.w,
                      ),
                      SizedBox(
                        height: 24.h,
                        child: Text(
                          "terms and services",
                          style: GoogleFonts.poppins(
                              fontSize: 18.sp, fontWeight: FontWeight.w400),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 16.h,
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.info_outline,
                        size: 18.sp,
                      ),
                      SizedBox(
                        width: 10.h,
                      ),
                      SizedBox(
                        height: 24.h,
                        child: Text(
                          "About",
                          style: GoogleFonts.poppins(
                              fontSize: 18.sp, fontWeight: FontWeight.w400),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 16.h,
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.bug_report,
                        size: 18.sp,
                      ),
                      SizedBox(
                        width: 10.w,
                      ),
                      SizedBox(
                        height: 24.h,
                        child: Text(
                          "Report buggy buggy",
                          style: GoogleFonts.poppins(
                              fontSize: 18.sp, fontWeight: FontWeight.w400),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ));
  }
}
