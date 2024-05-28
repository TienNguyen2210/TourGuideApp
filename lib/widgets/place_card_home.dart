import 'package:flutter/material.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:tour_guide_app/utilities/constant.dart';
import 'package:tour_guide_app/pages/place_details.dart';

class PlaceCardHome extends StatelessWidget {
  final PlacesSearchResult place;
  const PlaceCardHome({super.key, required this.place});

  @override
  Widget build(BuildContext context) {
    String photoUrl = '';
    if (place.photos.isNotEmpty) {
      photoUrl = 'https://maps.googleapis.com/maps/api/place/photo?maxwidth=400&photoreference=${place.photos[0].photoReference}&key=$googleMapsApiKey';
    } else {
      photoUrl = 'https://t4.ftcdn.net/jpg/04/70/29/97/360_F_470299797_UD0eoVMMSUbHCcNJCdv2t8B2g1GVqYgs.jpg';
    }
    
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        Navigator.push(
          context, 
          MaterialPageRoute(builder: (context) => PlaceDetailScreen(place: place)),
        );
      },
      child: Padding(
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
                textAlign: TextAlign.start,
              ),
              SizedBox(height: 5),
              Text(
                place.openingHours!.openNow ? 'Open Now' : 'Closed', 
                style: TextStyle(fontSize: 14 , fontWeight: FontWeight.bold, color: const Color.fromARGB(255, 119, 118, 118)),                  
              ),
              SizedBox(height: 5),
              Row(
                children: [
                  Flexible(
                    flex: 2,
                    child: Text(
                    '${place.vicinity}',
                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Color.fromARGB(255, 240, 165, 5), overflow: TextOverflow.ellipsis),
                    ),
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
      ),
    );
  }
}