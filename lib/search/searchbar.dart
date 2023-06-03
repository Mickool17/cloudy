import 'package:cloudy/const.dart';
import 'package:cloudy/models/airqualitymodel.dart';
import 'package:cloudy/models/basemodel.dart';
import 'package:cloudy/models/uvindexmodel.dart';
import 'package:cloudy/screens/page1.dart';
import 'package:cloudy/search/searchdetails.dart';
import 'package:cloudy/search/weatherdata.dart';
import 'package:cloudy/widgets/aqslider.dart';
import 'package:cloudy/widgets/uvslider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:stacked/stacked.dart';

import 'search_api.dart';
import 'searchbar_view _model.dart';

class WeatherSearchPage extends StatefulWidget {
  const WeatherSearchPage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _WeatherSearchPageState createState() => _WeatherSearchPageState();
}

class _WeatherSearchPageState extends State<WeatherSearchPage> {
  
  String _searchQuery = '';
  WeatherData? _weatherData;

  Future<List<String>> _getLocationSuggestions(String pattern) async {
    try {
      return await WeatherApi.fetchLocationSuggestions(pattern);
    } catch (e) {
      return [];
    }
  }

  void _onSearchPressed() async {
    if (_searchQuery.isNotEmpty) {
      try {
        final weatherData = await WeatherApi.fetchWeatherData(_searchQuery);
        setState(() {
          _weatherData = weatherData;
        });
      } catch (e) {
      }
    } else {
    }
  }

  @override
    //final theme = Theme.of(context);
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ViewModelBuilder<SearchViewModel>.reactive(
  viewModelBuilder: () => SearchViewModel(),
  builder: (context, model, child) => Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 70.h),
              child: TypeAheadField<String>(
                textFieldConfiguration: TextFieldConfiguration(
                  autofocus: true,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(horizontal: 10.w),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.r),
                    ),
                    hintText: 'Search Location',
                    suffixIcon: const Icon(Icons.search),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.r),
                      borderSide: BorderSide(
                          color: theme.dividerColor,
                          width: 3.0 // Use the system's divider color
                          ),
                    ),
                  ),
                ),
                suggestionsCallback: _getLocationSuggestions,
                suggestionsBoxDecoration: SuggestionsBoxDecoration(
                  borderRadius: BorderRadius.circular(25.r),
                  color: theme.cardColor, // Use the system's card color
                ),
                itemBuilder: (context, String suggestion) {
                  return Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5.r),
                      color: theme.cardColor, // Use the system's card color
                    ),
                    child: ListTile(
                      leading: const Icon(Icons.location_on),
                      title: Text(suggestion),
                    ),
                  );
                },
                 onSuggestionSelected: (String suggestion) {
      setState(() {
        _searchQuery = suggestion;
      });
      model.updateSearchQuery(_searchQuery); // Pass the search query to the view model
      _onSearchPressed();
      print('Search Query Sent: $_searchQuery'); // Add print statement
    },
              ),
            ),
            _weatherData != null
                ? GestureDetector(
                    onTap: () {
                      // Navigator.push(context,
                      //     MaterialPageRoute(builder: (_) => SearchDetails()));
                    },
                    child: Column(
                      children: [
                        
                        Container(
                          height: 144.h,
                          width: 338.w,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30.r),
                            color: kPrimaryClr,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 16),
                            child: Stack(
                              children: [
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: Container(
                                    constraints: BoxConstraints(maxWidth: 150.w),
                                    child: FittedBox(
                                      fit: BoxFit.scaleDown,
                                      child: Text(
                                        _weatherData!.locationname,
                                        style: GoogleFonts.poppins(
                                          fontSize: 18.sp,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Align(
                                    alignment: Alignment.topRight,
                                    child: SizedBox(
                                      height: 100.h,
                                      width: 100.w,
                                      child:
                                          _weatherData!.weathericone?.isNotEmpty ==
                                                  true
                                              ? _weatherData!.moment == "Sunny"
                                                  ? Lottie.network(
                                                      "https://assets2.lottiefiles.com/packages/lf20_xlky4kvh.json",
                                                      fit: BoxFit.cover,
                                                    )
                                                  : _weatherData!.moment ==
                                                          "Partly cloudy"
                                                      ? Lottie.network(
                                                          "https://assets10.lottiefiles.com/packages/lf20_trr3kzyu.json",
                                                          fit: BoxFit.cover,
                                                        )
                                                      : _weatherData!.moment ==
                                                              "Moderate"
                                                          ? Lottie.network(
                                                              "https://assets9.lottiefiles.com/packages/lf20_xiuakfxs.json",
                                                              fit: BoxFit.cover,
                                                            )
                                                          : _weatherData!
                                                                  .weathericone
                                                                  .isNotEmpty
                                                              ? Image.network(
                                                                  _weatherData!
                                                                      .weathericone,
                                                                  width: 100,
                                                                  height: 100,
                                                                  scale: 0.1,
                                                                )
                                                              : Container()
                                              : Container(),
                                    )),
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Container(
                                    constraints: const BoxConstraints(
                                      maxWidth:
                                          200, // Set a maximum width to limit the size of the FittedBox
                                    ),
                                    child: FittedBox(
                                      fit: BoxFit.scaleDown,
                                      child: Text(
                                        _weatherData!.moment ==
                                                "patchy rain with light thunder"
                                            ? "patchyrain"
                                            : (_weatherData!.moment == "maybe"
                                                ? "bre"
                                                : _weatherData!.moment),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: GoogleFonts.poppins(
                                          fontSize: 28.sp,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.bottomLeft,
                                  child: Text(
                                    'Temperature: ${_weatherData!.temperature}',
                                    style: GoogleFonts.poppins(
                                      fontSize: 18.sp,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.bottomRight,
                                  child: Padding(
                                    padding: EdgeInsets.only(top: 10.h),
                                    child: Container(
                                      constraints: const BoxConstraints(maxHeight: 50),
                                      child: FittedBox(
                                        fit: BoxFit.scaleDown,
                                        child: Text(
                                          _weatherData!.locationname,
                                          style: GoogleFonts.poppins(
                                            fontSize: 15.sp,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
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
                                model.searchusEpaIndex.toString(),
                                style: GoogleFonts.poppins(
                                  color: Colors.white,
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              aqcondition(model.searchusEpaIndex),
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
                              model.searchuv.toString(),
                              style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontSize: 25,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            uvcondition(model.searchuv),
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
                                model.searchsunrise,
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
                                    model.searchsunset,
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
                                  model.searchwindspeed,
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
                                  model.searchfeelsLike,
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
                              model.searchpressure,
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
                              model.searchhumidity,
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
                                  '${model.searchdewPoint}',
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
                      
                      ],
                    ),
                  )
                : Container(),
          ],
        ),
      ),
     ) );
  }
}
// String moment = _weatherData!.moment;
// moment = moment.replaceAll("Thundery outbreaks possible", "Thundery");

// Text(
//   moment,
//   maxLines: 1,
//   overflow: TextOverflow.ellipsis,
//   style: GoogleFonts.poppins(
//     fontSize: 28.sp,
//     fontWeight: FontWeight.w500,
//     color: Colors.white,
//   ),
// ),
