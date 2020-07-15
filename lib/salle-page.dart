import 'package:flutter/material.dart';
import 'package:flutter_mobile_app/GlobalVariables.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

// ignore: must_be_immutable
class SallesPage extends StatefulWidget {
  dynamic cinema;
  SallesPage(this.cinema);
  @override
  _SallesPageState createState() => _SallesPageState();
}

class _SallesPageState extends State<SallesPage> {
  List<dynamic> listSalles;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text('Cinema de ${widget.cinema['name']}'),
      ),
      body: Center(
          child: this.listSalles == null
              ? CircularProgressIndicator()
              : ListView.builder(
                  itemCount:
                      (this.listSalles == null) ? 0 : this.listSalles.length,
                  itemBuilder: (context, index) {
                    return Card(
                        color: Colors.red[300],
                        child: Column(
                          children: <Widget>[
                            Container(
                              width: double.infinity,
                              child: Padding(
                                padding: const EdgeInsets.all(3.5),
                                child: RaisedButton(
                                    child: Text(this.listSalles[index]['name']),
                                    onPressed: () {
                                      //charger les projection de la salle
                                      loadProjections(this.listSalles[index]);
                                    }),
                              ),
                            ),
                            if (this.listSalles[index]['projections'] != null)
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Image.network(
                                        GlobalData.host +
                                            "/imageFilm/${this.listSalles[index]['currentProjection']['film']['id']}",
                                        width: 160),
                                    Column(
                                      children: <Widget>[
                                        ...(this.listSalles[index]
                                                    ['projections']
                                                as List<dynamic>)
                                            .map((projection) {
                                          return RaisedButton(
                                              color: (this.listSalles[index][
                                                              'currentProjection']
                                                          ['id'] ==
                                                      projection['id']
                                                  ? Colors.white
                                                  : Colors.red[200]),
                                              child: Text(
                                                  "${projection['seance']['heureDebut']}(${projection['film']['duree']}h, Prix=${projection['prix']})",
                                                  style:
                                                      TextStyle(fontSize: 12)),
                                              onPressed: () {
                                                loadTickets(projection,
                                                    this.listSalles[index]);
                                              });
                                        })
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            if (this.listSalles[index]['currentProjection'] !=
                                    null &&
                                listSalles[index]['currentProjection']
                                        ['listTickets'] !=
                                    null &&
                                listSalles[index]['currentProjection']
                                            ['listTickets']
                                        .length >
                                    0)
                              Column(
                                children: <Widget>[
                                  Row(
                                    children: <Widget>[
                                      Text(
                                        "Nombre de place Dispo : ${this.listSalles[index]['currentProjection']['nombrePlaceDisponibles']}",
                                      )
                                    ],
                                  ),
                                  Container(
                                      padding: EdgeInsets.fromLTRB(6, 2, 6, 3),
                                      child: TextField(
                                        //cursorColor: Colors.black,
                                        decoration: InputDecoration(
                                          hintText: 'Name..',
                                          icon: Icon(Icons.person),
                                          border: OutlineInputBorder(),
                                        ),
                                      )),
                                  Container(
                                      padding: EdgeInsets.fromLTRB(6, 2, 6, 3),
                                      child: TextField(
                                        //cursorColor: Colors.black,
                                        decoration: InputDecoration(
                                          hintText: 'Code Payment..',
                                          icon: Icon(Icons.payment),
                                          border: OutlineInputBorder(),
                                        ),
                                      )),
                                  Container(
                                      padding: EdgeInsets.fromLTRB(6, 2, 6, 3),
                                      child: TextField(
                                        //cursorColor: Colors.black,
                                        decoration: InputDecoration(
                                          hintText: 'Nombre Tickets..',
                                          icon: Icon(Icons.money_off),
                                          border: OutlineInputBorder(),
                                        ),
                                      )),
                                  Container(
                                    child: RaisedButton(
                                      child: Text("Reserver les places"),
                                      onPressed: () {},
                                    ),
                                  ),
                                  Wrap(
                                    children: <Widget>[
                                      ...this
                                          .listSalles[index]
                                              ['currentProjection']
                                              ['listTickets']
                                          .map((ticket) {
                                        if (ticket['reservee'] == false)
                                          return Container(
                                            width: 40,
                                            padding: EdgeInsets.all(3),
                                            child:  RaisedButton(
                                              color: Colors.red[400],
                                              child: Text(
                                                "${ticket['place']['numero']}",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 12),
                                              ),
                                              onPressed: () {},
                                            ),
                                          );
                                        else
                                          return Container();
                                      })
                                    ],
                                  ),
                                ],
                              )
                          ],
                        ));
                  })),
    );
  }

  @override
  void initState() {
    super.initState();
    // methode que je vais creer
    loadSalles();
  }

  void loadSalles() {
    String url = this.widget.cinema['_links']['salles']['href'];
    http.get(url).then((resp) {
      setState(() {
        this.listSalles = json.decode(resp.body)['_embedded']['salles'];
      });
    }).catchError((err) {
      print(err);
    });
  }

  void loadProjections(salle) {
    // String url =
    // GlobalData.host + "/salles/${salle['id']}/projections?projection=p1";
    String url = salle['_links']['projections']['href']
        .toString()
        .replaceAll("{?projection}", "?projection=p1");
    print(url);
    http.get(url).then((resp) {
      setState(() {
        salle['projections'] =
            json.decode(resp.body)['_embedded']['projectionFilms'];
        salle['currentProjection'] = salle['projections'][0];
        salle['currentProjection']['listTickets'] = [];
        print(salle['projections']);
      });
    }).catchError((err) {
      print(err);
    });
  }

  void loadTickets(projection, salle) {
    String url =
         projection['_links']['tickets']['href']
        .toString()
        .replaceAll("{?projection}", "?projection=ticketProj"); 
       // "http://192.168.1.4:8080/projectionFilms/2/tickets?projection=ticketProj";

    http.get(url).then((resp) {
      setState(() {
        projection['listTickets'] =
            json.decode(resp.body)['_embedded']['tickets'];
        salle['currentProjection'] = projection;
        projection['nombrePlaceDisponibles'] =
            nombrePlaceDisponibles(projection);
      });
    }).catchError((err) {
      print(err);
    });
  }

  nombrePlaceDisponibles(projection) {
    int nombre = 0;
    for (int i = 0; i < projection['tickets'].length; i++) {
      if (projection['tickets'][i]['reservee'] == false)
        ++nombre; //incrementer le nombre
    }
    return nombre;
  }
}
