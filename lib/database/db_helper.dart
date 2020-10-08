import 'dart:async';
import 'dart:io';
import 'package:geo_reminders/models/location.dart';
import 'package:geo_reminders/models/reminder.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

class DBHelper {
  static Database _db;
  static String DB_NAME  = 'reminders.db';
  static String REMINDERS_TABLE = 'reminders';
  static String LOCATIONS_TABLE = 'lcoations';
  static String NAME = 'name';
  static String ID = 'id';
  static String HOUR = 'hour';
  static String MINUTE = 'minute';
  static String DAY = 'day';
  static String MONTH = 'month';
  static String YEAR = 'year_';
  static String LOCATION_ID = 'locationId';
  static String NOTE = 'note';
  static String LONGITUDE = 'longitude';
  static String LATITUDE = 'latitude';
  static String COLOR_CODE = 'colorCode';
  static String COMPLETED = 'completed';
  static String REPEAT_EVERYDAY = 'repeatEveryday';
  static String TODAY_LOCATION = 'todayLocation';
  static String LOCATION_STATUS = 'locationStatus';


  Future<Database> get db async {
    if(_db != null){
      return _db;
    }
    _db = await initDb();
    return _db;
  }

  initDb() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path =  join(documentsDirectory.path, DB_NAME);
    var db = await openDatabase(path, version:1, onCreate: _onCreate);
    return db;
  }

  _onCreate(Database db, int version) async {
    await db.execute('PRAGMA foreign_keys = ON');
    await db.execute('CREATE TABLE $LOCATIONS_TABLE ($LATITUDE DOUBLE NOT NULL, $LONGITUDE DOUBLE NOT NULL, $NAME TEXT, $COLOR_CODE INTEGER, $ID INTEGER PRIMARY KEY AUTOINCREMENT)');
    await db.execute('CREATE TABLE $REMINDERS_TABLE ($ID INTEGER PRIMARY KEY AUTOINCREMENT, $NAME TEXT NOT NULL, $HOUR INTEGER, $MINUTE INTEGER, $DAY INTEGER, $MONTH INTEGER, $YEAR INTEGER, $NOTE TEXT, $COMPLETED INTEGER, $REPEAT_EVERYDAY INTEGER, $TODAY_LOCATION INTEGER, $LOCATION_STATUS INTEGER, $LOCATION_ID INTEGER, FOREIGN KEY ($LOCATION_ID) REFERENCES $LOCATIONS_TABLE($ID))');
  }

  Future addLocation(Location location) async{
    Database database = await db;
    return await database.insert(LOCATIONS_TABLE, location.toMap());
  }

  Future<List<Location>> getLocations() async {
    Database database = await db;
    List<Map> maps = await database.rawQuery('SELECT * FROM $LOCATIONS_TABLE WHERE $NAME IS NOT NULL');
    List<Location> locations = [];
    if(maps.length>0){
      for (int i=0; i< maps.length; i++){
        locations.add(Location.fromMap(maps[i]));
      }
    }
    return locations;
  }

  Future<List<Reminder>> getReminders() async {
    Database database = await db;
    List<Map> maps = await database.query(REMINDERS_TABLE);
    List<Reminder> reminders = [];
    if(maps.length>0){
      for (int i=0; i< maps.length; i++){
        reminders.add(Reminder.fromMap(maps[i]));
      }
    }
    return reminders;
  }

  Future<Reminder> getReminder(int id) async{
    Database database = await db;
    List<Map> maps = await database.rawQuery('SELECT * FROM $REMINDERS_TABLE WHERE $ID = '+ id.toString());
    if(maps.length > 0){
      return Reminder.fromMap(maps[0]);
    }
    return null;
  }


  Future addReminder(Reminder reminder) async {
    Database database = await db;
    return await database.insert(REMINDERS_TABLE, reminder.topMap());
  }

  Future updateReminder(Reminder reminder) async {
    Database database = await db;
    return await database.update(REMINDERS_TABLE, reminder.topMap(), where: '$ID = ?', whereArgs: [reminder.id]);
  }

}