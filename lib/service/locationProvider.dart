import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationProvider extends ChangeNotifier {
  LatLng? _userLocation;

  LatLng? get userLocation => _userLocation;

  void updateUserLocation(LatLng location) {
    _userLocation = location;
    notifyListeners();
  }
}
