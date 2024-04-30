import 'package:flutter/material.dart';
import 'package:tour_guide_app/service/auth.dart';

class UserProfile extends StatelessWidget {
  const UserProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 50,
              // Display user profile picture here
              // Example: backgroundImage: NetworkImage(_auth.currentUser.photoURL),
            ),
            SizedBox(height: 20),
            Text(
              // Display user display name or email here
              Auth().currentUser?.email ?? 'Unknown',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                signOut(context);
              },
              child: Text('Sign Out'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> signOut(BuildContext context) async {
    await Auth().signOut();
    Navigator.popUntil(context, ModalRoute.withName('/'));
  } 
}