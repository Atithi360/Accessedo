import 'package:accassado/authenticate/register.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class visitor extends StatefulWidget {
  @override
  _visitorState createState() => _visitorState();
}

class _visitorState extends State<visitor> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 50.0,
        title: Text(""),
//           actions: <Widget>[
//             FlatButton.icon(
//                 onPressed: () async {
// //            await _auth.signingOut();
//
//                   widget.toggleView();
//                 },
//                 icon: Icon(Icons.person),
//                 label: Text("Sign in")),
//           ],
      ),
      body: Container(
        child: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('users').snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }

            return ListView(
              children: snapshot.data.docs.map((document) {
                return Card(
                  elevation: 34,
                  child: Center(
                      child: Row(children: [
                    Expanded(
                      child: Icon(
                        Icons.person,
                        color: Colors.black,
                        size: 24.0,
                      ),
                    ),
                    Expanded(
                      child: Column(children: [
                        Text(document['name']),
                        SizedBox(
                          height: 10,
                        ),
                        // Text(document['contactnumber']),
                        // SizedBox(
                        //   height: 10,
                        // ),
                        // Text(document['email']),
                      ]),
                    ),
                  ])),
                );
              }).toList(),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => Register()));
        },
        icon: const Icon(Icons.add),
        backgroundColor: Colors.pink,
      ),
    );
  }
}
