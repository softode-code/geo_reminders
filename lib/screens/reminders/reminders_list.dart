import 'package:flutter/material.dart';
import 'package:geo_reminders/models/reminder.dart';
import 'package:geo_reminders/screens/reminders/reminder_tile.dart';

class RemindersList extends StatelessWidget {
  const RemindersList({
    Key key,
    @required this.reminders,
  }) : super(key: key);

  final List<Reminder> reminders;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: reminders.length,
        itemBuilder: (context, index){
          return ReminderTile(reminder: reminders[index]);
        },
      ),
    );
  }
}