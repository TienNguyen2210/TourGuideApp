import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tour_guide_app/pages/user_profile_page.dart';
import 'package:tour_guide_app/service/auth.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  String? errorMessage = '';
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Stack(
                alignment: Alignment.topLeft,
                children: [
                  Container(
                    height: 190,
                    width: double.infinity,
                    child: ClipRRect(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10), 
                      ),
                      child: Image(
                        image: AssetImage('assets/cover.jpg'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  // Positioned FloatingActionButton at top left
                  Positioned(
                    top: 15,
                    left: 10,
                    child: FloatingActionButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Icon(Icons.arrow_back),
                      backgroundColor: Colors.black,
                      foregroundColor: Colors.white,
                      mini: true,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Text(
                'Welcome to Tourmate!',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              Text(
                'Discover personalized recommendations, save your favorite locations, and share your experiences with others.',
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 40),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 15),  
                height: 55,
                child: TextField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    labelStyle: TextStyle(fontSize: 15, fontWeight: FontWeight.normal),
                    floatingLabelStyle: TextStyle(color: Color.fromARGB(255, 226, 140, 12)),
                    hintText: 'Enter your email',
                    hintStyle: TextStyle(fontSize: 15, fontWeight: FontWeight.normal),
                    prefixIcon: Icon(Icons.email, size: 20),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                      borderSide: BorderSide(color: Color.fromARGB(255, 255, 153, 0)),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 15),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                height: 55,
                child: TextField(
                  controller: passwordController,
                  textInputAction: TextInputAction.done,
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: 'Password',
                    labelStyle: TextStyle(fontSize: 15, fontWeight: FontWeight.normal),
                    floatingLabelStyle: TextStyle(color: Color.fromARGB(255, 226, 140, 12)),
                    hintText: 'Enter your password',
                    hintStyle: TextStyle(fontSize: 15, fontWeight: FontWeight.normal),
                    prefixIcon: Icon(Icons.lock, size: 20),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                      borderSide: BorderSide(color: Color.fromARGB(255, 255, 153, 0)),
                    ),  
                  ),
                ),
              ),
              SizedBox(height: 15),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                height: 55,
                child: TextField(
                  controller: confirmPasswordController,
                  textInputAction: TextInputAction.done,
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: 'Confirm Password',
                    labelStyle: TextStyle(fontSize: 15, fontWeight: FontWeight.normal),
                    floatingLabelStyle: TextStyle(color: Color.fromARGB(255, 226, 140, 12)),
                    hintText: 'Enter your password',
                    hintStyle: TextStyle(fontSize: 15, fontWeight: FontWeight.normal),
                    prefixIcon: Icon(Icons.lock, size: 20),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                      borderSide: BorderSide(color: Color.fromARGB(255, 255, 153, 0)),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 5),
              Text(
                errorMessage!,
                style: const TextStyle(color: Colors.red),
              ),
              SizedBox(height: 15),
              Container(
                width: 380,
                height: 50,
                child: ElevatedButton(
                  onPressed: signUp,
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    backgroundColor: const Color.fromARGB(255, 255, 153, 0),
                  ),
                  child: const Text('Sign Up', style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: Colors.white)),
                ),
              ),
            ],
          ),
        ),
      )
    );
  }
  Future<void> signUp() async {
    if (passwordController.text.trim() != confirmPasswordController.text.trim()) {
      setState(() {
        errorMessage = '*** Passwords do not match';
      });
      return;
    }
    try {
      await Auth().createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => UserProfile(),
        ),
      );
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMessage = e.message;
      });
    }
  }
}