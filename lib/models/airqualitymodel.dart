// ignore_for_file: unrelated_type_equality_checks

import 'package:cloudy/models/basemodel.dart';
import 'package:flutter/material.dart';

class AirQualityViewModel {
  late final BaseModel baseModel;

  AirQualityViewModel({required this.baseModel});

  Color updateSliderColor() {
    String
     uvValue = baseModel.airQuality;

    if (uvValue == 1) {
      return Colors.green;
    } else if (uvValue == 2) {
      return Colors.yellow;
    } else if (uvValue == 3) {
      return Colors.orange;
    
    } else if (uvValue == 4) {
      return Colors.red;
    } else {
      return Colors.purple;
    }
  }
}
