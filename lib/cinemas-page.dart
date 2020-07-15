import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import './salle-page.dart';
import 'dart:convert';

// ignore: must_be_immutable
class CinemasPage extends StatefulWidget {
  dynamic ville;
  CinemasPage(this.ville);
  @override
  _CinemasPageState createState() => _CinemasPageState();
}

class _CinemasPageState extends State<CinemasPage> {
  List<dynamic> listCinemas;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text('Cinema de ${widget.ville['name']}'),
      ),
      body: Center(
          child: this.listCinemas == null
              ? CircularProgressIndicator()
              : ListView.builder(
                  itemCount:
                      (this.listCinemas == null) ? 0 : this.listCinemas.length,
                  itemBuilder: (context, index) {
                    return Card(
                      color: Colors.red[300],
                      child: Padding(
                        padding: const EdgeInsets.all(9.0),
                        child: RaisedButton(
                            child: Text(this.listCinemas[index]['name']),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (conext) => new SallesPage(
                                          this.listCinemas[index])));
                            }),
                      ),
                    );
                  })),
    );
  }

  @override
  void initState() {
    super.initState();
    // methode que je vais creer
    loadCinemas();
  }

  void loadCinemas() {
    String url = this.widget.ville['_links']['cinemas']['href'];
    http.get(url).then((resp) {
      setState(() {
        this.listCinemas = json.decode(resp.body)['_embedded']['cinemas'];
      });
    }).catchError((err) {
      print(err);
    });
  }
}
