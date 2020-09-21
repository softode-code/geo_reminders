import 'package:flutter/material.dart';
import 'package:geo_reminders/database/db_helper.dart';
import 'package:geo_reminders/models/location.dart';
import 'package:geo_reminders/res/colors.dart';
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
                fontWeight: FontWeight.w400
              ),
            ),
            StreamBuilder(
              stream: DBHelper().getLocations().asStream(),
              builder: (context, snapshot){
                if (snapshot.hasData){
                  List<Location> locations = snapshot.data;
                  for(int i=0; i< locations.length; i++){
                    print(locations[i].toMap());
                  }
                  return Expanded(
                     child: ListView.builder(
                      itemCount: locations.length,
                      itemBuilder: (context, index){
                        return Padding(
                          padding: EdgeInsets.all(5),
                          child: Text(
                            locations[index].name,
                            style: TextStyle(
                              color: Colors.black
                            ),
                          ),
                        );
                      }
                    ),
                  );
                }
                return Container(
                  height: 100,
                  width: 200,
                  color: Colors.black,
                );
              },
            )
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