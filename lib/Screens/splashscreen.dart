import 'dart:async';

import 'package:cloudy/Screens/getstarted.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
    void initState() {
    super.initState();

    // Add a delay using Timer to control splash screen duration
    Timer(Duration(seconds: 3), () {
      // Navigate to the main part of your app
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => GetStarted()),
      );
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: SafeArea(child: Center(
        child: Column(
        
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            
            Container(
              height: 200,
              
              child: Lottie.asset("images/FIRST.json")),
            Text("Cloudy",style: GoogleFonts.syncopate(fontSize: 27.sp, fontWeight: FontWeight.w700)),
            SizedBox(height: 20.h,),

            Text("A final year  by Pixel(BU19CIT1034)",style: GoogleFonts.poppins(fontWeight: FontWeight.bold),)

            
          ],
        ),
      )),
    );
  }
}