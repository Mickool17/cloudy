import 'package:cloudy/Screens/homescreen.dart';
import 'package:cloudy/Screens/no_connection.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

class GetStarted extends StatefulWidget {
  const GetStarted({super.key});

  @override
  State<GetStarted> createState() => _GetStartedState();
}

// ignore: camel_case_types

// ignore: camel_case_types
class _GetStartedState extends State<GetStarted> {
  bool isConnected = false;

  @override
  void initState() {
    super.initState();
    checkConnectivity();
  }

  Future<void> checkConnectivity() async {
    final result = await Connectivity().checkConnectivity();
    setState(() {
      isConnected = result != ConnectivityResult.none;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
  
      body: Stack(
        children: [
       
           Positioned(
            top: 200,
            left: 80,
            child: SizedBox(
              height: 200.h,
              child: Lottie.asset("images/oneclick.json")),
          ),
          Positioned(
            top: 450.sp,
            left: 61.sp,
            child: Text(
              "Let’s See\nThe\nWeather\nAround you",
              style: GoogleFonts.syncopate(
                  fontSize: 30.sp,
                  fontWeight: FontWeight.bold,
                  ),
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
                  color: Colors.black,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.sp)),
                  onPressed: () {
                    checkConnectivity().then((_) {
                      if (isConnected) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) =>
                                    const Homescreen())); // Replace '/page1' with the desired route for "Page 1"
                      } else {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (_) => const NoConnection()));
                      }
                    });
                  },
                  child: Text(
                    "Get started  ",
                    style: GoogleFonts.syncopate(
                        fontSize: 20.sp,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  height: 15.sp,
                ),
                // GestureDetector(
                //   onTap: (() {
                //     Navigator.push(
                //         context,
                //         MaterialPageRoute(
                //             builder: (context) => const Homescreen()));
                //   }),
                //   child: Text(
                //     "Already have an account? Sign in",
                //     style: GoogleFonts.poppins(
                //         fontSize: 13, fontWeight: FontWeight.w400),
                //   ),
                // )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
