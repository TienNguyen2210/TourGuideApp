import 'package:flutter/material.dart';
import 'package:tour_guide_app/pages/login_page.dart';
import 'package:tour_guide_app/pages/user_profile_page.dart';
import 'package:tour_guide_app/service/auth.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Auth().authStateChanges, 
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());  
        } else if (snapshot.hasData) {
          return UserProfile();
        } else {
          return LoginScreen();
        }
      }
    );
  }
}
