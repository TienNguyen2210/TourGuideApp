import 'package:flutter/material.dart';
import 'package:tour_guide_app/models/place.dart';
import 'package:tour_guide_app/widgets/place_card.dart';

class PlaceList extends StatelessWidget {
  final List<Place> places; 
  
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