import 'package:flutter/material.dart';
import 'package:flutter_mobile_app/GlobalVariables.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import './cinemas-page.dart';

class VillePage extends StatefulWidget {
  @override
  _VillePageState createState() => _VillePageState();
}

class _VillePageState extends State<VillePage> {
  List<dynamic> listVilles;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text("Villes"),
      ),
      body: Center(
          child: this.listVilles == null ? CircularProgressIndicator() : ListView.builder(
                  itemCount:
                      (this.listVilles == null) ? 0 : this.listVilles.length,
                  itemBuilder: (context, index) {
                    return Card(
                      color: Colors.deepOrange,
                      child: RaisedButton(
                        child: Text(this.listVilles[index]['name']),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      CinemasPage(listVilles[index])));
                        },
                      ),
                    );
                  })),
    );
  }

  

  void loadVilles() {
    //String url = "http://192.168.1.4:8080/villes";
    String url = GlobalData.host + "/villes";
    http.get(url).then((resp) {
     
        setState(() {
        this.listVilles = json.decode(resp.body)['_embedded']['villes'];
      });
      
    }).catchError((err) {
      print(err);
    });
  }

  @override
  void initState() {
    super.initState();
    // methode que je vais creer
    loadVilles();
  }
}
