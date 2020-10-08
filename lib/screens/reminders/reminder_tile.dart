import 'package:flutter/material.dart';
import 'package:geo_reminders/models/reminder.dart';
import 'package:geo_reminders/res/colors.dart';

class ReminderTile extends StatelessWidget {
  const ReminderTile({
    Key key,
    @required this.reminder,
  }) : super(key: key);

  final Reminder reminder;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(15),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          //mark as done circle
          Row(
            children: [
              Container(
                height: 20,
                width: 20,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.transparent,
                  border: Border.all(
                    color: primaryColor,
                    width: 1
                  )
                ),
              ),
              SizedBox(width: 15),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    reminder.name,
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black
                    ),
                  ),
                  Text(
                    reminder.note ?? '',
                    style: TextStyle(
                      color: hintColor,
                      fontSize: 12.0,
                      fontWeight: FontWeight.normal
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(Icons.location_on_outlined, size: 19, color: hintColor,),
                      SizedBox(width:8),
                      Text(
                        reminder.locationStatus == 2 ? 'Entering' : 'Leaving',
                        style: TextStyle(
                          fontSize: 12.0,
                          color: hintColor
                        )
                      )
                    ],
                  )
                ],
              ),
            ],
          ),
          
          Align(
            alignment: Alignment.centerRight,
            child: Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.transparent,
                border: Border.all(color: primaryColor, width: 1),
                borderRadius: BorderRadius.circular(4)
              ),
              child: Text(
                'Today 4:50 pm',
                style: TextStyle(
                  color: primaryColor,
                  fontSize: 14.0,
                  fontWeight: FontWeight.w600
                ),
              ),
            ),
          )
        ],
      )
    );
  }
}