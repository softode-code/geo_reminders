import 'package:flutter/material.dart';
import 'package:geo_reminders/res/colors.dart';

ThemeData theme = ThemeData(
  primaryColor: primaryColor,
  accentColor: primaryAccent,
  primaryColorLight: primaryLight,
  fontFamily: 'Mulish',
  scaffoldBackgroundColor: Colors.white,
  highlightColor: Colors.transparent,
  splashColor: Colors.transparent,
  textTheme: TextTheme(
    headline6: TextStyle(
      color: titleColor,
      fontSize: 16
    ),
    headline5: TextStyle(
      color: subtitleColor,
      fontSize: 16,
      fontWeight: FontWeight.w600
    ),
    subtitle1: TextStyle(
      color: hintColor,
      fontSize: 16,
      fontWeight: FontWeight.normal
    ),
    subtitle2: TextStyle(
      color: disabledColor,
      fontSize: 13,
      fontWeight: FontWeight.normal
    )
  )
);