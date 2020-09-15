import 'package:flutter/material.dart';
import 'package:geo_reminders/res/theme.dart';
import 'package:geo_reminders/screens/home/home.dart';

void main() {
  runApp(
    MaterialApp(
      theme: theme,
      home: Home(),
      debugShowCheckedModeBanner: false,
    )
  );
}
