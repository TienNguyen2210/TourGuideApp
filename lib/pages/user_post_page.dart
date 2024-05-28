import 'package:flutter/material.dart';
import '../models/user.dart';
import 'package:tour_guide_app/pages/post_page.dart';

class UserPostScreen extends StatelessWidget {

  final List<User> users = [
    User(
      username: "traveler123",
      posts: [
        Post(name: "Beautiful Beach", imageUrl: "https://i.imgur.com/xs3yN91.jpeg", rating: 4.8),
        Post(name: "Mountain Adventure", imageUrl: "https://i.imgur.com/oYJxwaS.jpeg", rating: 4.7),
      ],
    ),
    User(
      username: "wanderer",
      posts: [
        Post(name: "City Lights", imageUrl: "https://i.imgur.com/nhnASGQ_d.jpeg?maxwidth=520&shape=thumb&fidelity=high", rating: 4.9),
        Post(name: "Desert Safari", imageUrl: "https://i.imgur.com/9CmKH4Eg.jpg", rating: 4.6),
      ],
    ),
  ];

  UserPostScreen({super.key});


  Widget _buildRatingBox(double rating) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 3, 197, 3), // Green background
        borderRadius: BorderRadius.circular(5),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.star, color: Colors.white, size: 16),
          Text(
            rating.toString(),
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("User Posts")),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: users.length,
              itemBuilder: (context, index) {
                User user = users[index];
                return Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(user.username, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                      Container(
                        height: 250,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: user.posts.length,
                          itemBuilder: (context, postIndex) {
                            Post post = user.posts[postIndex];
                            return Container(
                              width: 160,
                              padding: EdgeInsets.all(8),
                              child: Column(
                                children: [
                                  Expanded(
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Image.network(
                                        post.imageUrl,
                                        fit: BoxFit.cover,
                                        errorBuilder: (context, error, stackTrace) => Image.asset('assets/images/placeholder.png', fit: BoxFit.cover),
                                      ),
                                    ),
                                  ),
                                  Text(post.name, style: TextStyle(fontWeight: FontWeight.bold)),
                                  _buildRatingBox(post.rating),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => PostScreen()));
              },
              child: Text('Add', style: TextStyle(color: Colors.white)),
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).primaryColor,
                minimumSize: Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
