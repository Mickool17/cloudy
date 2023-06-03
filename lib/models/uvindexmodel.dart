import 'package:cloudy/models/basemodel.dart';
import 'package:flutter/material.dart';

class UVIndexViewModel {
  final BaseModel baseModel;

  UVIndexViewModel({required this.baseModel});

  Color updateSliderColor() {
    double uvValue = baseModel.uv;

    if (uvValue == 1.0) {
      return Colors.green;
    } else if (uvValue == 2.0) {
      return Colors.yellow;
    } else if (uvValue == 3.0) {
      return Colors.orange;
    } else if (uvValue == 4.0) {
      return Colors.red;
    } else {
      return Colors.purple;
    }
  }

  
}
