import 'package:flutter/material.dart';

Color primaryColor = Color(0xffDCA11E);
Color appBarColor = Color(0xffdedede);
Color blackColor = Color(0xff000000);

ThemeData customTheme = ThemeData(
    primaryColor: primaryColor,
    appBarTheme: AppBarTheme(centerTitle: true, backgroundColor: primaryColor),
    scaffoldBackgroundColor: appBarColor);
