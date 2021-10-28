import 'package:flutter/material.dart';

class BorderConstants {
  static BorderConstants instance = BorderConstants._init();
  BorderConstants._init();

  final radiusAllCircularLow = RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(8),
  );
  final radiusAllCircularNormal = BorderRadius.circular(16);
}
