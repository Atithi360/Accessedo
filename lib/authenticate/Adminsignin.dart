import 'package:accassado/home/Adminhome.dart';
import 'package:accassado/service/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AdminSignIn extends StatefulWidget {
  @override
  _AdminSignInState createState() => _AdminSignInState();
}

class _AdminSignInState extends State<AdminSignIn> {
  final _autht = FirebaseAuth.instance;

  AuthService _auth = AuthService();
  final _formkey = GlobalKey<FormState>();
  bool loading = false;
  String email = '';
  String password = '';
  String error = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 50.0,
        title: Text(""),
        // actions: <Widget>[
        //   FlatButton.icon(
        //     icon: Icon(Icons.person),
        //     label: Text("Register"),
        //     onPressed: () async {
        //       widget.toggleView();
        //     },
        //   ),
        // ],
      ),
      body: ListView(children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 50.0, vertical: 20.0),
          child: Form(
            key: _formkey,
            child: Column(
              children: <Widget>[
                SizedBox(height: 20.0),
                TextFormField(
                  decoration: new InputDecoration(
                    labelText: "Email:",
                    fillColor: Colors.pink[100],
                    border: new OutlineInputBorder(
                      borderRadius: new BorderRadius.circular(25.0),
                      borderSide: new BorderSide(),
                    ),
                  ),
                  validator: (val) => val.isEmpty ? 'Enter an E-Mail' : null,
                  onChanged: (val) {
                    setState(() => email = val);
                  },
                ),
                SizedBox(height: 20.0),
                TextFormField(
                  decoration: new InputDecoration(
                    labelText: "Password:",
                    fillColor: Colors.pink[100],
                    border: new OutlineInputBorder(
                      borderRadius: new BorderRadius.circular(25.0),
                      borderSide: new BorderSide(),
                    ),
                  ),
                  obscureText: true,
                  validator: (val) => val.length < 6
                      ? 'Password should be at least 6 characters'
                      : null,
                  onChanged: (val) {
                    setState(() => password = val);
                  },
                ),
                SizedBox(height: 20.0),
                TextFormField(
                  decoration: new InputDecoration(
                    labelText: "Admin ID :",
                    fillColor: Colors.pink[100],
                    border: new OutlineInputBorder(
                      borderRadius: new BorderRadius.circular(25.0),
                      borderSide: new BorderSide(),
                    ),
                  ),
                  obscureText: true,
                  validator: (val) => val == 1234 ? 'Password s' : null,
                  onChanged: (val) {
                    // setState(() => password = val);
                  },
                ),
                SizedBox(height: 20.0),
                RaisedButton(
                    color: Colors.pink[400],
                    child: Text("Sign in"),
                    onPressed: () async {
                      if (_formkey.currentState.validate()) {
                        setState(() => loading = true);
                        dynamic result =
                            await _auth.signInWithEmail(email, password);
                        if (result == null) {
                          setState(() => error = 'Incorrect Credentials');
                          loading = false;
                        }
                      }
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => AdminHome()));
                    }),
                SizedBox(height: 20.0),
                Text(
                  error,
                  style: TextStyle(
                    color: Colors.red,
                  ),
                ),
                TextButton(
                  child: Text("Forgot Password?"),
                  onPressed: () {
                    _autht.sendPasswordResetEmail(email: email);
                  },
                ),
              ],
            ),
          ),
        ),
      ]),
    );
  }
}
