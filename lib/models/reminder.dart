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
  String position;
  String note;
  bool completed;

  Reminder({
    this.id, this.name, this.hour, this.minute, this.day, this.month, this.year,
    this.locationId, this.note, this.position, this.completed = false
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
      DBHelper.POSITION : position,
      DBHelper.LOCATION_ID : locationId,
      DBHelper.NOTE : note,
      DBHelper.COMPLETED: completed
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
      position = map[DBHelper.POSITION];
      note = map[DBHelper.NOTE];
      completed = map[DBHelper.COMPLETED];
  }

}