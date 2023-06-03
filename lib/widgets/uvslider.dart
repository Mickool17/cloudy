// ignore_for_file: library_private_types_in_public_api

import 'package:cloudy/models/uvindexmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UVIndexSlider extends StatefulWidget {
  final UVIndexViewModel viewModel;

  const UVIndexSlider({super.key, required this.viewModel});

  @override
  _UVIndexSliderState createState() => _UVIndexSliderState();
}

class _UVIndexSliderState extends State<UVIndexSlider> {
  late double _sliderValue;
  late Color _sliderColor;

  @override
  void initState() {
    super.initState();
    _sliderValue = widget.viewModel.baseModel.uv.clamp(1.0, 6.0);
    _sliderColor = widget.viewModel.updateSliderColor();
    widget.viewModel.baseModel.addListener(_handleUVIndexChanged);
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

 void _handleUVIndexChanged() {
  if (mounted) {
    setState(() {
      _sliderValue = widget.viewModel.baseModel.uv.clamp(1.0, 6.0);
      _sliderColor = widget.viewModel.updateSliderColor();
    });
  }
}


  @override
  void dispose() {
    widget.viewModel.baseModel.removeListener(_handleUVIndexChanged);
    super.dispose();
  }
}
