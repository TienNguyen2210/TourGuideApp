import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class GoogleMapWidget extends StatefulWidget {
  final Set<Marker> markers;

  const GoogleMapWidget({super.key, required this.markers});

  @override
  State<GoogleMapWidget> createState() => _GoogleMapWidgetState();
}

class _GoogleMapWidgetState extends State<GoogleMapWidget> {
  Location locationController = Location();
  late GoogleMapController mapController;
  LatLng? currentPosition;
  /* Map<PolylineId, Polyline> polylines = {}; */

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async => await getCurrentLocation());
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return currentPosition == null 
        ? const Center(child: CircularProgressIndicator()) 
        : GoogleMap(
            onMapCreated: _onMapCreated,
            initialCameraPosition: CameraPosition(
              target: currentPosition!,
              zoom: 15.0,
            ),
            markers: widget.markers,  
            /* polylines: Set<Polyline>.of(polylines.values), */
            myLocationEnabled: true,
            myLocationButtonEnabled: true,    
          );
  }

  Future<void> getCurrentLocation() async { 
    bool serviceEnabled;
    PermissionStatus permissionGranted;

    serviceEnabled = await locationController.serviceEnabled();
    if (serviceEnabled) {
      serviceEnabled = await locationController.requestService();
      if (!serviceEnabled) {
        return;
      }
    }
    permissionGranted = await locationController.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await locationController.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return;
      }
    }
    
    locationController.onLocationChanged.listen((currentLocation) {
      if(currentLocation.latitude != null && currentLocation.longitude != null) {
        setState(() {
          currentPosition = LatLng(
            currentLocation.latitude!,
            currentLocation.longitude!,
          );
        });
      }
    });
  }

  /* Future<List<LatLng>> fetchPolyPoints() async {
    final polylinePoints = PolylinePoints();
    final polylineResult = await polylinePoints.getRouteBetweenCoordinates(
      googleMapsApiKey,
      PointLatLng(currentPosition!.latitude, currentPosition!.longitude),
      PointLatLng(publicMarket.latitude, publicMarket.longitude),
    );
    
    if(polylineResult.points.isNotEmpty) {
      return polylineResult.points
        .map((point) => LatLng(point.latitude, point.longitude))
        .toList();
    } else {
      print(polylineResult.errorMessage);
      return [];
    }   
  }   */
}