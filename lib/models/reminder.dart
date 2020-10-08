import 'package:geo_reminders/database/db_helper.dart';

class Reminder{
  int id;
  String name;
  int hour;
  int minute;
  int day;
  int month;
  int year;
  int locationId;
  String note;
  bool completed;
  bool repeatEveryDay;
  bool todayLocation;
  int locationStatus;

  Reminder({
    this.id, this.name, this.hour, this.minute, this.day, this.month, this.year,
    this.locationId, this.note, this.completed = false,
    this.repeatEveryDay, this.todayLocation, this.locationStatus
  });

  Map<String, dynamic> topMap(){
    return <String, dynamic> {
      DBHelper.ID: id,
      DBHelper.NAME: name,
      DBHelper.HOUR : hour,
      DBHelper.MINUTE : minute,
      DBHelper.DAY : day,
      DBHelper.MONTH : month,
      DBHelper.YEAR : year,
      DBHelper.LOCATION_ID : locationId,
      DBHelper.NOTE : note,
      DBHelper.COMPLETED: completed ? 1 :0,
      DBHelper.REPEAT_EVERYDAY : repeatEveryDay ? 1 : 0,
      DBHelper.TODAY_LOCATION : todayLocation ? 1 : 0,
      DBHelper.LOCATION_STATUS : locationStatus
    };
  }

  Reminder.fromMap(Map <String, dynamic> map){
      id = map[DBHelper.ID];
      name = map[DBHelper.NAME];
      hour = map[DBHelper.HOUR];
      minute = map[DBHelper.MINUTE];
      day = map[DBHelper.DAY];
      month = map[DBHelper.MONTH];
      year = map[DBHelper.YEAR];
      locationId = map[DBHelper.LOCATION_ID];
      note = map[DBHelper.NOTE];
      completed = map[DBHelper.COMPLETED] ==1 ? true : false;
      repeatEveryDay = map[DBHelper.REPEAT_EVERYDAY] ==1 ? true : false;
      todayLocation = map[DBHelper.TODAY_LOCATION] ==1 ? true : false;
      locationStatus = map[DBHelper.LOCATION_STATUS];
  }

}