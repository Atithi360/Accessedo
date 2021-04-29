import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class history extends StatefulWidget {
  @override
  _historyState createState() => _historyState();
}

class _historyState extends State<history> {
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
          stream: FirebaseFirestore.instance.collection('history').snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }

            return ListView(
              children: snapshot.data.docs.map((document) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    elevation: 34,
                    margin: EdgeInsets.all(10.0),
                    color: Colors.purple[100],
                    child: Center(
                        child: Column(children: [
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("email id : "),
                          Text(document['email']),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Purpose: "),
                          Text(document['reason']),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("time: "),
                          Text(document['time']),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                    ])),
                  ),
                );
              }).toList(),
            );
          },
        ),
      ),
    );
  }
}
