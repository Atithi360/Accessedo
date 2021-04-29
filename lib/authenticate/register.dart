import 'package:accassado/service/auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sms/sms.dart';

class Register extends StatefulWidget {
  final Function toggleView;
  Register({this.toggleView});
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  AuthService _auth = AuthService();
  final _formkey = GlobalKey<FormState>();
  String email = '';
  // String password = '';
  String error = '';
  String contactnumber = '';
  String name = '';
  void _alert() {
    SmsSender sender = SmsSender();
    String address = contactnumber;

    SmsMessage message = SmsMessage(address,
        ' I  $name have been successfully registered on "ACCESSADO":  \n Here are some of my details :Password: $contactnumber numberEMAIL ID: $email');
    message.onStateChanged.listen((state) {
      if (state == SmsMessageState.Sent) {
        print("SMS is sent!");
      } else if (state == SmsMessageState.Delivered) {
        print("SMS is delivered!");
      }
    });
    sender.sendSms(message);
  }

  // void _alert() {
  //   SmsSender sender = SmsSender();
  //   String address = contactnumber;
  //
  //   SmsMessage message = SmsMessage(address,
  //       'I $name have been successfully registered on "ACCESSADO".Password for my login would be this phone number and login id as  $email id. can change password anytime by clicking on forgot password under signin option.');
  //
  //   message.onStateChanged.listen((state) {
  //     if (state == SmsMessageState.Sent) {
  //       print("SMS is sent!");
  //     } else if (state == SmsMessageState.Delivered) {
  //       print("SMS is delivered!");
  //     }
  //   });
  //   sender.sendSms(message);
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 50.0,
        title: Text(""),
//
      ),
      body: ListView(children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 50.0, vertical: 20.0),
          child: Form(
            key: _formkey,
            child: Column(
              children: <Widget>[
                TextFormField(
                  decoration: new InputDecoration(
                    labelText: "NAME",
                    fillColor: Colors.pink[100],
                    border: new OutlineInputBorder(
                      borderRadius: new BorderRadius.circular(25.0),
                      borderSide: new BorderSide(),
                    ),
                  ),
                  validator: (val) => val.isEmpty ? 'Enter Name' : null,

                  // validator: (val) =>
                  // val != chpassword ? 'Incorrect password' : null,
                  onChanged: (val) {
                    setState(() => name = val);
                  },
                ),
                SizedBox(height: 20.0),
                TextFormField(
                  decoration: new InputDecoration(
                    labelText: "Contact Number",
                    fillColor: Colors.pink[100],
                    border: new OutlineInputBorder(
                      borderRadius: new BorderRadius.circular(25.0),
                      borderSide: new BorderSide(),
                    ),
                  ),
                  validator: (val) => val.length < 10
                      ? 'Phone no. should be at least 10 characters'
                      : null,
                  // validator: (val) =>
                  // val != chpassword ? 'Incorrect password' : null,
                  onChanged: (val) {
                    setState(() => contactnumber = val);
                  },
                ),
                SizedBox(height: 20.0),
                TextFormField(
                  decoration: new InputDecoration(
                    labelText: "E-Mail:",
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
                    child: Text("ADD"),
                    onPressed: () async {
                      if (_formkey.currentState.validate()) {
                        dynamic result =
                            await _auth.registerWithEmail(email, contactnumber);
                        if (result == null) {
                          setState(
                              () => error = 'please enter the valid email');
                        }
                        _alert();
                        await FirebaseFirestore.instance
                            .collection('users')
                            .doc(email)
                            .set({
                          'name': name,
                          'contactnumber': contactnumber,
                          'email': email,
                        });
                        // dynamic user = result.user;
                        // await FirebaseFirestore.instance
                        //     .collection("users")
                        //     .doc(user.uid)
                        //     .update({
                        //   "name": name,
                        // });
                      }
                      Navigator.of(context).pop();
                    }),
                SizedBox(height: 20.0),
                Text(
                  error,
                  style: TextStyle(
                    color: Colors.red,
                  ),
                )
              ],
            ),
          ),
        ),
      ]),
    );
  }
}
