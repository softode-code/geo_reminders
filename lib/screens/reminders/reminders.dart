import 'package:flutter/material.dart';
import 'package:geo_reminders/database/db_helper.dart';
import 'package:geo_reminders/models/reminder.dart';
import 'package:geo_reminders/screens/new_reminder/new_reminder.dart';
import 'package:geo_reminders/screens/reminders/reminders_list.dart';
import 'package:geo_reminders/widgets/bottom_right_btn.dart';

class Reminders extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            StreamBuilder<List<Reminder>>(
              stream: DBHelper().getReminders().asStream(),
              builder: (context, snapshot) {
                if(snapshot.hasData){
                  List<Reminder> reminders = snapshot.data;
                  return RemindersList(reminders: reminders);
                } else {
                  return SizedBox.shrink();
                }
              },
            )
          ],
        ),
        BottomRightButton(
          text: 'Add Reminder',
          iconData: Icons.add,
          onPressed: (){
            Navigator.push(context, MaterialPageRoute(
              builder: (context)=> NewReminder()
            ));
          },
        )
      ],
    );
  }
}