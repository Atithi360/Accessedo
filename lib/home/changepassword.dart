import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class changepassword extends StatefulWidget {
  @override
  _changepasswordState createState() => _changepasswordState();
}

class _changepasswordState extends State<changepassword> {
  final _formkey = GlobalKey<FormState>();
  String newpassword = "";
  String password = "";
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String error = "";

  Future<bool> validatePassword(String password) async {
    var firebaseUser = await _auth.currentUser;

    var authCredentials = EmailAuthProvider.credential(
        email: firebaseUser.email, password: password);
    try {
      var authResult =
          await firebaseUser.reauthenticateWithCredential(authCredentials);
      return authResult.user != null;
    } catch (e) {
      print(e);
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text("Update your password"),
      ),
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Card(
              shadowColor: Colors.purpleAccent,
              elevation: 17,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 50.0, vertical: 20.0),
                child: Form(
                  key: _formkey,
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: 20.0),
                      TextFormField(
                        obscureText: true,
                        decoration: new InputDecoration(
                          labelText: "Password",
                          fillColor: Colors.pink[100],
                          border: new OutlineInputBorder(
                            borderRadius: new BorderRadius.circular(25.0),
                            borderSide: new BorderSide(),
                          ),
                        ),
                        validator: (val) =>
                            val.isEmpty ? 'Enter an password' : null,
                        onChanged: (val) {
                          setState(() => password = val);
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        obscureText: true,

                        decoration: new InputDecoration(
                          labelText: " New Password",
                          fillColor: Colors.pink[100],
                          border: new OutlineInputBorder(
                            borderRadius: new BorderRadius.circular(25.0),
                            borderSide: new BorderSide(),
                          ),
                        ),
                        validator: (val) =>
                            val.isEmpty ? 'Enter new Password' : null,

                        // validator: (val) =>
                        // val != chpassword ? 'Incorrect password' : null,
                        onChanged: (val) {
                          setState(() => newpassword = val);
                        },
                      ),
                      SizedBox(height: 20.0),
                      TextFormField(
                        obscureText: true,

                        decoration: new InputDecoration(
                          labelText: "Confirm Password",
                          fillColor: Colors.pink[100],
                          border: new OutlineInputBorder(
                            borderRadius: new BorderRadius.circular(25.0),
                            borderSide: new BorderSide(),
                          ),
                        ),
                        validator: (val) =>
                            val != newpassword ? 'Password not matched' : null,
                        // validator: (val) =>
                        // val != chpassword ? 'Incorrect password' : null,
                      ),
                      SizedBox(height: 20.0),
                      // TextFormField(
                      //   decoration: new InputDecoration(
                      //     labelText: "Password:",
                      //     fillColor: Colors.pink[100],
                      //     border: new OutlineInputBorder(
                      //       borderRadius: new BorderRadius.circular(25.0),
                      //       borderSide: new BorderSide(),
                      //     ),
                      //   ),
                      //   obscureText: true,
                      //   validator: (val) => val.length < 6
                      //       ? 'Password should be at least 6 characters'
                      //       : null,
                      //   onChanged: (val) {
                      //     setState(() => password = val);
                      //   },
                      // ),
                      // SizedBox(height: 20.0),
                      SizedBox(height: 20.0),
                      RaisedButton(
                          color: Colors.pink[400],
                          child: Text("Update"),
                          onPressed: () async {
                            if (_formkey.currentState.validate()) {
                              var firebaseUser = await _auth.currentUser;
                              if (validatePassword(password) != false) {
                                dynamic result =
                                    firebaseUser.updatePassword(newpassword);
                                if (result == null) {
                                  setState(() =>
                                      error = 'please enter the valid email');
                                  print(error);
                                }
                                if (error == null) {
                                  Navigator.of(context).pop();
                                } else
                                  _buildPopupDialog(context);
                              }
                            }
                            Navigator.of(context).pop();
                          }),
                      SizedBox(height: 20.0),
                      Text(
                        error,
                        style: TextStyle(
                          color: Colors.red,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}

Widget _buildPopupDialog(BuildContext context) {
  return new AlertDialog(
    title: const Text('recent login required'),
    content: new Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Center(child: Text("error!!")),
      ],
    ),
    actions: <Widget>[
      new FlatButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        textColor: Theme.of(context).primaryColor,
        child: Text('Close'),
      ),
    ],
  );
}
