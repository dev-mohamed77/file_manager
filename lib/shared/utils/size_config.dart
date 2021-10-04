import 'package:flutter/material.dart';

class SizeConfig {
  static double? screenWidth;
  static double? screenHeight;
  static double? defaultSize;
  static Orientation? orientation;

  void init({required BuildContext ctx}) {
    screenWidth = MediaQuery.of(ctx).size.width;
    screenHeight = MediaQuery.of(ctx).size.height;
    orientation = MediaQuery.of(ctx).orientation;

    defaultSize = orientation == Orientation.landscape
        ? screenHeight! * 0.024
        : screenWidth! * 0.024;
  }
}
