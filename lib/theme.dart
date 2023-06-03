import 'package:cloudy/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

// ignore: camel_case_types
class cloudytheme extends StatelessWidget {
  const cloudytheme({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return SafeArea(
      child: Scaffold(
     
        body: Column(
          
          children: [
            SizedBox(height: 80.h,),
            ListTile(
              title: const Text('System Settings'),
              leading: Radio<ThemeModeOption>(
                value: ThemeModeOption.system,
                groupValue: themeProvider.themeModeOption,
                onChanged: (value) => themeProvider.setThemeModeOption(value!),
              ),
            ),
            ListTile(
              title: const Text('Light Mode'),
              leading: Radio<ThemeModeOption>(
                value: ThemeModeOption.light,
                groupValue: themeProvider.themeModeOption,
                onChanged: (value) => themeProvider.setThemeModeOption(value!),
              ),
            ),
            ListTile(
              title: const Text('Dark Mode'),
              leading: Radio<ThemeModeOption>(
                value: ThemeModeOption.dark,
                groupValue: themeProvider.themeModeOption,
                onChanged: (value) => themeProvider.setThemeModeOption(value!),
              ),
            ),
          ],
        ),
      ),
    );
  }
}