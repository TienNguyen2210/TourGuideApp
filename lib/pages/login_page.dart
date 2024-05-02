import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tour_guide_app/pages/signup_page.dart';
import 'package:tour_guide_app/pages/user_profile_page.dart';
import 'package:tour_guide_app/pages/password_recovery.dart';
import 'package:tour_guide_app/service/auth.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String? errorMessage = '';
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 180,
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
              SizedBox(height: 35),
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
              SizedBox(height: 10),
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
              SizedBox(height: 2),
              errorMessage != '' ? Text(errorMessage!, style: TextStyle(color: Colors.red)) : Container(),
              Container(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () { Navigator.push(context, MaterialPageRoute(builder: (context) => const PasswordRecoveryScreen())); },
                  child: const Text('Forgot Password?', style: TextStyle(color: Color.fromARGB(255, 201, 188, 9))),
                ),
              ),
              SizedBox(height: 5),
              Container(
                width: 380,
                height: 50,
                child: ElevatedButton(
                  onPressed: signIn,
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    backgroundColor: const Color.fromARGB(255, 255, 153, 0),
                  ),
                  child: const Text('Sign In', style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: Colors.white)),
                ),
              ),
              SizedBox(height: 25),
              Text('Or continue with', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
              SizedBox(height: 20),
              Container(
                width: 380,
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(27),
                  border: Border.all(color: Colors.black),
                ),
                child: ElevatedButton(
                  onPressed: googleSignIn,
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(27),  // Ensuring the button has rounded corners
                    ),
                  ),
                  child: Wrap(
                    crossAxisAlignment: WrapCrossAlignment.center,
                    spacing: 20,  // Adjust the spacing between elements inside Wrap
                    children: const [
                      Image(image: AssetImage('assets/googleLogo.png'), width: 25, height: 25),
                      Text('Sign In with Google', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black)),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 10),
              Container(
                width: 380,
                height: 50,
                child: ElevatedButton(
                  onPressed: facebookSignIn,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 59, 89, 152),
                  ),
                  child: Wrap(
                    crossAxisAlignment: WrapCrossAlignment.center,
                    spacing: 10, // This replaces the SizedBox for spacing
                    children: [
                      Icon(Icons.facebook, color: Colors.white, size: 33),
                      Text('Sign In with Facebook', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 13),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Don\'t have an account?', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const SignUpScreen()),
                      );
                    },
                    child: const Text('Sign Up', style: TextStyle(color:  Color.fromARGB(255, 255, 153, 0))),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
  googleSignIn() async {
    try {
      UserCredential userCredential = await Auth().googleSignIn();
      if (userCredential.user != null) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const UserProfile()),
        );
      }
    } catch (e) {
      errorMessage = e.toString();
    }
  }

  facebookSignIn() async {
    try {
      UserCredential userCredential = await Auth().facebookSignIn();
      if (userCredential.user != null) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const UserProfile()),
        );
      }
    } catch (e) {
      errorMessage = e.toString();
    }
  }

  Future<void> signIn() async {
    try {
      await Auth().signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const UserProfile()),
      );
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMessage = e.message;
      });
    }
  }
}