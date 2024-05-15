import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:provider/provider.dart';
import 'package:tour_guide_app/models/place.dart';
import 'package:tour_guide_app/service/locationProvider.dart';
import 'package:tour_guide_app/utilities/constant.dart';
import 'package:tour_guide_app/widgets/google_map.dart';
import 'package:google_api_headers/google_api_headers.dart';
import 'package:tour_guide_app/widgets/place_list.dart'; 

class FilterOption {
  final String text;
  final IconData iconData;

  FilterOption({required this.text, required this.iconData});
}

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchSreenState();
}

class _SearchSreenState extends State<SearchScreen> {
  final homeScaffoldKey = GlobalKey<ScaffoldState>();
  List<Place> placesList = [];
  TextEditingController searchController = TextEditingController();
  Set<Marker> markers = {};
  String selectedOption = '';
  

  final List<FilterOption> filterOptions = [
    FilterOption(text: 'Coffee', iconData: Icons.local_cafe),
    FilterOption(text: 'Restaurants', iconData: Icons.restaurant),
    FilterOption(text: 'Park', iconData: Icons.park),
    FilterOption(text: 'Hotels', iconData: Icons.hotel),
    FilterOption(text: 'Museums', iconData: Icons.museum_outlined),
  ];

  List<Widget> buildFilterChips(List<FilterOption> filters) {
    return filterOptions.map((option) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5.0),
        child: FilterChip(
          avatar: Icon(option.iconData, size: 13, color: selectedOption == option.text ? Color.fromARGB(255, 235, 252, 6) : Colors.black),
          label: Text(option.text),
          labelStyle: TextStyle(color: selectedOption == option.text ? Colors.white : Color.fromARGB(255, 212, 19, 93), fontSize: 12),
          onSelected: (isSelected) {
            if (isSelected) {
              setState(() {
                selectedOption = option.text;
              });
              performNearBySearch(context, option.text.toLowerCase());
            } else {
              setState(() {
                selectedOption = '';
              });
            }
          },
          selected: selectedOption == option.text,
          selectedColor: Color.fromARGB(255, 190, 20, 190),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50.0),
            side: BorderSide(
              color: Color.fromARGB(255, 0, 0, 0), // Border color
              width: 0.5, // Border width
            ),
          ),
          showCheckmark: false,
        ),
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: homeScaffoldKey,
      body: SafeArea(
        child: Stack(
          children: [
            GoogleMapWidget(markers: markers),
            Positioned(
              top: 16.0,
              left: 16.0,
              right: 16.0,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(50.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.6),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: TextField(
                    controller: searchController,
                    decoration: InputDecoration(
                      hintText: 'Search...',
                      border: InputBorder.none,
                      prefixIcon: Icon(Icons.place, color: Color.fromARGB(255, 48, 153, 64)),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              top: 70.0, 
              left: 16.0,
              right: 16.0,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: buildFilterChips(filterOptions),
                  ),
              ),
            ),
            // Display the place list at the bottom of the screen and on top of the map
            Positioned(
              bottom: 5.0,
              left: 16.0,
              right: 16.0,
              child: PlaceList(places: placesList),
            ),
            ],    
          ),  
      )
    );
  }

  Future<void> handleSearch() async {
    Prediction? p = await PlacesAutocomplete.show(
      context: context, 
      apiKey: googleMapsApiKey, 
      onError: onError,
      mode: Mode.overlay, 
      language: "en", 
    );

     displayPrediction(p!, homeScaffoldKey.currentState);
  }

  void onError(PlacesAutocompleteResponse response) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      elevation: 0,
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      content: AwesomeSnackbarContent(
        title: 'Message',
        message: response.errorMessage!,
        contentType: ContentType.failure,
      ), 
    ));
  }

  Future<void> displayPrediction(Prediction p, ScaffoldState? currentState) async {
    GoogleMapsPlaces places = GoogleMapsPlaces(
      apiKey: googleMapsApiKey,
      apiHeaders: await const GoogleApiHeaders().getHeaders(),
    );
    PlacesDetailsResponse detail = await places.getDetailsByPlaceId(p.placeId!);
    double lat = detail.result.geometry!.location.lat;
    double lng = detail.result.geometry!.location.lng;
    markers.clear();
    markers.add(Marker(
      markerId: MarkerId(p.placeId!),
      position: LatLng(lat, lng),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueOrange),
      infoWindow: InfoWindow(
        title: detail.result.name,
      ),
    ));
    
    /* setState(() {});
    mapController!.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(target: LatLng(lat, lng), zoom: 15.0),
      ),
    ); */
  }

  Future<void> performNearBySearch(BuildContext context, String keyword) async {
    final places = GoogleMapsPlaces(apiKey: googleMapsApiKey);
    final locationProvider = Provider.of<LocationProvider>(context, listen: false);
    final userLocation = locationProvider.userLocation;
    
    PlacesSearchResponse response = await places.searchNearbyWithRadius(
      Location(lat: userLocation!.latitude, lng: userLocation.longitude),
      500,
      keyword: keyword
    );
    /* BitmapDescriptor bitmapDescriptor = await BitmapDescriptor.fromAssetImage(
      ImageConfiguration(size: Size(5, 5)),
      'assets/marker.png'
    );  */
    if (response.status == "OK") {
      setState(() {
        markers.clear();
        placesList.clear();
        for (PlacesSearchResult result in response.results) {
          double lat = result.geometry!.location.lat;
          double lng = result.geometry!.location.lng;
          markers.add(Marker(
            markerId: MarkerId(result.placeId),
            position: LatLng(lat, lng),
            infoWindow: InfoWindow(
              title: result.name,
            ),
          ));
          
          String photoUrl = '';
          if (result.photos.isNotEmpty) {
            photoUrl = 'https://maps.googleapis.com/maps/api/place/photo?maxwidth=400&photoreference=${result.photos[0].photoReference}&key=$googleMapsApiKey';
          } else {
            photoUrl = result.icon!;
          }
          final place = Place(
            id: result.placeId,
            type: result.types[0],
            name: result.name,  
            image: photoUrl,
            rating: result.rating.toString(),
          );
          placesList.add(place);
        }
      });
    } else {
      print(response.errorMessage);
    }
  }
}