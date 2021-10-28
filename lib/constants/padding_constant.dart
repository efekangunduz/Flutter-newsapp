import 'package:flutter/material.dart';

class PaddingConstants {
  static PaddingConstants instance = PaddingConstants._init();
  PaddingConstants._init();

  final paddingAllNormal = EdgeInsets.all(16.0);
  final paddingAllLow = EdgeInsets.all(8.0);
  final paddingLeftRightNormal = EdgeInsets.fromLTRB(16, 0, 16, 0);
}
