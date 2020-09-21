import 'package:flutter/material.dart';
import 'package:geo_reminders/models/location.dart';


class LocationTile extends StatelessWidget {
  const LocationTile({
    Key key,
    @required this.location,
  }) : super(key: key);

  final Location location;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Color(location.colorCode)
      ),
      padding: EdgeInsets.symmetric(vertical: 15, horizontal: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            location.name,
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
                  location.latitude.toString(),
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
                location.longitude.toString(),
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
}