import 'package:flutter/material.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:tour_guide_app/utilities/constant.dart';
import 'package:tour_guide_app/pages/place_details.dart';

class PlaceCard extends StatelessWidget {
  final PlacesSearchResult place;

  const PlaceCard({super.key, required this.place});

  @override
  Widget build(BuildContext context) {
    String photoUrl = '';
    if (place.photos.isNotEmpty) {
      photoUrl = 'https://maps.googleapis.com/maps/api/place/photo?maxwidth=400&photoreference=${place.photos[0].photoReference}&key=$googleMapsApiKey';
    } else {
      photoUrl = 'https://t4.ftcdn.net/jpg/04/70/29/97/360_F_470299797_UD0eoVMMSUbHCcNJCdv2t8B2g1GVqYgs.jpg';
    }

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context, 
          MaterialPageRoute(builder: (context) => PlaceDetailScreen(place: place)),
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          width: 150, 
          height: 210,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start, 
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 4.0),
                child: Center(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      photoUrl,
                      width: 140,
                      height: 100,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 7.0, vertical: 3.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      place.types[0], 
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: const Color.fromARGB(255, 131, 129, 129),
                      ),
                    ),
                    SizedBox(height: 3),
                    Text(
                      place.name,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 5),
                    Row(
                      children: [
                        Text(
                          '4.5 miles',
                          style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Color.fromARGB(255, 240, 165, 5)),
                        ),
                        Spacer(),
                        Container(
                          height: 25,
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
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}