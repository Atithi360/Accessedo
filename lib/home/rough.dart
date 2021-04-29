import 'package:carousel_slider/carousel_slider.dart';
import 'package:e_orgeeno/components/Products.dart';
import 'package:e_orgeeno/components/horizantel_listveiw.dart';
import 'package:e_orgeeno/pages/cart.dart';
import 'package:e_orgeeno/pages/chat_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _auth = FirebaseAuth.instance;
  User loggedInUser;
  String email;
  @override
  void initState() {
    super.initState();
    getCurrentuser();
  }

  void getCurrentuser() async {
    try {
      final user = await _auth.currentUser;
      email = user.email;
      if (user != null) {}
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    CarouselSlider(
      items: [
        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(12)),
              image: DecorationImage(
                image: AssetImage('image/5.png'),
                fit: BoxFit.cover,
              )),
        )
      ],
      options: CarouselOptions(
        height: 200.0,
      ),
    );
    return Center(
      child: Scaffold(
        backgroundColor: Color(0xffF3F0F0),
        appBar: AppBar(
            elevation: 0.1,
            backgroundColor: Color(0xff6C8868),
            title: Center(child: Text('Orgeeno')),
            actions: [
              IconButton(
                icon: Icon(
                  Icons.search,
                  color: Colors.white,
                ),
                onPressed: null,
              ),
              IconButton(
                icon: Icon(
                  Icons.shopping_cart,
                  color: Colors.white,
                ),
                onPressed: () {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (context) => Cart()));
                },
              ),
              IconButton(
                icon: Icon(
                  Icons.comment_bank,
                  color: Colors.white,
                ),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => ChatScreen()));
                },
              ),
            ]),
        body: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            CarouselSlider(
              items: [
                Container(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('images/grd.jpg'),
                        fit: BoxFit.cover,
                      )),
                ),
                Container(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('images/gr.png'),
                        fit: BoxFit.cover,
                      )),
                ),
              ],
              options: CarouselOptions(
                height: 250.0,
                viewportFraction: 0.98,
                autoPlay: true,
                reverse: true,
                autoPlayCurve: Curves.fastOutSlowIn,
                enlargeCenterPage: true,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(5.0),
              child: Text('Categories'),
            ),
            Horizantellist(),
            Padding(
              padding: EdgeInsets.fromLTRB(3.0, 32, 0, 0),
              child: Container(
                  alignment: Alignment.topLeft, child: Text('Recent Products')),
            ),
            Flexible(child: Products()),
          ],
        ),
        drawer: Drawer(
          child: ListView(
            children: [
              //header
              new UserAccountsDrawerHeader(
                accountName: Text('Atithi'),
                accountEmail: Text('$email'),
                currentAccountPicture: GestureDetector(
                  child: CircleAvatar(
                    backgroundColor: Color(0xff3A2C22),
                    child: Icon(
                      Icons.person,
                      color: Colors.white,
                    ),
                  ),
                ),
                decoration: BoxDecoration(color: Color(0xff6C8868)),
              ),
              InkWell(
                onTap: () {},
                child: ListTile(
                  title: Text('Home'),
                  leading: Icon(
                    Icons.home,
                    color: Colors.green,
                  ),
                ),
              ),
              InkWell(
                onTap: () {},
                child: ListTile(
                  title: Text('MyAccount'),
                  leading: Icon(Icons.person, color: Colors.green),
                ),
              ),
              InkWell(
                onTap: () {},
                child: ListTile(
                  title: Text('MyOrders'),
                  leading: Icon(Icons.shopping_basket, color: Colors.green),
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (context) => Cart()));
                },
                child: ListTile(
                  title: Text('Shopping Cart'),
                  leading: Icon(Icons.shopping_cart, color: Colors.green),
                ),
              ),
              InkWell(
                onTap: () {},
                child: ListTile(
                  title: Text('Setting'),
                  leading: Icon(Icons.settings, color: Colors.green),
                ),
              ),
              InkWell(
                onTap: () {},
                child: ListTile(
                  title: Text('About'),
                  leading: Icon(
                    Icons.help,
                    color: Colors.green,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
