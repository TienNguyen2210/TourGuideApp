import 'package:flutter/material.dart';
import 'package:tour_guide_app/service/auth.dart';
import 'package:tour_guide_app/utilities/constant.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart' as geocoding;
import 'package:google_maps_webservice/places.dart';
import 'package:tour_guide_app/widgets/place_card_home.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String currentLocation = '';
  List<PlacesSearchResult> places = [];
  List<PlacesSearchResult> popularDestinations = [];

  @override
  void initState() {
    super.initState();
    getCurrentLocation().then((_) {
      fetchThingsToDo();
      fetchPopularDestinations();
    });
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
      keyword: 'restaurant', // temporary keyword because there is no things to do nearby
    );

    if (response.status == "OK") {
      setState(() {
        places = response.results;
      });
    } else {
      print(response.errorMessage);
    }
  }

  Future<void> fetchPopularDestinations() async {
    Position position = await Geolocator.getCurrentPosition();
    final locations = GoogleMapsPlaces(apiKey: googleMapsApiKey);

    PlacesSearchResponse response = await locations.searchNearbyWithRadius( 
      Location(lat: position.latitude, lng: position.longitude),
      1000,
      keyword: 'shop',
    );

    if (response.status == "OK") {
      setState(() {
        popularDestinations = response.results;
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
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 3.0),
                          child: Text(
                            // Display the name of user
                            'Hi, ${Auth().currentUser?.email ?? 'User'}!',
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(height: 5),
                        // Display current location
                        Row(children: [
                          Icon(Icons.location_on, size: 17, color: Color.fromARGB(255, 58, 204, 114)), 
                          SizedBox(width: 2),
                          Text(
                          currentLocation,
                          style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                        )]),
                      ],
                    ),
                    Spacer(),
                    CircleAvatar(
                      radius: 23,
                      // Display user profile picture here
                      // backgroundImage: NetworkImage(Auth().currentUser?.photoURL),
                      backgroundImage: NetworkImage('https://pbs.twimg.com/media/FjU2lkcWYAgNG6d.jpg'),  // test
                    )
                  ],
                ),
                SizedBox(height: 16),
                Divider(
                  color: Color.fromARGB(255, 231, 226, 226),
                  thickness: 1.0,
                ),
                SizedBox(height: 15),
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
                      return PlaceCardHome(place: place);
                    },
                  ),
                ),
                Divider(
                  color: Color.fromARGB(255, 231, 226, 226),
                  thickness: 1.0,
                ),
                SizedBox(height: 15),
                Text(
                  'Popular Destinations', 
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)
                ),
                SizedBox(height: 12),
                SizedBox(
                  height: 350, 
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: popularDestinations.length, 
                    itemBuilder: (context, index) {
                      final nightclub = popularDestinations[index];
                      return PlaceCardHome(place: nightclub);
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}