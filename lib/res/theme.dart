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
    )
  )
);