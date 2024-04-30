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
        body: Column(
          children: [
            Expanded(
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 10,
                itemBuilder: (context, index) {
                  return Container(
                    width: 160.0,
                    child: Card(
                      child: Text("Item no. $index"),
                    ),
                  );
                },
              ),
            ),
            Expanded(
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: 10,
                itemBuilder: (context, index) {
                  return Container(
                    height: 160.0,
                    child: Card(
                      child: Text("Item no. $index"),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
