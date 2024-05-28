class User {
  final String username;
  final List<Post> posts;

  User({required this.username, required this.posts});
}

class Post {
  final String name;
  final String imageUrl;
  final double rating;

  Post({required this.name, required this.imageUrl, required this.rating});
}
