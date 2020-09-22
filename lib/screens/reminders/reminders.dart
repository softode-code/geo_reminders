import 'package:flutter/material.dart';
import 'package:geo_reminders/screens/new_reminder/new_reminder.dart';
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
            Center(
              child: Text('Reminders'),
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