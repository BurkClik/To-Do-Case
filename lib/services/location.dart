import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

class Location {
  String adArea;
  String subArea;

  Future<void> getLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.best);
      List<Placemark> placemarks =
          await placemarkFromCoordinates(position.latitude, position.longitude);
      subArea = placemarks.last.subAdministrativeArea;
      adArea = placemarks.last.administrativeArea;
    } catch (e) {}
  }
}
