import 'package:flutter/material.dart';
import 'package:geo_reminders/database/db_helper.dart';
import 'package:geo_reminders/models/location.dart';
import 'package:geo_reminders/res/colors.dart';
import 'package:geo_reminders/widgets/bottom_right_btn.dart';
import 'package:geo_reminders/widgets/cross_button.dart';
import 'package:geo_reminders/widgets/header_with_underline.dart';


class PickFromSavedLocations extends StatefulWidget {
  const PickFromSavedLocations({Key key, this.onPick}) : super(key: key);

  @override
  _PickFromSavedLocationsState createState() => _PickFromSavedLocationsState();
  final Function onPick;
}

class _PickFromSavedLocationsState extends State<PickFromSavedLocations> {

  int _selectedIndex;
  Location _location;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Padding(
              padding: EdgeInsets.only(top:10, left:15, right: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CrossButton(),
                  HeaderWithUnderline(text: 'Your Locations'),
                  SizedBox(height:20),
                  StreamBuilder<List<Location>>(
                    stream: DBHelper().getLocations().asStream(),
                    builder: (context, snapshot){
                      if (snapshot.hasData){
                        List<Location> locations = snapshot.data;
                        return Expanded(
                          child: ListView.builder(
                            itemCount: locations.length,
                            itemBuilder: (context, index){
                              return InkWell(
                                onTap: (){
                                  setState(() {
                                    _location = locations[index];
                                    _selectedIndex = index;
                                  });
                                },
                                child: Card(
                                  color: _selectedIndex == index ? Color(locations[index].colorCode) : null,
                                  elevation: 5,
                                  margin: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                                  child: Container(
                                    padding: EdgeInsets.all(10),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          locations[index].name,
                                          style: TextStyle(
                                            color: _selectedIndex == index ? Colors.white : Color(locations[index].colorCode),
                                            fontSize: 20,
                                            fontWeight: FontWeight.w600
                                          ),
                                        ),
                                        SizedBox(height: 5,),
                                         Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Latitude: ',
                                              style: TextStyle(
                                                color: _selectedIndex == index ? Colors.white :  hintColor,
                                                fontSize: 12
                                              ),
                                            ),
                                            Flexible(
                                              child: Text(
                                                locations[index].latitude.toString(),
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                  color: _selectedIndex == index ? Colors.white :  subtitleColor,
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
                                                color: _selectedIndex == index ? Colors.white :  hintColor,
                                                fontSize: 12
                                              ),
                                            ),
                                            Flexible(
                                            child: Text(
                                              locations[index].longitude.toString(),
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                color: _selectedIndex == index ? Colors.white :  subtitleColor,
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold
                                              ),
                                            ),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        );
                      }
                      return Center(
                        child: Text(
                          'No saved locations'
                        ),
                      );
                    }
                  )
                ],
              ),
            ),
            BottomRightButton(
              onPressed: (){
                widget.onPick(_location);
                Navigator.pop(context);
              },
              text: 'Done',
              iconData: Icons.done,
            )
          ],
        ),
      ),
    );
  }
}