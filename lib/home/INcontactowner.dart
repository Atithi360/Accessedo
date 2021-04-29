import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sms/sms.dart';

class INcontactowner extends StatefulWidget {
  @override
  _INcontactownerState createState() => _INcontactownerState();
}

class _INcontactownerState extends State<INcontactowner> {
  final _formkey = GlobalKey<FormState>();
  final _auth = FirebaseAuth.instance;

  String reason = '';
  String name = '';
  String contactnumber = '';
  String email = '';
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
            contactnumber = value.data()["contactnumber"];
          });
          print(name);
          print(contactnumber);
        });
        if (user != null) {}
      } catch (e) {
        print(e);
      }
    });
  }

  void _alert() {
    SmsSender sender = SmsSender();
    String address = "9771542868";

    SmsMessage message = SmsMessage(address,
        'Hii,\n I am $name Purpose: $reason \n Here are some of my details :PHONE NUMBER: $contactnumber numberEMAIL ID: $email');
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
        backgroundColor: Colors.transparent,
      ),
      body: Center(
        child: Card(
            child: Form(
                key: _formkey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: 20.0),
                    TextFormField(
                      decoration: new InputDecoration(
                        labelText: "Message for Owner:",
                        fillColor: Colors.pink[100],
                        border: new OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(10.0),
                          borderSide: new BorderSide(),
                        ),
                      ),
                      validator: (val) =>
                          val.isEmpty ? 'Enter a message' : null,
                      onChanged: (val) {
                        setState(() => reason = val);
                      },
                    ),
                    RaisedButton(
                      child: Text("SEND"),
                      onPressed: () {
                        _alert();
                      },
                    )
                  ],
                ))),
      ),
    );
  }
}
