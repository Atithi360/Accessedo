import 'package:accassado/home/Contactowner.dart';
import 'package:accassado/home/IN the building.dart';
import 'package:accassado/home/Profile.dart';
import 'package:accassado/service/auth.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Welcome "),
        backgroundColor: Colors.transparent,
        elevation: 50.0,
        actions: <Widget>[
          FlatButton.icon(
              onPressed: () async {
                await _auth.signingOut();
              },
              icon: Icon(Icons.exit_to_app),
              label: Text("Logout")),
        ],
      ),
      body: Column(children: [
        Expanded(
          child: Image(
            image: AssetImage('image/Alogo.jpeg'),
            height: 300,
            width: 400,
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(40.0),
            child: Card(
              shadowColor: Colors.purpleAccent,
              elevation: 40,
              color: Colors.pink[100],
              child: Center(
                child: ListTile(
                    leading: const Icon(Icons.home),
                    title: const Text(" Enter  the building",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 25,
                            fontWeight: FontWeight.bold)),
                    onTap: () {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => Entry()));
                    }),
              ),
            ),
          ),
        )
      ]),
      bottomNavigationBar: BottomAppBar(
        color: Colors.pink[300],
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: new Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                FlatButton.icon(
                    onPressed: () {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => Profile()));
                    },
                    icon: Icon(Icons.person),
                    label: Text("update profile")),
                FlatButton.icon(
                    icon: Icon(Icons.contact_mail),
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => contactowner()));
                      // await _auth.signingOut();
                    },
                    label: Text("contact to owner")),
              ]),
        ),
      ),
    );
  }
}
