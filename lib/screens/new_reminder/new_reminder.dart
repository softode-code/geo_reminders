import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geo_reminders/res/colors.dart';
import 'package:geo_reminders/screens/pick_location/pick_location.dart';
import 'package:geo_reminders/widgets/bottom_right_btn.dart';
import 'package:geo_reminders/widgets/custom_menu.dart';
import 'package:geo_reminders/screens/new_reminder/location_status.dart';
import 'package:geo_reminders/widgets/cross_button.dart';
import 'package:geo_reminders/widgets/header_with_underline.dart';
import 'package:geo_reminders/widgets/outline_input_field_with_title.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'add_note.dart';

class NewReminder extends StatefulWidget {
  @override
  _NewReminderState createState() => _NewReminderState();
}

class _NewReminderState extends State<NewReminder> {

  final _formkey = GlobalKey<FormState>();
  String _reminderName;
  int _locationStatus;
  String _note;
  LatLng _coordinates;
  TimeOfDay _timeOfDay;
  bool _remindToday = false;
  DateTime _dateTime;
  bool _everyday = false;

  OverlayEntry _overlayEntry;
  Offset buttonPosition;
  bool isMenuOpen = false;
  Size buttonSize;
  GlobalKey dueDateKey = LabeledGlobalKey("due_date");
  GlobalKey remindMeKey = LabeledGlobalKey('remind_me');
  GlobalKey pickLocationKey = LabeledGlobalKey('pick_location');

  findButton(GlobalKey key){
    RenderBox renderBox = key.currentContext.findRenderObject();
    buttonSize = renderBox.size;
    buttonPosition = renderBox.localToGlobal(Offset.zero);
  }

  OverlayEntry _overlayEntryBuilder(Widget menu) {
    return OverlayEntry(builder: (context) {
      return Positioned(
        top: buttonPosition.dy + buttonSize.height,
        left: buttonPosition.dx,
        width:buttonSize.width,
        child: Material(
          color: Colors.transparent,
          child: menu
        ),
      );
      },
    );
  }

  void openMenu(GlobalKey key, Widget menu) {
    findButton(key);
    _overlayEntry = _overlayEntryBuilder(menu);
    Overlay.of(context).insert(_overlayEntry);
    isMenuOpen = !isMenuOpen;
  }
  void closeMenu() {
    _overlayEntry.remove();
    isMenuOpen = !isMenuOpen;
  }

  void updateCoordinates(LatLng coordinates){
    setState(() {
      _coordinates = coordinates;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Form(
          key: _formkey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(top:10, left:15, right: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CrossButton(),
                      HeaderWithUnderline(text: 'New Reminder'),
                      SizedBox(height: 50,),
                      OutlineInputFieldWithTitle(
                        title: 'Reminder',
                        hint: 'Add a reminder',
                        onChanged: (val) {
                          setState(() {
                            _reminderName = val;
                          });
                        },
                        validator: (val) => val.isEmpty ? 'Enter a reminder' : null,
                      ),
                      SizedBox(height:20),
                      Text(
                        'Remind me',
                        style: Theme.of(context).textTheme.headline6,
                      ),
                      SizedBox(height:10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(width:15),
                          SvgPicture.asset('assets/bell.svg', height: 26, width: 26,),
                          SizedBox(width:15),
                          Expanded(
                            child: InkWell(
                              onTap: (){
                                if (isMenuOpen) {
                                  closeMenu();
                                } else {
                                  openMenu(
                                    remindMeKey,
                                    CustomMenu(
                                      menuIcons: [
                                        Icons.today_outlined,
                                        Icons.alarm
                                      ],
                                      menuTitles: [
                                        'Today (Location based)',
                                        'Pick a time'
                                      ],
                                      onPressed: [
                                        (){
                                          setState((){
                                            _timeOfDay = null;
                                            _remindToday = true;
                                          });
                                          closeMenu();
                                        },
                                        () async{
                                          closeMenu();
                                          await showTimePicker(
                                            context: context, initialTime: _timeOfDay ?? TimeOfDay.now())
                                            .then((value) {
                                              setState(() {
                                                _timeOfDay = value ?? _timeOfDay;
                                                _remindToday = false;
                                              });
                                            });
                                          
                                        },
                                      ],
                                    )
                                  );
                                }
                              },
                              child: Container(
                                key: remindMeKey,
                                child: Text(
                                  _timeOfDay == null ? ( _remindToday ? 'Today (Location based)' : 'Add time') : (
                                    _timeOfDay.hour.toString() +':' + _timeOfDay.minute.toString()
                                  ),
                                  style: Theme.of(context).textTheme.subtitle1,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 56, top: 10),
                        child: Divider(
                          color: Colors.black.withOpacity(0.1),
                          thickness: 1,
                        ),
                      ),
                      SizedBox(height: 20,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Due Date',
                            style: Theme.of(context).textTheme.headline6,
                          ),
                          SizedBox(height:10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(width:15),
                              Icon(Icons.date_range, color: hintColor, size: 26,),
                              //SvgPicture.asset('assets/bell.svg', height: 26, width: 26,),
                              SizedBox(width:15),
                              Expanded(
                                child: InkWell(
                                  onTap: (){
                                    if (isMenuOpen) {
                                      closeMenu();
                                    } else {
                                      openMenu(
                                        dueDateKey,
                                        CustomMenu(
                                          menuIcons: [
                                            Icons.today_outlined,
                                            Icons.calendar_today_outlined,
                                            Icons.next_week_outlined,
                                            Icons.repeat_rounded,
                                            Icons.date_range_outlined
                                          ],
                                          menuTitles: [
                                            'Today',
                                            'Tomorrow',
                                            'Next Week',
                                            'Everyday',
                                            'Pick a date'
                                          ],
                                          onPressed: [
                                            () {
                                              closeMenu();
                                              setState(() {
                                                _everyday = false;
                                                _dateTime = DateTime.now();
                                              });
                                            },
                                            () {
                                              closeMenu();
                                              setState(() {
                                                _everyday = false;
                                                _dateTime = DateTime.now().add(Duration(days: 1));
                                              });
                                            },
                                            () {
                                              closeMenu();
                                              setState(() {
                                                _everyday = false;
                                                _dateTime = DateTime.now().add(Duration(days: 7));
                                              });
                                            },
                                            (){
                                              closeMenu();
                                              setState(() {
                                                _everyday = true;
                                                _dateTime = null;
                                              });
                                            },
                                            () async{
                                              closeMenu();
                                              await showDatePicker(
                                                context: context, initialDate: _dateTime ?? DateTime.now(),
                                                 firstDate: DateTime.now(), lastDate: DateTime.now().add(Duration(days: 365*5))
                                              ).then((value) {
                                                setState(() {
                                                  _everyday = false;
                                                  _dateTime = value ?? _dateTime;
                                                });
                                              });
                                            },
                                          ],
                                        )
                                      );
                                    }
                                  },
                                  child: Container(
                                    key: dueDateKey,
                                    child: Text(
                                      _dateTime == null ? ( _everyday ? 'Everyday' : 'Set a due date') :(
                                        _dateTime.day.toString() +' ' + _dateTime.month.toString() +', '+_dateTime.year.toString()
                                      ),
                                      style: Theme.of(context).textTheme.subtitle1,
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 56, top: 10),
                        child: Divider(
                          color: Colors.black.withOpacity(0.1),
                          thickness: 1,
                        ),
                      ),
                      SizedBox(height: 20,),
                      Text(
                        'Location',
                        style: Theme.of(context).textTheme.headline6,
                      ),
                      SizedBox(height:10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(width:15),
                          Icon(Icons.location_on_outlined, color: hintColor, size: 26,),
                          SizedBox(width:15),
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                if (isMenuOpen) {
                                  closeMenu();
                                } else {
                                  openMenu(
                                    pickLocationKey,
                                    CustomMenu(
                                      menuIcons: [
                                        Icons.location_on_outlined,
                                        Icons.location_searching
                                      ],
                                      menuTitles: [
                                        'Choose from saved locations',
                                        'Pick a Location'
                                      ],
                                      onPressed: [
                                        ()=> closeMenu(),
                                        () {
                                          closeMenu();
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context)=> PickLocation(setCoordinates: updateCoordinates,)
                                            )
                                            );
                                        },
                                      ],
                                    )
                                  );
                                }
                              },
                              child: Container(
                                key: pickLocationKey,
                                child: Text(
                                  _coordinates != null ? (_coordinates.latitude.toString() + ','+ _coordinates.longitude.toString()) :'Pick a location',
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  style: _coordinates != null ? TextStyle(
                                    color: subtitleColor,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16,
                                  ) :Theme.of(context).textTheme.subtitle1,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                      SizedBox(height:10),
                      LocationStatus(
                        locationStatus: _locationStatus,
                        entering: () => setState(()=> _locationStatus =1),
                        at :() => setState(()=> _locationStatus =2),
                        leaving: () => setState(()=> _locationStatus =3),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 56, top: 10),
                        child: Divider(
                          color: Colors.black.withOpacity(0.1),
                          thickness: 1,
                        ),
                      ),
                      SizedBox(height: 20,),
                      AddNote(
                        onChange: (val)=> setState(()=>_note = val),
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    BottomRightButton(
                      iconData: Icons.add,
                      text: 'Add reminder',
                      onPressed: (){
                        //TODO: add reminder to database and set a notification
                      },
                    ),
                  ],
                )
              ],
            ),
          ),
        )
      ),
    );
  }
}