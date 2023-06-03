import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Page1holder extends StatefulWidget {
  const Page1holder({super.key});

  @override
  State<Page1holder> createState() => _Page1holderState();
}

class _Page1holderState extends State<Page1holder> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(children: [
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 20),
        child: Align(
            alignment: Alignment.centerLeft,
            child: Container(
              height: 10,
              width: 100,
              color: Colors.black,
            )),
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            color: Colors.black,
            height: 10,
            width: 100,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                color: Colors.black,
                height: 200,
                width: 100,
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Container(
              color: Colors.black,
              height: 200,
              width: 100,
            ),
          ),
          Container(
            color: Colors.black,
            height: 200,
            width: 100,
          ),
          SizedBox(
            height: 25.sp,
          ),
          Container(
            color: Colors.black,
            height: 400,
            width: 100,
          ),
          SizedBox(
            height: 30.sp,
          ),
          Container(
            color: Colors.black,
            height: 500,
            width: 500,
          ),
        ],
      ),
    ]));
  }
}
