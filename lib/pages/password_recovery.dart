import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tour_guide_app/service/auth.dart';

class PasswordRecoveryScreen extends StatefulWidget {
  const PasswordRecoveryScreen({super.key});

  @override
  State<PasswordRecoveryScreen> createState() => _PasswordRecoveryScreenState();
}

class _PasswordRecoveryScreenState extends State<PasswordRecoveryScreen> {
  String email = '';
  final _formkey = GlobalKey<FormState>();
  final mailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
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
            Column(
              children: [
                SizedBox(height: 100),
                Icon(Icons.lock, size: 100, color: Color.fromARGB(255, 85, 78, 78)),
                SizedBox(height: 25),
                Text(
                  "Password Recovery",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 28.0,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10.0),
                Text(
                  "Enter your email",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 18.0,
                  ),
                ),
                SizedBox(height: 80),
                Expanded(
                  child: Form(
                    key: _formkey,
                    child: ListView(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: Container(
                            padding: EdgeInsets.only(left: 10.0),
                            decoration: BoxDecoration(
                              border:
                                  Border.all(color: Colors.black, width: 1.5),
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: TextFormField(
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return '             *Please enter Email';
                                }
                                return null;
                              },
                              controller: mailController,
                              style: TextStyle(color: Colors.black),
                              decoration: InputDecoration(
                                  hintText: "Email",
                                  hintStyle: TextStyle(
                                      fontSize: 17.0, color: Colors.black),
                                  prefixIcon: Icon(
                                    Icons.person,
                                    color: Colors.black,
                                    size: 28.0,
                                  ),
                                  border: InputBorder.none),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 40.0,
                        ),
                        GestureDetector(
                          onTap: () {
                            if(_formkey.currentState!.validate()){
                              setState(() {
                                email=mailController.text;
                              });
                              resetPassword();
                            }
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10.0),
                            child: Container(
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  color: Color.fromARGB(255, 32, 31, 31),
                                  borderRadius: BorderRadius.circular(30)),
                              child: Center(
                                child: Text(
                                  "Send Email",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 50.0,
                        ),
                      ],
                    )
                  )
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  resetPassword() async {
    try {
      await Auth().sendPasswordResetEmail(email);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
        "Password Reset Email has been sent!",
        style: TextStyle(fontSize: 20.0),

      )));
    } on FirebaseAuthException catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(
          e.message.toString(), 
          style: TextStyle(fontSize: 20.0),
        )));
      
    }
  }
}