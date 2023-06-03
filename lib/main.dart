import 'package:cloudy/Screens/splashscreen.dart';
import 'package:cloudy/screens/getstarted.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  ErrorWidget.builder = (FlutterErrorDetails details) => Container();
  runApp(const MyApp());
}

enum ThemeModeOption {
  system,
  light,
  dark,
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return ChangeNotifierProvider<ThemeProvider>(
          create: (context) {
            final themeProvider = ThemeProvider();
            themeProvider.loadThemeMode();
            return themeProvider;
          },
          child: Consumer<ThemeProvider>(
            builder: (context, themeProvider, _) {
              return MaterialApp(
                debugShowCheckedModeBanner: false,
                title: 'First Method',
                theme: themeProvider
                    .getTheme(ThemeModeOption.light), // set the light theme
                darkTheme: themeProvider
                    .getTheme(ThemeModeOption.dark), // set the dark theme
                themeMode: themeProvider
                    .getThemeMode(), // let Flutter decide which one to use
                home: const SplashScreen(),
              );
            },
          ),
        );
      },
    );
  }
}

class ThemeProvider extends ChangeNotifier {
  ThemeModeOption _themeModeOption = ThemeModeOption.system;

  ThemeModeOption get themeModeOption => _themeModeOption;

  Future<void> loadThemeMode() async {
    final prefs = await SharedPreferences.getInstance();
    _themeModeOption = ThemeModeOption.values[prefs.getInt('ThemeMode') ?? 0];
    notifyListeners();
  }

  Future<void> setThemeModeOption(ThemeModeOption option) async {
    _themeModeOption = option;
    final prefs = await SharedPreferences.getInstance();
    prefs.setInt('ThemeMode', option.index);
    notifyListeners();
  }

  ThemeData getTheme(ThemeModeOption option) {
    switch (option) {
      case ThemeModeOption.light:
        return lightTheme;
      case ThemeModeOption.dark:
        return darkTheme;
      case ThemeModeOption.system:
      default:
        return ThemeData.light(); // You can set the system default theme here
    }
  }

  ThemeMode getThemeMode() {
    switch (_themeModeOption) {
      case ThemeModeOption.system:
        return ThemeMode.system;
      case ThemeModeOption.light:
        return ThemeMode.light;
      case ThemeModeOption.dark:
        return ThemeMode.dark;
    }
  }
}

final lightTheme = ThemeData(
  primaryColor: Colors.black,
  textTheme: const TextTheme(
    displayLarge: TextStyle(
      color: Colors.black,
      fontSize: 24,
      fontWeight: FontWeight.bold,
    ),
    bodyLarge: TextStyle(
      color: Colors.black,
      fontSize: 16,
    ),
  ),
  colorScheme: ColorScheme.fromSwatch(
    primarySwatch: Colors.blue,
  ).copyWith(
    secondary: Colors.red,
  ),
  inputDecorationTheme: InputDecorationTheme(
    focusedBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: Colors.black),
      borderRadius: BorderRadius.circular(15),
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: Colors.black),
      borderRadius: BorderRadius.circular(15),
    ),
    errorBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: Colors.black),
      borderRadius: BorderRadius.circular(15),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: Colors.black),
      borderRadius: BorderRadius.circular(15),
    ),
    disabledBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: Colors.black),
      borderRadius: BorderRadius.circular(15),
    ),
    border: OutlineInputBorder(
      borderSide: const BorderSide(color: Colors.black),
      borderRadius: BorderRadius.circular(15),
    ),
  ),
    // Define the colors and other properties for your light mode theme
    );

final darkTheme = ThemeData.dark().copyWith(
  primaryColor: Colors.blue,
  textTheme: const TextTheme(
    displayLarge: TextStyle(
      color: Colors.white,
      fontSize: 24,
      fontWeight: FontWeight.bold,
    ),
    bodyLarge: TextStyle(
      color: Colors.white,
      fontSize: 16,
    ),
  ),
  colorScheme: ColorScheme.fromSwatch(
    primarySwatch: Colors.blue,
  ).copyWith(
    secondary: Colors.red,
  ),
  inputDecorationTheme: InputDecorationTheme(
    focusedBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: Colors.white),
      borderRadius: BorderRadius.circular(15),
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: Colors.white),
      borderRadius: BorderRadius.circular(15),
    ),
    errorBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: Colors.white),
      borderRadius: BorderRadius.circular(15),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: Colors.white),
      borderRadius: BorderRadius.circular(15),
    ),
    disabledBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: Colors.white),
      borderRadius: BorderRadius.circular(15),
    ),
    border: OutlineInputBorder(
      borderSide: const BorderSide(color: Colors.white),
      borderRadius: BorderRadius.circular(15),
    ),
  ),
);
