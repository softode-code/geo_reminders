import 'package:flutter/material.dart';
import 'package:geo_reminders/database/db_helper.dart';
import 'package:geo_reminders/models/location.dart';
import 'package:geo_reminders/screens/locations/location_tile.dart';


class LocationsGrid extends StatelessWidget {
  const LocationsGrid({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
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
                  return LocationTile(location: locations[index]);
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
    );
  }
}