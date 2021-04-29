import 'package:accassado/home/Adminhome.dart';
import 'package:accassado/home/home.dart';
import 'package:flutter/material.dart';

class Welcome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              child: Text("Welcome"),
            ),
          ),
          TextButton(
            child: Text("GO to Home"),
            onPressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => Home()));
            },
          ),
          TextButton(
            child: Text("Admin Mode"),
            onPressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => AdminHome()));
            },
          ),
        ]),
      ),
    );
  }
}
