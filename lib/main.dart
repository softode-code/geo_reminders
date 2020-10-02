import 'package:flutter/material.dart';
import 'package:geo_reminders/res/theme.dart';
import 'package:geo_reminders/screens/home.dart';
import 'package:geo_reminders/services/notification.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  NotificationService().initializeFlutterNotificationPlugin();
  runApp(
    MaterialApp(
      theme: theme,
      home: Home(),
      debugShowCheckedModeBanner: false,
    )
  );
}
