import 'package:flutter/material.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:tour_guide_app/utilities/constant.dart';

class PlaceDetailScreen extends StatefulWidget {
  final PlacesSearchResult place;
  const PlaceDetailScreen({super.key, required this.place});

  @override
  State<PlaceDetailScreen> createState() => _PlaceDetailScreenState();
}

class _PlaceDetailScreenState extends State<PlaceDetailScreen> {
  bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
    String photoUrl = '';
    if (widget.place.photos.isNotEmpty) {
      photoUrl = 'https://maps.googleapis.com/maps/api/place/photo?maxwidth=400&photoreference=${widget.place.photos[0].photoReference}&key=$googleMapsApiKey';
    }
    return Scaffold(
      body: ListView(
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(15.0), bottomRight: Radius.circular(15.0)),
                child: photoUrl.isNotEmpty ? 
                Image.network(photoUrl, fit: BoxFit.cover, height: 300, width: double.infinity) 
                : SizedBox.shrink()
              ),
              Positioned(
                top: 10.0,
                left: 10.0,
                child: IconButton(
                  icon: Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
              Positioned(
                bottom: 40.0,
                left: 16.0,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.place.name,
                      style: TextStyle(color: Colors.white, fontSize: 22.0, fontWeight: FontWeight.bold,
                      shadows: const [
                          Shadow(color: Colors.black, offset: Offset(2, 2), blurRadius: 10),
                        ]
                      ),
                    ),
                    SizedBox(height: 10.0),
                    Row(
                      children: [
                        Icon(Icons.location_on_outlined, color: Colors.white, size: 14),
                        SizedBox(width: 5.0),
                        Text(
                          widget.place.vicinity!,
                          style: TextStyle(color: Color.fromARGB(255, 228, 231, 227), fontSize: 14, fontWeight: FontWeight.bold,
                          shadows: const [
                            Shadow(color: Colors.black, offset: Offset(2, 2), blurRadius: 10),
                          ]),
                        ),
                      ],
                    ),
                    SizedBox(height: 15.0),
                    Row(
                      children: [
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
                                widget.place.rating.toString(),
                                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),
                              ),
                              SizedBox(width: 3),
                              Icon(Icons.star, color: Colors.white, size: 14),
                            ]
                          ),
                        ),
                        SizedBox(width: 10.0),
                        Text(
                          widget.place.openingHours!.openNow ? '• Open Now' : '• Closed',
                          style: TextStyle(color: Color.fromARGB(255, 228, 231, 227), fontSize: 14, fontWeight: FontWeight.bold,
                          shadows: const [
                            Shadow(color: Colors.black, offset: Offset(2, 2), blurRadius: 10),
                          ]),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Positioned(
                top: 16.0,
                right: 16.0,
                child: IconButton(
                  icon: Icon(
                    isFavorite ? Icons.favorite : Icons.favorite_border,
                    color: isFavorite ? Colors.red :  Color.fromARGB(255, 233, 229, 229),
                  ),  
                  onPressed: () {
                    setState(() {
                      isFavorite = !isFavorite;
                    });
                  },
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'About',
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8.0),
                Text(
                  // widget.place.description (should be this but there's no description property)
                  'A nice restaurant with a good view of the lower city and moutains. Good to visit even when cloudy or raining because they have a friendly atmosphere.',
                  style: TextStyle(fontSize: 15.0, color: Color.fromARGB(255, 88, 86, 86)),
                ),
                SizedBox(height: 15.0),
                Divider(
                  color: Color.fromARGB(255, 231, 226, 226),
                  thickness: 1.0,
                ),
                _buildDetailRow(Icons.access_time, 'Opening hours', '07:30 - 23:00'),
                Divider(
                  color: Color.fromARGB(255, 231, 226, 226),
                  thickness: 1.0,
                ),
                _buildDetailRow(Icons.timer, 'Waiting time', 'About 3-5 minutes'),
                Divider(
                  color: Color.fromARGB(255, 231, 226, 226),
                  thickness: 1.0,
                ),
                _buildDetailRow(Icons.category_outlined, 'Type', 'Restaurant'),
                Divider(
                  color: Color.fromARGB(255, 231, 226, 226),
                  thickness: 1.0,
                ),
                _buildDetailRow(Icons.group_outlined, 'Capacity', '10 Adults'),
                Divider(
                  color: Color.fromARGB(255, 231, 226, 226),
                  thickness: 1.0,
                ),
                _buildDetailRow(Icons.grade_outlined, 'Good for', 'Coffee, Dine In, Take away')
              ],
            ),
          ),
        ]
      ),
    );
  }
  Widget _buildDetailRow(IconData icon, String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,  
        children: [
          Row(
            children: [
              Icon(icon, color: Color.fromARGB(255, 178, 17, 199)),
              SizedBox(width: 8.0),
              Text(
                '$title: ',
                style: TextStyle(color: Color.fromARGB(255, 78, 78, 78), fontWeight: FontWeight.bold),
              )
            ],
          ),
          Text(value, style: TextStyle(fontWeight: FontWeight.bold, color: Color.fromARGB(255, 228, 44, 11))),
        ],
      ),
    );
  }
}