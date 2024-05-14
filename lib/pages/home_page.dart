import 'package:flutter/material.dart';
import 'package:tour_guide_app/utilities/constant.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart' as geocoding;
import 'package:google_maps_webservice/places.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String currentLocation = '';
  List<PlacesSearchResult> places = [];

  @override
  void initState() {
    super.initState();
    getCurrentLocation();
    fetchThingsToDo();
  }

  Future<void> getCurrentLocation() async { 
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
        'Location permissions are permanently denied, we cannot request permissions.'
      );
    }

    Position position = await Geolocator.getCurrentPosition();
    List<geocoding.Placemark> placemarks = await geocoding.placemarkFromCoordinates(position.latitude, position.longitude);
    geocoding.Placemark place = placemarks[0];
    setState(() {
      currentLocation = '${place.locality}, ${place.country}';
    }); 
  }

  Future<void> fetchThingsToDo() async {
    Position position = await Geolocator.getCurrentPosition();
    final locations = GoogleMapsPlaces(apiKey: googleMapsApiKey);

    PlacesSearchResponse response = await locations.searchNearbyWithRadius(
      Location(lat: position.latitude, lng: position.longitude),
      1000,
      keyword: 'restaurant',
    );

    if (response.status == "OK") {
      setState(() {
        places = response.results;
      });
    } else {
      print(response.errorMessage);
    }
  }

  @override
  Widget build(BuildContext context) {
    return currentLocation.isEmpty ? 
    Center(child: CircularProgressIndicator(
      color: Color.fromARGB(255, 226, 140, 12),
    )) 
    : SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Display current location
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Text(
                  currentLocation,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 16),
              Divider(
                color: Color.fromARGB(255, 231, 226, 226),
                thickness: 1.0,
              ),
              SizedBox(height: 25),
              Text(
                'Experiences in spotlight', 
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)
              ),
              SizedBox(height: 12),
              SizedBox(
                height: 350, 
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: places.length, 
                  itemBuilder: (context, index) {
                    final place = places[index];
                    String photoUrl = '';
                    if (place.photos.isNotEmpty) {
                      photoUrl = 'https://maps.googleapis.com/maps/api/place/photo?maxwidth=400&photoreference=${place.photos[0].photoReference}&key=$googleMapsApiKey';
                    }
                    return Padding(
                      padding: const EdgeInsets.only(right: 20.0, top: 8.0),
                      child: Container(
                        width: 300, 
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: 225,
                              width: 300,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(15),
                                child: photoUrl.isNotEmpty ? Image.network(photoUrl, fit: BoxFit.cover) : SizedBox.shrink()
                              ),
                            ),
                            SizedBox(height: 10),
                            Text(
                              place.name, 
                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                              textAlign: TextAlign.start
                            ),
                            SizedBox(height: 5),
                            Text(
                              place.openingHours!.openNow ? 'Open Now' : 'Closed', 
                              style: TextStyle(fontSize: 14 , fontWeight: FontWeight.bold, color: const Color.fromARGB(255, 119, 118, 118)),                  
                            ),
                            SizedBox(height: 5),
                            Row(
                              children: [
                                Text(
                                '${place.vicinity}',
                                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Color.fromARGB(255, 240, 165, 5)),
                                ),
                                Spacer(),
                                Container(
                                  height: 28,
                                  width: 50,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: Color.fromARGB(255, 3, 197, 3),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        place.rating.toString(),
                                        style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),
                                      ),
                                      SizedBox(width: 3),
                                      Icon(Icons.star, color: Colors.white, size: 14),
                                    ]
                                  ),
                                ),
                              ],
                            )
                          ]  
                        ),
                      ),
                    );
                  },
                ),
              ), 
            ],
          ),
        ),
      ),
    );
  }
}