import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geo_reminders/res/colors.dart';
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
                      SizedBox(height: 30,),
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
                      SizedBox(height:10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(width:15),
                          Icon(Icons.notes_outlined, color: hintColor, size: 26,),
                          SizedBox(width:15),
                          Text(
                            'Add a note',
                            style: Theme.of(context).textTheme.subtitle1,
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

class LocationStatus extends StatelessWidget {
  LocationStatus({
    Key key,
    @required int locationStatus, this.entering, this.at, this.leaving,
  }) : locationStatus = locationStatus, super(key: key);

  int locationStatus;
  final Function entering;
  final Function at;
  final Function leaving;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4.0),
            color: Colors.transparent,
            border: Border.all(
              color: Colors.black.withOpacity(0.1),
              width: 1
            )
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              InkWell(
                onTap: entering,
                child: Container(
                  decoration: locationStatus != null? ( locationStatus == 1 ? BoxDecoration(
                    color: primaryLight,
                    borderRadius: BorderRadius.only(topLeft:Radius.circular(4), bottomLeft:Radius.circular(4))
                  ) : null ) : null,
                  padding: EdgeInsets.all(10),
                  child: Text(
                    'Entering',
                    style: locationStatus != null ? ( 
                      locationStatus == 1 ? Theme.of(context).textTheme.subtitle2.copyWith(color: Colors.white) : Theme.of(context).textTheme.subtitle2
                    ) : Theme.of(context).textTheme.subtitle2
                  ),
                ),
              ),
              Container(
                width: 1,
                height: 25,
                color: Colors.black.withOpacity(0.1),

              ),
              InkWell(
                onTap: at,
                child: Container(
                  decoration: locationStatus != null? ( locationStatus == 2 ? BoxDecoration(
                      color: primaryLight,
                    ) : null ) : null,
                  padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                  child: Text(
                    'At',
                    style: locationStatus != null ? ( 
                      locationStatus == 2 ? Theme.of(context).textTheme.subtitle2.copyWith(color: Colors.white) : Theme.of(context).textTheme.subtitle2
                    ) : Theme.of(context).textTheme.subtitle2
                  ),
                ),
              ),
               Container(
                width: 1,
                height: 25,
                color: Colors.black.withOpacity(0.1),
                
              ),
              InkWell(
                onTap:leaving,
                child: Container(
                  decoration: locationStatus != null? ( locationStatus == 3 ? BoxDecoration(
                      color: primaryLight,
                      borderRadius: BorderRadius.only(topRight:Radius.circular(4), bottomRight:Radius.circular(4))
                    ) : null ) : null,
                  padding: EdgeInsets.all(10),
                  child: Text(
                    'Leaving',
                    style: locationStatus != null ? ( 
                      locationStatus == 3 ? Theme.of(context).textTheme.subtitle2.copyWith(color: Colors.white) : Theme.of(context).textTheme.subtitle2
                    ) : Theme.of(context).textTheme.subtitle2
                  ),
                ),
              )
            ],
          )
        )
      ],
    );
  }
}