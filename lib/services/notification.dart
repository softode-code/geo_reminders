import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:geo_reminders/models/reminder.dart';
import 'package:rxdart/rxdart.dart';

class NotificationService{
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

    final BehaviorSubject<ReceivedNotification> didReceiveLocalNotificationSubject =
        BehaviorSubject<ReceivedNotification>();

    final BehaviorSubject<String> selectNotificationSubject =
        BehaviorSubject<String>();

    NotificationAppLaunchDetails notificationAppLaunchDetails;

    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'Reminder', 'Reminder', 'Your Reminders'
    );
    var iosPlatformChannelSpecifics = IOSNotificationDetails();

    Future initializeFlutterNotificationPlugin() async {
      notificationAppLaunchDetails =
      await flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();

      var initializationSettingsAndroid = AndroidInitializationSettings('favicon');
      // Note: permissions aren't requested here just to demonstrate that can be done later using the `requestPermissions()` method
      // of the `IOSFlutterLocalNotificationsPlugin` class
      var initializationSettingsIOS = IOSInitializationSettings(
          requestAlertPermission: false,
          requestBadgePermission: false,
          requestSoundPermission: false,
          onDidReceiveLocalNotification:
              (int id, String title, String body, String payload) async {
            didReceiveLocalNotificationSubject.add(ReceivedNotification(
                id: id, title: title, body: body, payload: payload));
          });
      var initializationSettings = InitializationSettings(
          initializationSettingsAndroid, initializationSettingsIOS);
      await flutterLocalNotificationsPlugin.initialize(initializationSettings,
          onSelectNotification: (String payload) async {
        if (payload != null) {
          debugPrint('notification payload: ' + payload);
        }
        selectNotificationSubject.add(payload);
      });
      _requestIOSPermissions();
    }

    void _requestIOSPermissions() {
    flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
          alert: true,
          badge: true,
          sound: true,
        );
  }

    Future addReminder(Reminder reminder) async {
      
      NotificationDetails notificationDetails = NotificationDetails(
        androidPlatformChannelSpecifics, iosPlatformChannelSpecifics
      );

      if (reminder.repeatEveryDay){
        var time = Time(reminder.hour, reminder.minute, 0);
        await FlutterLocalNotificationsPlugin().showDailyAtTime(
          reminder.id,
          reminder.name,
          reminder.note,
          time,
          notificationDetails,
          payload: reminder.id.toString()
        );
      } else {
        var scheduledDate = DateTime(
          reminder.year, reminder.month, reminder.day,
          reminder.hour, reminder.minute, 0, 0, 0
        );
        await FlutterLocalNotificationsPlugin().schedule(
          reminder.id,
          reminder.name,
          reminder.note,
          scheduledDate,
          notificationDetails,
          payload: reminder.id.toString()
        );
      }
    }
    
}

class ReceivedNotification {
  final int id;
  final String title;
  final String body;
  final String payload;

  ReceivedNotification({
    @required this.id,
    @required this.title,
    @required this.body,
    @required this.payload,
  });
}