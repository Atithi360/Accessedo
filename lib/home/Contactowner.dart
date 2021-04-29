import 'package:flutter/material.dart';
import 'package:sms/sms.dart';

class contactowner extends StatefulWidget {
  @override
  _contactownerState createState() => _contactownerState();
}

class _contactownerState extends State<contactowner> {
  final _formkey = GlobalKey<FormState>();
  String reason = '';
  String name = '';
  String contactnumber = '';
  String email = '';
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
        title: Text("Contact to owner"),
      ),
      body: Center(
        child: Card(
            child: Form(
                key: _formkey,
                child: ListView(children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
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
                        validator: (val) =>
                            val.isEmpty ? 'Enter an E-Mail' : null,
                        onChanged: (val) {
                          setState(() => email = val);
                        },
                      ),
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
                        color: Colors.pink[400],
                        onPressed: () {
                          _alert();
                        },
                      )
                    ],
                  ),
                ]))),
      ),
    );
  }
}
