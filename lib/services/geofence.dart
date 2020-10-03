import 'package:flutter_background_geolocation/flutter_background_geolocation.dart' as bg;  
import 'package:geo_reminders/database/db_helper.dart';
import 'package:geo_reminders/models/reminder.dart';
import 'package:geo_reminders/services/notification.dart';

class GeoFenceService {

  GeoFenceService(){
    bg.BackgroundGeolocation.onGeofence(_onGeoFence);
    bg.BackgroundGeolocation.ready(bg.Config(
      desiredAccuracy: bg.Config.DESIRED_ACCURACY_HIGH,
      distanceFilter: 10.0,
      stopOnTerminate: false,
      startOnBoot: true,
      debug: true,
      logLevel: bg.Config.LOG_LEVEL_OFF
    )).then((bg.State state) {
      if(!state.enabled){
        bg.BackgroundGeolocation.startGeofences();
      }
    });
  }

  
  void _onGeoFence(bg.GeofenceEvent event) async {
    print('Geofence triggered.');
    int id = int.parse(event.identifier);
    Reminder reminder = await  DBHelper().getReminder(id);
    if(reminder != null){
      await NotificationService().showReminder(reminder);
    }
  }

  void addGeofence(Reminder reminder, double long, double lat){
    bool entry = false;
    bool exit = false;
    if (reminder.locationStatus ==1){
      entry = true;
    } else if (reminder.locationStatus == 3){
      exit = true;
    }
    entry ? print('Entry true') : print('Entry false');
    exit ? print('Exit true') : print('Exit false');
    bg.BackgroundGeolocation.addGeofence(
      bg.Geofence(
        identifier: reminder.id.toString(),
        radius: 150,
        latitude: lat,
        longitude: long,
        notifyOnEntry: entry,
        notifyOnExit: exit,
        notifyOnDwell: false,
        loiteringDelay: 30000,
      )).then((bool success){
        print ('success with geofence');
      });
  }

}