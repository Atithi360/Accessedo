// components
import 'package:accassado/home/item.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class dashbord extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // status bar color
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Color(0xff333), // status bar color
        statusBarIconBrightness: Brightness.dark));

    return Scaffold(
        body: SafeArea(
      child: Container(
          padding: EdgeInsets.fromLTRB(20, 10, 20, 30),
          child: Column(children: [
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.sort, size: 30, color: Colors.grey)),
                  CircleAvatar(radius: 20, backgroundImage: NetworkImage(''))
                ]),
            Expanded(
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Container(
                    width: 190,
                    height: 190,
                    alignment: Alignment.center,
                    child: Text("A",
                        style: TextStyle(
                            color: Colors.blueAccent[200],
                            fontSize: 100,
                            fontWeight: FontWeight.bold)),
                    decoration: new BoxDecoration(
                        borderRadius: new BorderRadius.circular(100.0),
                        border: Border.all(
                            color: Color(0xff7E89FC),
                            style: BorderStyle.solid,
                            width: 25),
                        color: Colors.transparent),
                  ),
                ]),
                flex: 1),
            Wrap(
              spacing: 17,
              runSpacing: 17,
              children: [
                Item(
                    title: 'Veiw History',
                    icon: Icons.history_outlined,
                    color: 0xffFD637B),
                Item(
                    title: 'Enter the building',
                    icon: Icons.exit_to_app,
                    color: 0xff21CDFF),
              ],
            ),
          ])),
    ));
  }
}
