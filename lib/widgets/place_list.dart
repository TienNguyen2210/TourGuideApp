import 'package:flutter/material.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:tour_guide_app/widgets/place_card.dart';

class PlaceList extends StatelessWidget {
  final List<PlacesSearchResult> places; 
  
  const PlaceList({super.key, required this.places});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: places.map((place) => PlaceCard(place: place)).toList(),
      ),
    );
  }
}