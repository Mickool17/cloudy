// import 'package:cloudy/const.dart';
// import 'package:cloudy/models/airqualitymodel.dart';
// import 'package:cloudy/models/basemodel.dart';
// import 'package:cloudy/models/uvindexmodel.dart';
// import 'package:cloudy/widgets/aqslider.dart';
// import 'package:cloudy/widgets/uvslider.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:stacked/stacked.dart';
// import '../screens/page1.dart';
// import 'searchbar_view _model.dart';

// class SearchDetails extends StatelessWidget {
//   const SearchDetails({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return ViewModelBuilder<SearchViewModel>.reactive(
//       viewModelBuilder: () => SearchViewModel(),
//       builder: (context, model, child) => Scaffold(
//         body: SingleChildScrollView(
//           scrollDirection: Axis.vertical,
//           child: Column(
//             children: [
        
          
          
              
//           // page implementation .
//           // Used model.searchQuery to get the current search query.
        
//               Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 20),
//                     child: Align(
//                         alignment: Alignment.bottomLeft,
//                         child: Text(
//                           "Environment",
//                           style: GoogleFonts.poppins(
//                               fontSize: 18.sp, fontWeight: FontWeight.bold),
//                         )),
//                   ),
//                   SizedBox(
//                     height: 10.h,
//                   ),
//                   SizedBox(
//                     height: 160.h,
//                     width: 342.w,
//                     child: Container(
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(22),
//                         color: kPrimaryClr,
//                       ),
//                       child: Padding(
//                         padding: EdgeInsets.symmetric(
//                             horizontal: 20.w, vertical: 20.h),
//                         child: Column(
//                           children: [
//                             Align(
//                               alignment: Alignment.topLeft,
//                               child: Opacity(
//                                 opacity: 0.7,
//                                 child: Row(
//                                   children: [
//                                     const Icon(
//                                       Icons.air,
//                                       color: Colors.white,
//                                     ),
//                                     SizedBox(width: 5.w),
//                                     Text(
//                                       "AIR QUALITY",
//                                       style: GoogleFonts.poppins(
//                                         color: Colors.white,
//                                         fontSize: 15.sp,
//                                         fontWeight: FontWeight.w700,
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ),
//                             SizedBox(height: 5.h),
//                             Row(
//                               children: [
//                                 Text(
//                                   model.searchusEpaIndex.toString(),
//                                   style: GoogleFonts.poppins(
//                                     color: Colors.white,
//                                     fontSize: 20.sp,
//                                     fontWeight: FontWeight.w400,
//                                   ),
//                                 ),
//                                 aqcondition(model.searchusEpaIndex),
//                               ],
//                             ),
//                             SizedBox(height: 5.h),
//                             AQIndexSlider(
//                               viewModel:
//                                   AirQualityViewModel(baseModel: BaseModel()),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),
//                   SizedBox(height: 10.h),
//                   Row(
//                     children: [
//                       SizedBox(width: 20.w),
//                       Container(
//                         height: 164.h,
//                         width: 164.w,
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(22),
//                           color: kPrimaryClr,
//                         ),
//                         child: Padding(
//                           padding: const EdgeInsets.symmetric(horizontal: 20),
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               SizedBox(height: 20.h),
//                               Opacity(
//                                 opacity: 0.7,
//                                 child: Row(
//                                   children: [
//                                     const Icon(
//                                       Icons.sunny,
//                                       color: Colors.white,
//                                     ),
//                                     SizedBox(width: 5.w),
//                                     Text(
//                                       "UV INDEX",
//                                       style: GoogleFonts.poppins(
//                                         color: Colors.white,
//                                         fontSize: 15.sp,
//                                         fontWeight: FontWeight.w700,
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                               SizedBox(height: 10.h),
//                               Text(
//                                 model.searchuv.toString(),
//                                 style: GoogleFonts.poppins(
//                                   color: Colors.white,
//                                   fontSize: 25,
//                                   fontWeight: FontWeight.w400,
//                                 ),
//                               ),
//                               uvcondition(model.searchuv),
//                               SizedBox(height: 10.h),
//                               Align(
//                                 alignment: Alignment.topLeft,
//                                 child: UVIndexSlider(
//                                   viewModel:
//                                       UVIndexViewModel(baseModel: BaseModel()),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                       SizedBox(width: 10.w),
//                       Expanded(
//                         child: Container(
//                           height: 164.h,
//                           width: 164.w,
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(22),
//                             color: kPrimaryClr,
//                           ),
//                           child: Padding(
//                             padding: const EdgeInsets.symmetric(
//                                 horizontal: 20, vertical: 20),
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Align(
//                                   alignment: Alignment.topLeft,
//                                   child: Opacity(
//                                     opacity: 0.7,
//                                     child: Row(
//                                       children: [
//                                         const Icon(
//                                           Icons.sunny,
//                                           color: Colors.white,
//                                         ),
//                                         SizedBox(width: 5.w),
//                                         Text(
//                                           "SUNRISE",
//                                           style: GoogleFonts.poppins(
//                                             color: Colors.white,
//                                             fontSize: 15.sp,
//                                             fontWeight: FontWeight.w700,
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                 ),
//                                 Text(
//                                   model.searchsunrise,
//                                   style: GoogleFonts.poppins(
//                                     color: Colors.white,
//                                     fontSize: 20.sp,
//                                     fontWeight: FontWeight.w400,
//                                   ),
//                                 ),
//                                 Container(
//                                     height: 2.h, width: 150.w, color: Colors.white),
//                                 const Spacer(),
//                                 Row(
//                                   children: [
//                                     Text(
//                                       "Sunset: ",
//                                       style: GoogleFonts.poppins(
//                                           color: Colors.white),
//                                     ),
//                                     Text(
//                                       model.searchsunset,
//                                       style: GoogleFonts.poppins(
//                                         color: Colors.white,
//                                         fontSize: 15,
//                                         fontWeight: FontWeight.w400,
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                       ),
//                       SizedBox(width: 20.w),
//                     ],
//                   ),
//                   SizedBox(height: 10.h),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Container(
//                         height: 164.h,
//                         width: 164.w,
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(22),
//                           color: kPrimaryClr,
//                         ),
//                         child: Padding(
//                           padding: EdgeInsets.symmetric(
//                               vertical: 20.h, horizontal: 20.w),
//                           child: Column(
//                             mainAxisAlignment: MainAxisAlignment.start,
//                             children: [
//                               Align(
//                                 alignment: Alignment.topLeft,
//                                 child: Opacity(
//                                   opacity: 0.7,
//                                   child: Row(
//                                     children: [
//                                       const Icon(
//                                         Icons.wind_power,
//                                         color: Colors.white,
//                                       ),
//                                       SizedBox(width: 5.w),
//                                       Text(
//                                         "WIND",
//                                         style: GoogleFonts.poppins(
//                                           color: Colors.white,
//                                           fontSize: 15,
//                                           fontWeight: FontWeight.w700,
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                               SizedBox(height: 20.h),
//                               Row(
//                                 mainAxisAlignment: MainAxisAlignment.center,
//                                 children: [
//                                   Text(
//                                     model.searchwindspeed,
//                                     style: GoogleFonts.poppins(
//                                         color: Colors.white, fontSize: 40),
//                                   ),
//                                   Text(
//                                     " km/h",
//                                     style:
//                                         GoogleFonts.poppins(color: Colors.white),
//                                   ),
//                                 ],
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                       SizedBox(width: 10.w),
//                       Container(
//                         height: 164.h,
//                         width: 164.w,
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(22),
//                           color: kPrimaryClr,
//                         ),
//                         child: Padding(
//                           padding: EdgeInsets.symmetric(
//                               vertical: 10.h, horizontal: 20),
//                           child: Column(
//                             mainAxisAlignment: MainAxisAlignment.start,
//                             children: [
//                               Align(
//                                 alignment: Alignment.topLeft,
//                                 child: Opacity(
//                                   opacity: 0.7,
//                                   child: Row(
//                                     children: [
//                                       const Icon(
//                                         Icons.thermostat,
//                                         color: Colors.white,
//                                       ),
//                                       SizedBox(width: 5.w),
//                                       Text(
//                                         "FEELS LIKE",
//                                         style: GoogleFonts.poppins(
//                                           color: Colors.white,
//                                           fontSize: 15.sp,
//                                           fontWeight: FontWeight.w700,
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                               SizedBox(height: 10.h),
//                               Row(
//                                 children: [
//                                   Text(
//                                     model.searchfeelsLike,
//                                     style: GoogleFonts.poppins(
//                                         color: Colors.white, fontSize: 40),
//                                   ),
//                                   Text(
//                                     ' \u00B0C',
//                                     style: GoogleFonts.poppins(
//                                         color: Colors.white, fontSize: 20.sp),
//                                   ),
//                                 ],
//                               ),
//                               Text(
//                                 "Similar to the actual temperature.",
//                                 style: GoogleFonts.poppins(
//                                     color: Colors.white, fontSize: 10.sp),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                   SizedBox(height: 10.h),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Container(
//                         height: 164.h,
//                         width: 164.w,
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(22),
//                           color: kPrimaryClr,
//                         ),
//                         child: Padding(
//                           padding: EdgeInsets.symmetric(
//                               vertical: 20.h, horizontal: 20.w),
//                           child: Column(
//                             mainAxisAlignment: MainAxisAlignment.start,
//                             children: [
//                               Align(
//                                 alignment: Alignment.topLeft,
//                                 child: Row(
//                                   children: [
//                                     Opacity(
//                                       opacity: 0.7,
//                                       child: Row(
//                                         children: [
//                                           const Icon(
//                                             Icons.warning,
//                                             color: Colors.white,
//                                           ),
//                                           SizedBox(width: 5.w),
//                                           Text(
//                                             " PRESSURE",
//                                             style: GoogleFonts.poppins(
//                                               color: Colors.white,
//                                               fontSize: 15,
//                                               fontWeight: FontWeight.w700,
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                               SizedBox(height: 20.h),
//                               Text(
//                                 model.searchpressure,
//                                 style: GoogleFonts.poppins(
//                                     color: Colors.white, fontSize: 40),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                       SizedBox(width: 10.w),
//                       Container(
//                         height: 164.h,
//                         width: 164.w,
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(22),
//                           color: kPrimaryClr,
//                         ),
//                         child: Padding(
//                           padding: EdgeInsets.symmetric(
//                               vertical: 10.h, horizontal: 20),
//                           child: Column(
//                             mainAxisAlignment: MainAxisAlignment.start,
//                             children: [
//                               Align(
//                                 alignment: Alignment.topLeft,
//                                 child: Row(
//                                   children: [
//                                     Opacity(
//                                       opacity: 0.7,
//                                       child: Row(
//                                         children: [
//                                           const Icon(
//                                             Icons.water,
//                                             color: Colors.white,
//                                           ),
//                                           SizedBox(width: 5.w),
//                                           Text(
//                                             "HUMIDITY",
//                                             style: GoogleFonts.poppins(
//                                               color: Colors.white,
//                                               fontSize: 15.sp,
//                                               fontWeight: FontWeight.w700,
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                               SizedBox(height: 10.h),
//                               Text(
//                                 model.searchhumidity,
//                                 style: GoogleFonts.poppins(
//                                     color: Colors.white, fontSize: 40.sp),
//                               ),
//                               Row(
//                                 children: [
//                                   Text(
//                                     "The dew point is ",
//                                     style: GoogleFonts.poppins(
//                                         color: Colors.white, fontSize: 13.sp),
//                                   ),
//                                   Text(
//                                     '${model.searchdewPoint}',
//                                     style: GoogleFonts.poppins(
//                                         color: Colors.white, fontSize: 13.sp),
//                                   ),
//                                 ],
//                               ),
//                               Align(
//                                 alignment: Alignment.topLeft,
//                                 child: Text(
//                                   "right now",
//                                   style: GoogleFonts.poppins(
//                                       color: Colors.white, fontSize: 13.sp),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//               ]),
//         )),
//     );
//   }
// }
