import 'package:geolocator/geolocator.dart';

class GeoService {

  static void getPermission() async {
    LocationPermission permission = await checkPermission();
    if(permission == LocationPermission.denied){
      permission = await requestPermission();
    }
  }
}