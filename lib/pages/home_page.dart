import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text("Current user location"),
          backgroundColor: Colors.amber[800],
          foregroundColor: Color.fromARGB(255, 83, 81, 81),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  padding: EdgeInsets.symmetric(vertical: 50.0),
                  scrollDirection: Axis.horizontal,
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return Container(
                      width: 300.0,
                      height: 220.0,
                      margin: EdgeInsets.symmetric(horizontal: 15.0),
                      child: Card(
                        color: Color.fromARGB(255, 83, 81, 81),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Location Name",
                              style: TextStyle(color: Colors.white),
                              textAlign: TextAlign.left,
                            ),
                            Container(
                              color: Colors.white,
                              width: 280,
                              height: 100.0,
                              child: Text("Image"),
                            ),
                            SizedBox(height: 10.0), // Add spacing between the placeholder and the text
                            Text(
                              "Item no. $index",
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              Expanded(
                child: ListView.builder(
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  scrollDirection: Axis.vertical,
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return Container(
                      height: 100.0,
                      width: double.infinity,
                      margin: EdgeInsets.symmetric(vertical: 15.0),
                      child: Card(
                        color: Color.fromARGB(255, 83, 81, 81),
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Text(
                            "Item no. $index",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(const HomeScreen());
}
