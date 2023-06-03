import 'package:cloudy/const.dart';
import 'package:cloudy/screens/page1.dart';
import 'package:cloudy/screens/page4.dart';
import 'package:cloudy/search/searchbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({Key? key}) : super(key: key);

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
  
  const Page1(),
 WeatherSearchPage(),
    
  const Page4(),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 50,vertical: 20),
          child: GNav(
            gap: 3,
            
            activeColor: Colors.white,
            tabBackgroundColor: Colors.black,
            tabBorderRadius: 13.r,
            tabs: [
              GButton(
                icon: IconlyLight.home,
                iconSize: 24.sp,
                iconActiveColor: Colors.white,
              
                text: "Home",
                textStyle: TextStyle(fontSize: 12.sp, color: Colors.white),
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                haptic: true,
                style: GnavStyle.google,
              ),
              GButton(
                haptic: true,
                icon: LineIcons.search,
                iconSize: 24,
                iconActiveColor: Colors.white,
                style: GnavStyle.google,
                text: "Search",
                textStyle: TextStyle(fontSize: 12.sp, color: Colors.white),
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
              ),
          
              GButton(
                icon: IconlyLight.setting,
                iconSize: 24.sp,
                iconActiveColor: Colors.white,
                style: GnavStyle.google,
                text: " Settings",
                textStyle: TextStyle(fontSize: 12.sp, color: Colors.white),
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                haptic: true,
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
        body: AnimatedSwitcher(
          duration: const Duration(milliseconds: 500),
          child: _pages[_selectedIndex],
        ),
      ),
    );
  }
}
