import 'package:cloudy/const.dart';
import 'package:cloudy/homescreen_pages/page1.dart';
import 'package:cloudy/homescreen_pages/page2.dart';
import 'package:cloudy/homescreen_pages/page3.dart';
import 'package:cloudy/homescreen_pages/page4.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';

class homescreen extends StatefulWidget {
  const homescreen({Key? key}) : super(key: key);

  @override
  State<homescreen> createState() => _homescreenState();
}

class _homescreenState extends State<homescreen> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const page1(),
    const Page2(),
    const page3(),
    const page4(),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(15.r)),
          height: 68.h,
          child: GNav(
            gap: 8,
            activeColor: Colors.white,
            tabBackgroundColor: kPrimaryClr,
            tabBorderRadius: 13.r,
            tabs: [
              GButton(
                icon: IconlyLight.home,
                iconSize: 24.sp,
                iconActiveColor: Colors.white,
                iconColor: kPrimaryClr,
                text: "Home",
                textStyle: TextStyle(fontSize: 12.sp, color: Colors.white),
                padding:
                    EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
              ),
              GButton(
                icon: LineIcons.search,
                iconSize: 24,
                iconActiveColor: Colors.white,
                iconColor: kPrimaryClr,
                text: "Search",
                textStyle: TextStyle(fontSize: 12.sp, color: Colors.white),
                padding:
                    EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
              ),
              GButton(
                icon: IconlyLight.bookmark,
                iconSize: 24.sp,
                iconActiveColor: Colors.white,
                iconColor: kPrimaryClr,
                text: "Bookmark",
                textStyle: TextStyle(fontSize: 12.sp, color: Colors.white),
                padding:
                    EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
              ),
              GButton(
                icon: IconlyLight.profile,
                iconSize: 24.sp,
                iconActiveColor: Colors.white,
                iconColor: kPrimaryClr,
                text: "Profile",
                textStyle: TextStyle(fontSize: 12.sp, color: Colors.white),
                padding:
                    EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
              ),
            ],
            selectedIndex: _selectedIndex,
            onTabChange: (index) {
              setState(() {
                _selectedIndex = index;
              });
            },
          ),
        ),
        body: _pages[_selectedIndex],
      ),
    );
  }
}
