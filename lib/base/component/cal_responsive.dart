import 'package:flutter/material.dart';

class CalResponsive {
  CalResponsive._();
  static final instance = CalResponsive._();

  final double _baseWidth = 375.0;
  final double _baseHeight = 812;

// Get the scale factor
  double scaleWidth(BuildContext context, double width) {
    double screenWidth = MediaQuery.of(context).size.width;
    return (width / _baseWidth) * screenWidth;
  }

  double scaleHeight(BuildContext context, double height) {
    double screenHeight = MediaQuery.of(context).size.height;
    return (height / _baseHeight) * screenHeight;
  }
}
