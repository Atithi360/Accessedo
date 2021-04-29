import 'package:accassado/home/ProfilePage.dart';
import 'package:accassado/home/changepassword.dart';
import 'package:accassado/home/home.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final _auth = FirebaseAuth.instance;
  User loggedInUser;
  String email = "";
  String name = "";
  String contact = "";
  @override
  void initState() {
    super.initState();
    getCurrentuser();
  }

  void getCurrentuser() async {
    setState(() {
      try {
        final user = _auth.currentUser;
        email = user.email;
        FirebaseFirestore.instance
            .collection("users")
            .doc('$email')
            .get()
            .then((value) {
          setState(() {
            name = value.data()["name"];
            contact = value.data()["contactnumber"];
          });
          print(name);
          print(contact);
        });
        if (user != null) {}
      } catch (e) {
        print(e);
      }
    });
  }

  final _recipientController = "iib2019026@iiita.ac.in";

  final _subjectController = ' Regarding Entry service in the building';

  final _bodyController = '';

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  Future<void> send() async {
    final Email email = Email(
      body: _bodyController,
      subject: _subjectController,
      recipients: [_recipientController],
    );

    String platformResponse;

    try {
      await FlutterEmailSender.send(email);
      platformResponse = 'success';
    } catch (error) {
      platformResponse = error.toString();
    }

    if (!mounted) return;

    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text(platformResponse),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(
          "Profile",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        actions: <Widget>[
          FlatButton.icon(
            onPressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => Home()));
            },
            icon: Icon(
              Icons.home,
              color: Colors.black,
            ),
            label: Text(
              "Home",
              style: TextStyle(color: Colors.black),
            ),
          )
        ],
      ),
      body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Card(
            shadowColor: Colors.pink[100],
            elevation: 10,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.person,
                      size: 40,
                    ),
                    Text('$email'),
                  ],
                ),
                Text(
                  name,
                  style: TextStyle(color: Colors.black),
                ),
                Text(contact),
                RaisedButton(
                    color: Colors.pink[400],
                    child: Text("Edit profile"),
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => ProfilePage()));
                    }),
                RaisedButton(
                    color: Colors.pink[400],
                    child: Text("Change Password"),
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => changepassword()));
                      //
                    })
              ],
            ),
          ),
        ),
      ]),
    );
  }
}
