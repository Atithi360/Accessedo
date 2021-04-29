import 'package:accassado/authenticate/register.dart';
import 'package:accassado/service/auth.dart';
import 'package:flutter/material.dart';

import 'history.dart';

class AdminHome extends StatelessWidget {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Welcome Owner",
            style: TextStyle(color: Colors.black),
          ),
          backgroundColor: Colors.transparent,
          elevation: 50.0,
          actions: <Widget>[
            FlatButton.icon(
                onPressed: () async {
                  await _auth.signingOut();
                },
                icon: Icon(Icons.person),
                label: Text("Logout")),
          ],
        ),
        body: Container(
            child: ListView(
          children: [
            Column(children: [
              SizedBox(
                height: 20,
              ),
              Image(
                image: AssetImage('image/Alogo.jpeg'),
                height: 300,
                width: 400,
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  color: Colors.pink[100],
                  shadowColor: Colors.purpleAccent,
                  elevation: 20,
                  child: Container(
                    padding: EdgeInsets.fromLTRB(10, 30, 10, 10),
                    color: Colors.purple[100],
                    child: Center(
                      child: ListTile(
                          leading: const Icon(Icons.folder),
                          title: const Text("VEIW HISTORY"),
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => history()));
                          }),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    shadowColor: Colors.purpleAccent,
                    elevation: 20,
                    child: Container(
                      padding: EdgeInsets.fromLTRB(10, 30, 10, 10),
                      color: Colors.pink[100],
                      child: Center(
                        child: ListTile(
                            leading: const Icon(Icons.home),
                            title: const Text(" ADD VISITOR"),
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => Register()));
                            }),
                      ),
                    ),
                  ))
            ])
          ],
        )));
  }
}
