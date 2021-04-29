// import 'package:e_orgeeno/pages/login.dart';
// import 'package:e_orgeeno/pages/Register.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Resetpassword extends StatefulWidget {
  @override
  _Resetpassword createState() => _Resetpassword();
}

class _Resetpassword extends State<Resetpassword> {
  final _auth = FirebaseAuth.instance;
  String email;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0.1,
          backgroundColor: Color(0xff6C8868),
          title: Center(child: Text('Orgeeno')),
        ),
        body: Container(
            decoration: BoxDecoration(
                image: DecorationImage(
              image: AssetImage(
                'images/bg1.jpg',
              ),
              fit: BoxFit.cover,
            )),
            child: Card(
                color: Colors.transparent,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Flexible(
                      //   child: Hero(
                      //     tag: 'logo',
                      //     child: Container(
                      //       child: Image.asset('images/logo.jpeg'),
                      //     ),
                      //   ),
                      // ),
                      Text(
                        "Reset Password",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 40,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 48.0,
                      ),
                      Container(
                        margin: EdgeInsets.all(30),
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                  color: Color.fromRGBO(143, 148, 251, .2),
                                  blurRadius: 20.0,
                                  offset: Offset(0, 10))
                            ]),
                        child: Column(children: <Widget>[
                          Container(
                            padding: EdgeInsets.all(8.0),
                            decoration: BoxDecoration(
                                border: Border(
                                    bottom:
                                        BorderSide(color: Colors.grey[100]))),
                            child: TextField(
                              onChanged: (value) {
                                email = value;
                              },
                              keyboardType: TextInputType.emailAddress,
                              textAlign: TextAlign.center,
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Email ",
                                  hintStyle:
                                      TextStyle(color: Colors.grey[800])),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  margin: EdgeInsets.all(5),
                                  height: 50,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      gradient: LinearGradient(colors: [
                                        Color.fromRGBO(143, 148, 251, 1),
                                        Color.fromRGBO(143, 148, 251, .6),
                                      ])),
                                  child: MaterialButton(
                                    onPressed: () {
                                      _auth.sendPasswordResetEmail(
                                          email: email);
                                      Navigator.of(context).pop();
                                    },
                                    child: Text(
                                      "Send request",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                              ])
                        ]),
                      )
                    ]))));
  }
}
