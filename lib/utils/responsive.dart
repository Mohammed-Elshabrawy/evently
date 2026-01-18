import 'package:flutter/material.dart';

extension Responsive on BuildContext {
  static const double uiHeight = 812;
  static const double uiWidth = 375;
  static const double uiRatio = uiHeight / uiWidth;

  double get screenHeight => MediaQuery.of(this).size.height;
  double get screenWidth => MediaQuery.of(this).size.width;
  double get screenRatio => screenHeight / screenWidth;


  double get screenHeightRatio => screenHeight / uiHeight;
  double get screenWidthRatio => screenWidth / uiWidth;
  double get ratio => screenRatio / uiRatio;
}
