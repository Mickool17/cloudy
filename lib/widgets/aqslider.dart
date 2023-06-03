// ignore_for_file: library_private_types_in_public_api

import 'package:cloudy/models/airqualitymodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AQIndexSlider extends StatefulWidget {
  final AirQualityViewModel viewModel;

  const AQIndexSlider({super.key, required this.viewModel});

  @override
  _AQIndexSliderState createState() => _AQIndexSliderState();
}

class _AQIndexSliderState extends State<AQIndexSlider> {
  late double _sliderValue;
  late Color _sliderColor;

  @override
  void initState() {
    super.initState();
    String airQuality = widget.viewModel.baseModel.airQuality;
    double parsedValue = double.tryParse(airQuality) ?? 1.0;
    _sliderValue = parsedValue.clamp(1.0, 6.0);
    _sliderColor = widget.viewModel.updateSliderColor();
    widget.viewModel.baseModel.addListener(_handleAirqualityChanged);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 20.h,
          // Increase the height of the SizedBox
          child: Stack(
            children: [
              // Custom LinearProgressIndicator
              Align(
                alignment: Alignment.center,
                child: SizedBox(
                  height: 4.h,
                  child: LinearProgressIndicator(
                    value: (_sliderValue - 1) / 5,
                    backgroundColor: Colors.grey,
                    valueColor: AlwaysStoppedAnimation<Color>(_sliderColor),
                  ),
                ),
              ),
              SliderTheme(
                data: SliderThemeData(
                  trackHeight: 0, // Set the trackHeight to 0
                  thumbShape: RoundSliderThumbShape(enabledThumbRadius: 3.r),
                  thumbColor: Colors.white,
                  overlayColor: _sliderColor.withOpacity(0.4),
                  overlayShape: RoundSliderOverlayShape(overlayRadius: 25.r),
                ),
                child: Slider(
                  value: _sliderValue,
                  min: 1.0,
                  max: 6.0,
                  divisions: 5,
                  onChanged: (double newValue) {}, // Disable user input
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 10.h),
      ],
    );
  }

 void _handleAirqualityChanged() {
  if (mounted) {
    setState(() {
      String airQuality = widget.viewModel.baseModel.airQuality;
      double parsedValue = double.tryParse(airQuality) ?? 1.0;
      _sliderValue = parsedValue.clamp(1.0, 6.0);
      _sliderColor = widget.viewModel.updateSliderColor();
    });
  }
}


  @override
  void dispose() {
    widget.viewModel.baseModel.removeListener(_handleAirqualityChanged);
    super.dispose();
  }
}
