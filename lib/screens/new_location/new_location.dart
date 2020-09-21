import 'package:flutter/material.dart';
import 'package:geo_reminders/res/colors.dart';
import 'package:geo_reminders/services/geo_location.dart';
import 'package:geo_reminders/widgets/bottom_right_btn.dart';
import 'package:geo_reminders/widgets/cross_button.dart';
import 'package:geo_reminders/widgets/header_with_underline.dart';
import 'package:geo_reminders/widgets/outline_input_field_with_title.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class NewLocation extends StatefulWidget {
  @override
  _NewLocationState createState() => _NewLocationState();
}

class _NewLocationState extends State<NewLocation> {

  bool _validData = false;
  String _locationName;
  int _locationColorIndex = 0;
  String _coordinates = 'Coordinates';

  final _formkey = GlobalKey<FormState>();
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
          title: _locationName ?? 'New Location',
        ),
        icon: BitmapDescriptor.defaultMarker
      ));
    });
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    GeoService.getPermission();
  }

  @override
  Widget build(BuildContext context) {
    
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
        child: Form(
          key: _formkey,
          child: SingleChildScrollView(
              child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(top:10, left: 15, right:15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CrossButton(),
                      HeaderWithUnderline(text: 'Add Location',),
                      SizedBox(height:30),
                      OutlineInputFieldWithTitle(
                        title: 'Location',
                        hint: 'Name of Location',
                        onChanged: (val){
                          setState(() {
                            _locationName = val;
                            if(_locationName != null && _coordinates != null) {
                              if (_locationName.isNotEmpty){
                                _validData = true;
                                return;
                              }
                              _validData = false;
                            }
                          });
                        },
                        validator: (val)=> val.isEmpty ? 'Enter a location name.' : null,
                      ),
                      SizedBox(height:20),
                      Text(
                        'Color',
                        style: Theme.of(context).textTheme.headline6,
                      ),
                      SizedBox(height: 10,),
                      //Colors List
                      Container(
                        padding: EdgeInsets.only(left:15),
                        height: 30,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: locationColors.length,
                          itemBuilder: (context, index){
                            return GestureDetector(
                              onTap: (){
                                setState(() {
                                  _locationColorIndex = index;
                                });
                              },
                              child: Container(
                                margin: EdgeInsets.symmetric(horizontal:5),
                                height: 27,
                                width: 27,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: locationColors[index],
                                  border: index == _locationColorIndex ? Border.all(
                                    color: primaryColor,
                                    width: 3
                                  ) :null,
                                ),
                              ),
                            );
                          }
                        ),
                      ),
                      SizedBox(height: 20),
                      Text(
                        'Coordinates',
                        style: Theme.of(context).textTheme.headline6,
                      ),
                      SizedBox(height:10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(width:15),
                          Icon(Icons.location_on_outlined, color: hintColor, size: 26,),
                          SizedBox(width: 15),
                          Flexible(
                          child: Text(
                              (_lastMapPosition.latitude.toString() + ','+ _lastMapPosition.longitude.toString()) ?? 'Longitude, Latitude',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 16,
                                color: _coordinates == null? hintColor : subtitleColor,
                                fontWeight: _coordinates == null? FontWeight.normal : FontWeight.w600
                              ),
                            ),
                          )
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 56, top: 10),
                        child: Divider(
                          color: Colors.black.withOpacity(0.1),
                          thickness: 1,
                        ),
                      ),
                      SizedBox(height: 20,),
                      Container(
                        height: size.height*0.45,
                        child: Stack(
                          children: [
                            GoogleMap(
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
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height:20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    BottomRightButton(
                      text: 'Add',
                      iconData: Icons.add,
                      disabled: !_validData,
                      onPressed: (){
                        //TODO: Add location to database
                        if(_formkey.currentState.validate()){
                          print('Add to database');
                        }
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}