import 'package:flutter/material.dart';
import 'package:geo_reminders/models/location.dart';
import 'package:geo_reminders/res/colors.dart';
import 'package:geo_reminders/widgets/bottom_right_btn.dart';
import 'package:geo_reminders/widgets/cross_button.dart';
import 'package:geo_reminders/widgets/header_with_underline.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';


class PickLocation extends StatefulWidget {
  const PickLocation({Key key, this.setCoordinates}) : super(key: key);

  @override
  _PickLocationState createState() => _PickLocationState();
  
  final Function setCoordinates;
}

class _PickLocationState extends State<PickLocation> {

  static const LatLng _center = const LatLng(45.521563, -122.677433);
  LatLng _lastMapPosition = _center;
  Set<Marker> _marker = {Marker(
    markerId: MarkerId(_center.toString()),
    position: _center,
    icon: BitmapDescriptor.defaultMarker
  )};

  void _onLocationTap(LatLng position){
    setState(() {
      _lastMapPosition = position;
      _marker.clear();
      _marker.add(Marker (
        markerId: MarkerId(position.toString()),
        position: position,
        infoWindow: InfoWindow(
          title: 'New Location',
        ),
        icon: BitmapDescriptor.defaultMarker
      ));
    });
  }

  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
                  child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              Padding(
                padding: EdgeInsets.only(top:10, left:15, right: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CrossButton(),
                    HeaderWithUnderline(text: 'Pick Location'),
                    SizedBox(height:30),
                    Text(
                      'Coordinates',
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    SizedBox(height:10),
                    Row(
                      mainAxisAlignment:  MainAxisAlignment.start,
                      children: [
                        SizedBox(width:15),
                        Icon(Icons.location_on_outlined, color: hintColor, size: 26,),
                        SizedBox(width:15),
                        Flexible(
                          child: Text(
                            (_lastMapPosition.latitude.toString() + ','+ _lastMapPosition.longitude.toString()),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 16,
                              color: subtitleColor,
                              fontWeight: FontWeight.w600
                            ),
                          )
                        )
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(left:56, top:10),
                      child: Divider(
                        color: Colors.black.withOpacity(0.1),
                        thickness: 1,
                      ),
                    ),
                    SizedBox(height: 20),
                    Container(
                      height: size.height*0.6,
                      child: GoogleMap(
                        markers: _marker,
                        mapType: MapType.normal,
                        initialCameraPosition: CameraPosition(
                          target: _center,
                          zoom: 11,
                        ),
                        myLocationButtonEnabled: true,
                        myLocationEnabled: true,
                        onTap: _onLocationTap,
                      ),
                    )
                  ],
                )
              ),
              SizedBox(height:20),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  BottomRightButton(
                    text: 'Done',
                    iconData: Icons.done,
                    onPressed: () {
                      Location location = Location(latitude: _lastMapPosition.latitude, longitude: _lastMapPosition.longitude);
                      widget.setCoordinates(location);
                      Navigator.pop(context);
                    } ,
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}