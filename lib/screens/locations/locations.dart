import 'package:flutter/material.dart';
import 'package:geo_reminders/res/colors.dart';
import 'package:geo_reminders/screens/new_location/new_location.dart';
import 'package:geo_reminders/widgets/bottom_right_btn.dart';

class Locations extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        BottomRightButton(
          text: 'Add Location',
          iconData: Icons.add,
          onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>NewLocation()));
          },
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height:30),
            Text(
              'Add locations to easily add them in reminders.',
              style: TextStyle(
                fontSize: 16.0,
                color: subtitleColor,
                fontWeight: FontWeight.w400
              ),
            )
          ],
        ),
      ],
    );
  }
}