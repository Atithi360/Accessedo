import 'package:accassado/home/home.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_auth/email_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sms/sms.dart';

class Entry extends StatefulWidget {
  @override
  _EntryInState createState() => _EntryInState();
}

class _EntryInState extends State<Entry> {
  final _formkey = GlobalKey<FormState>();
  final _auth = FirebaseAuth.instance;
  String email;
  String Reason;
  static DateTime now = DateTime.now();
  String formattedDate = DateFormat('kk:mm:ss \n EEE d MMM').format(now);

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
        print(email);
        if (user != null) {}
      } catch (e) {
        print(e);
      }
    });
  }

  final TextEditingController _otpController = TextEditingController();

  void sendOtp() async {
    EmailAuth.sessionName = "Accessado to Enter the building";
    var data = await EmailAuth.sendOtp(receiverMail: email);
    if (!data) {}
  }

  bool verify() {
    return (EmailAuth.validate(
        receiverMail: email, //to make sure the email ID is not changed
        userOTP: _otpController.value.text));
    // EmailAuth.validate(
    // recieverMail: email, //to make sure the email ID is not changed
    // userOTP: _otpController.value.text));
    // if (res) {
    //   print("Otp is varified");
    //   //pass in t
    //   // printhe OTP typed in
    // } else {
    //   print("Otp is Not  varified");
    // }
  }

  void _alert() {
    SmsSender sender = SmsSender();
    String address = "9771542868";

    SmsMessage message =
        SmsMessage(address, ' unauthorised access in the building ');
    message.onStateChanged.listen((state) {
      if (state == SmsMessageState.Sent) {
        print("SMS is sent!");
      } else if (state == SmsMessageState.Delivered) {
        print("SMS is delivered!");
      }
    });
    sender.sendSms(message);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Enter the Building"),
        backgroundColor: Colors.transparent,
        elevation: 50.0,
        actions: <Widget>[
          FlatButton.icon(
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => Home()));
              },
              icon: Icon(Icons.home),
              label: Text("Home")),
        ],
      ),
      body: ListView(
        children: [
          Container(
              padding: EdgeInsets.symmetric(horizontal: 50.0, vertical: 20.0),
              child: Form(
                key: _formkey,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text("Hii $email"),
                      SizedBox(
                        height: 30,
                      ),
                      Text("Purpose to enter the building"),
                      SizedBox(height: 20.0),
                      TextFormField(
                        decoration: new InputDecoration(
                          labelText: "Reason to Enter:",
                          fillColor: Colors.pink[100],
                          border: new OutlineInputBorder(
                            borderRadius: new BorderRadius.circular(10.0),
                            borderSide: new BorderSide(),
                          ),
                        ),
                        validator: (val) =>
                            val.isEmpty ? 'Enter an Reason' : null,
                        onChanged: (val) {
                          setState(() => Reason = val);
                        },
                      ),
                      SizedBox(height: 20.0),
                      RaisedButton(
                          color: Colors.pink[400],
                          child: Text("Send  otp"),
                          onPressed: () async {
                            if (_formkey.currentState.validate()) {
                              sendOtp();
                            }
                          }),
                      SizedBox(
                        height: 20,
                      ),
                      TextField(
                        decoration: new InputDecoration(
                          labelText: " Enter the otp:",
                          fillColor: Colors.pink[100],
                          border: new OutlineInputBorder(
                            borderRadius: new BorderRadius.circular(10.0),
                            borderSide: new BorderSide(),
                          ),
                        ),
                        controller: _otpController,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      RaisedButton(
                          color: Colors.pink[400],
                          child: Text("Verify Otp "),
                          onPressed: () async {
                            if (verify()) {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) =>
                                    _buildPopupDialog(context),
                              );
                              await FirebaseFirestore.instance
                                  .collection('history')
                                  .add({
                                "email": email,
                                "reason": Reason,
                                "time": formattedDate,
                                //add your data that you want to upload
                              });
                            } else {
                              _alert();
                            }
                          }),
                      SizedBox(height: 20.0),
                      Text("See you inside the building :) "),
                    ]),
              ))
        ],
      ),
    );
  }
}

Widget _buildPopupDialog(BuildContext context) {
  return new AlertDialog(
    title: const Text(''),
    content: new Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Center(child: Text("Hello Welcome in the building")),
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
