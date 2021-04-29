import 'package:email_auth/email_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class OTP extends StatefulWidget {
  @override
  _OTPState createState() => _OTPState();
}

class _OTPState extends State<OTP> {
  final _auth = FirebaseAuth.instance;
  String email;

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
    EmailAuth.sessionName = "Sample";
    var data = await EmailAuth.sendOtp(receiverMail: email);
    if (!data) {}
  }

  void verify() {
    var res = (EmailAuth.validate(
        receiverMail: email, //to make sure the email ID is not changed
        userOTP: _otpController.value.text));
    // EmailAuth.validate(
    // recieverMail: email, //to make sure the email ID is not changed
    // userOTP: _otpController.value.text));
    if (res) {
      print("Otp is varified");
      //pass in t
      // printhe OTP typed in
    } else {
      print("Otp is Not  varified");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Welcome"),
        backgroundColor: Colors.pink[200],
        elevation: 50.0,
        actions: <Widget>[
          FlatButton.icon(
              onPressed: () {
                // await _auth.signingOut();
                // firebaseUser = await await _auth.currentUser();
              },
              icon: Icon(Icons.person),
              label: Text("Logout")),
        ],
      ),
      body: Column(children: [
        Container(
            child: Center(
          child: RaisedButton(
              color: Colors.pink[400],
              child: Text("Send otp"),
              onPressed: () {
                sendOtp();
              }),
        )),
        TextField(
          controller: _otpController,
        ),
        RaisedButton(
            color: Colors.pink[400],
            child: Text("Validate "),
            onPressed: () {
              verify();
            }),
      ]),
    );
  }
}
