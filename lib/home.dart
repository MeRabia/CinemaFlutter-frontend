import 'package:flutter/material.dart';
import 'package:flutter_mobile_app/villes-page.dart';
import 'package:flutter_mobile_app/setting-page.dart';
import 'package:flutter_mobile_app/MenuItem.dart';
import 'package:flutter_mobile_app/contact-page.dart';
import 'package:flutter_mobile_app/auth.dart';

//import 'package:flutter_mobile_app/LoginPage.dart';
import 'package:flutter_mobile_app/authenticate/authenticate.dart';

class Home extends StatefulWidget {
 

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
   final AuthService _auth = AuthService();
  final menus = [
    {'title': 'Home', 'icon': Icon(Icons.home), 'page': VillePage()},
    {'title': 'Setting', 'icon': Icon(Icons.settings), 'page': SettingPage()},
    {'title': 'Contact', 'icon': Icon(Icons.contacts), 'page': ContactPage()},
    {'title': 'SignIn', 'icon': Icon(Icons.person), 'page': Authenticate()},
  ];
  @override
  Widget build(BuildContext context) {
    var assetsImage = new AssetImage('./images/CinemaHome.png'); //<- Creates an object that fetches an image.
    var image = new Image(image: assetsImage, fit: BoxFit.cover);
    return Scaffold(
      appBar: AppBar(
        title: Text("Home CinemaApp "),
        backgroundColor: Colors.red,
        elevation: 0.0,
        actions: <Widget>[
          FlatButton.icon(
            icon: Icon(Icons.person),
            label: Text('logout'),
            onPressed: () async {
              await  _auth.signOut();
            },
          ),
        ],
      ),
      body: Container(child: image),
     
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            DrawerHeader(
              child: Center(
                child: CircleAvatar(
                  backgroundImage: AssetImage("./images/profile.png"),
                  radius: 50,
                ),
              ),
              decoration: BoxDecoration(
                  gradient:
                      LinearGradient(colors: [Colors.white, Colors.red[400]])),
            ),
            ...this.menus.map((item) {
              return new Column(
                children: <Widget>[
                  Divider(
                    color: Colors.red[500],
                  ),
                  MenuItem(item['title'], item['icon'], (context) {
                    Navigator.pop(context);
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => item['page']));
                  })
                ],
              );
            })
          ],
        ),
      ),
    );
  }
}
