import 'package:flutter/material.dart';
import 'package:geo_reminders/res/colors.dart';
import 'package:geo_reminders/screens/locations/location_grid.dart';
import 'package:geo_reminders/screens/new_location/new_location.dart';
import 'package:geo_reminders/widgets/bottom_right_btn.dart';

class Locations extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height:30),
            Text(
              'Add locations to easily add them in reminders.',
              style: TextStyle(
                fontSize: 16.0,
                color: subtitleColor,
                fontWeight: FontWeight.w600
              ),
            ),
            SizedBox(height:20),
            LocationsGrid()
          ],
        ),
        BottomRightButton(
          text: 'Add Location',
          iconData: Icons.add,
          onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>NewLocation()));
          },
        ),
      ],
    );
  }
}