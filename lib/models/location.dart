import 'package:geo_reminders/database/db_helper.dart';

class Location{
  int id;
  String name;
  double latitude;
  double longitude;
  int colorCode;

  Location({this.id, this.name, this.colorCode, this.latitude, this.longitude});

  Map<String, dynamic> toMap(){
    return <String, dynamic> {
      DBHelper.ID : id,
      DBHelper.NAME : name,
      DBHelper.LATITUDE: latitude,
      DBHelper.LONGITUDE: longitude,
      DBHelper.COLOR_CODE: colorCode
    };
  }

  Location.fromMap(Map <String, dynamic> map) {
    id = map[DBHelper.ID];
    name = map[DBHelper.NAME];
    latitude = map[DBHelper.LATITUDE];
    longitude = map[DBHelper.LONGITUDE];
    colorCode = map[DBHelper.COLOR_CODE];
  }

}