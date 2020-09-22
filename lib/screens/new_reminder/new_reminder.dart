import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geo_reminders/res/colors.dart';
import 'package:geo_reminders/screens/new_reminder/location_status.dart';
import 'package:geo_reminders/widgets/cross_button.dart';
import 'package:geo_reminders/widgets/header_with_underline.dart';
import 'package:geo_reminders/widgets/outline_input_field_with_title.dart';

class NewReminder extends StatefulWidget {
  @override
  _NewReminderState createState() => _NewReminderState();
}

class _NewReminderState extends State<NewReminder> {

  final _formkey = GlobalKey<FormState>();
  String _reminderName;
  int _locationStatus;
  String _note;

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
                          Text(
                            'Add time',
                            style: Theme.of(context).textTheme.subtitle1,
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
                      Text(
                        'Due Date',
                        style: Theme.of(context).textTheme.headline6,
                      ),
                      SizedBox(height:10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(width:15),
                          Icon(Icons.calendar_today, color: hintColor, size: 26,),
                          //SvgPicture.asset('assets/bell.svg', height: 26, width: 26,),
                          SizedBox(width:15),
                          Text(
                            'Set a due date',
                            style: Theme.of(context).textTheme.subtitle1,
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
                          Text(
                            'Pick a location',
                            style: Theme.of(context).textTheme.subtitle1,
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

                      Text(
                        'Note',
                        style: Theme.of(context).textTheme.headline6,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(width:15),
                          Padding(
                            padding: const EdgeInsets.only(top:10),
                            child: Icon(Icons.notes_outlined, color: hintColor, size: 26,),
                          ),
                          SizedBox(width:15),
                          Expanded(
                            child: TextFormField(
                              style: TextStyle(
                                fontSize: 16,
                                color: subtitleColor
                              ),
                              maxLines: 5,
                              onChanged: (val)=> setState(()=>_note = val),
                              validator: (val) => null,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                errorBorder: InputBorder.none,
                                hintText: 'Add a note',
                                hintStyle: Theme.of(context).textTheme.subtitle1
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        )
      ),
    );
  }
}