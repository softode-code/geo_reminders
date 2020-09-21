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
                fontWeight: FontWeight.w600
              ),
            ),
            SizedBox(height:20),
            StreamBuilder(
              stream: DBHelper().getLocations().asStream(),
              builder: (context, snapshot){
                if (snapshot.hasData){
                  List<Location> locations = snapshot.data;
                  return Expanded(
                    child: GridView.count(
                      childAspectRatio: 1.5,
                      mainAxisSpacing: 24,
                      crossAxisSpacing: 27,
                      padding: EdgeInsets.all(20),
                      crossAxisCount: 2,
                      children: List.generate(
                        locations.length,
                        (index) {
                          return Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Color(locations[index].colorCode)
                            ),
                            padding: EdgeInsets.symmetric(vertical: 15, horizontal: 12),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  locations[index].name,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18
                                  ),
                                ),
                                SizedBox(height:10),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Latitude: ',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 12
                                      ),
                                    ),
                                    Flexible(
                                      child: Text(
                                        locations[index].latitude.toString(),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Longitude: ',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 12
                                      ),
                                    ),
                                    Flexible(
                                    child: Text(
                                      locations[index].longitude.toString(),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold
                                      ),
                                    ),
                                    )
                                  ],
                                )
                              ],
                              ),
                          );
                        }
                       ),
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