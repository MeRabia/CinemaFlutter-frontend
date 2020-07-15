
import 'package:flutter/material.dart';
//import 'package:flutter_mobile_app/cinemas-page.dart';
/* import 'package:flutter_mobile_app/villes-page.dart';
import 'package:flutter_mobile_app/setting-page.dart';
import 'package:flutter_mobile_app/MenuItem.dart';
import 'package:flutter_mobile_app/contact-page.dart'; */
//import 'package:flutter_mobile_app/LoginPage.dart';
import 'package:flutter_mobile_app/auth.dart'; 
import 'package:flutter_mobile_app/models/user.dart'; 
import 'package:provider/provider.dart';
import 'package:flutter_mobile_app/wrapper.dart'; 
import 'package:flutter_mobile_app/home.dart';

void main() => runApp(MyApp());


class MyApp extends StatelessWidget {

  void main() => runApp(MaterialApp(
      theme: ThemeData(
        appBarTheme: AppBarTheme(color: Colors.red),
      ),
      home: Home(),
      //home:MyApp(),
    ));
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      value: AuthService().user,
      child: MaterialApp(
         home: Scaffold(
            body: Container(
              
                  decoration: BoxDecoration(
                    
                    image: DecorationImage(
                        image: AssetImage('images/CinemaHome.png'),
                        fit: BoxFit.cover),
                  ),
                  child:  Wrapper(),
            )),
        
      ),
    );
  }
}
//void main() => runApp(MyApp());

//class MyApp extends StatelessWidget {

/* void main() => runApp(MaterialApp(
      theme: ThemeData(
        appBarTheme: AppBarTheme(color: Colors.red),
      ),
      home: Home(),
      //home:MyApp(),
    ));

class MyApp extends StatefulWidget {
  

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> { */
 /* final menus = [
    {'title': 'Ville', 'icon': Icon(Icons.location_city), 'page': VillePage()},
    {'title': 'Setting', 'icon': Icon(Icons.settings), 'page': SettingPage()},
    {'title': 'Contact', 'icon': Icon(Icons.contacts), 'page': ContactPage()},
   // {'title': 'SignIn', 'icon': Icon(Icons.person), 'page': Authenticate()},
  ]; */
 /*  @override
  Widget build(BuildContext context) {

     return StreamProvider<User>.value(
      value: AuthService().user,
      child: MaterialApp(
        home: Wrapper(),
      ),
    );  */
    /* return Scaffold(
      appBar: AppBar(
        title: Text("Home Page "),
      ),
      body: Center(
        child: Text("Home Cinema hello..."),
      ),
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
                      LinearGradient(colors: [Colors.white, Colors.green])),
            ),
            ...this.menus.map((item) {
              return new Column(
                children: <Widget>[
                  Divider(
                    color: Colors.brown,
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
    ); */
 // }
//}
//}
