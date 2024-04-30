import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import '/post/post.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({super.key});

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  String? _selectedCategory;
  double _rating = 0;
  final TextEditingController _descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Post'),
        centerTitle: true,
        backgroundColor: Colors.amber,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text('Select Category:', style: TextStyle(fontSize: 16)),
            DropdownButton<String>(
              value: _selectedCategory,
              hint: const Text('Choose a category'),
              isExpanded: true,
              items: <String>['Restaurant', 'Entertainment', 'Attraction']
                  .map<DropdownMenuItem<String>>((String category) {
                return DropdownMenuItem<String>(
                  value: category,
                  child: Text(category),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  _selectedCategory = newValue;
                });
              },
            ),
            const SizedBox(height: 20),
            const Text('Rating:', style: TextStyle(fontSize: 16)),
            RatingBar.builder(
              initialRating: _rating,
              minRating: 1,
              direction: Axis.horizontal,
              allowHalfRating: true,
              itemCount: 5,
              itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
              itemBuilder: (context, _) => const Icon(Icons.star, color: Colors.amber),
              onRatingUpdate: (rating) {
                setState(() {
                  _rating = rating;
                });
              },
            ),
            const SizedBox(height: 20),
            const Text('Description:', style: TextStyle(fontSize: 16)),
            TextField(
              controller: _descriptionController,
              decoration: const InputDecoration(
                hintText: 'Enter description',
                border: OutlineInputBorder(),
              ),
              maxLines: 5,
            ),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: _createPost,
                child: const Text('Create Post'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _createPost() {
    if (_selectedCategory != null && _rating != 0 && _descriptionController.text.isNotEmpty) {
      Post newPost = Post(
        category: _selectedCategory!,
        rating: _rating,
        description: _descriptionController.text,
        location: "location"
      );
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Post Created'),
          content: Text(
            'Category: ${newPost.category}\nRating: ${newPost.rating}\nDescription: ${newPost.description}',
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        ),
      );
    } else {

    }
  }
}