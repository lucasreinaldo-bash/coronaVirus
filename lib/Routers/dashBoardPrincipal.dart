import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coronavirusinformativo/Charts/graficoConfirmados.dart';
import 'package:coronavirusinformativo/Firebase/valoresDaTelaInicial.dart';
import 'package:coronavirusinformativo/temp/crescimentoSemanalClass.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:http/http.dart' as http;
import 'package:charts_flutter/flutter.dart' as charts;
import 'dart:convert';
import 'dart:async';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_sparkline/flutter_sparkline.dart';
import '../User.dart';

const requestApi = "https://pomber.github.io/covid19/timeseries.json";
const imgPaises = "https://restcountries.eu/rest/v2/alpha";

class PaisesAfetados extends StatefulWidget {
  @override
  _PaisesAfetadosState createState() => _PaisesAfetadosState();
}

Future<Map> getData() async {
  http.Response response = await http.get(requestApi);
  return json.decode(response.body);
}

class _PaisesAfetadosState extends State<PaisesAfetados> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BookList(),
      backgroundColor: Colors.white,
    );
  }
}

class BookList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Firestore.instance
          .collection('valoresTelaInicial')
          .document('valores')
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) return new Text('Error: ${snapshot.error}');
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return new Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.lime,
              ),
            );
          default:
            var userDocument = snapshot.data;
            return _buildChart(
                userDocument["numConfirmados"].toString(),
                userDocument["numRecuperados"].toString(),
                userDocument["numMortes"].toString());
        }
      },
    );
  }
}

Widget _buildChart(String numConfirmados, numRecuperados, numMortes) {
  valoresDaTelaInicial valoresDaTelaInicialInstancia;

  String recebido = numConfirmados;
  return Column(children: <Widget>[
    SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Center(
            child: Image.asset(
              'assets/logodash.png',
              width: 200,
              height: 200,
            ),
          ),
          Card(
              elevation: 10,
              child: Column(children: <Widget>[
                Image.asset(
                  'assets/br-logo.png',
                  width: 50,
                  height: 50,
                ),
                Center(
                    child: Column(
                  children: <Widget>[
                    Row(
                      children: [
                        Container(
                          margin: const EdgeInsets.all(10.0),
                          width: 150,
                          height: 80,
                          child: Center(
                            child: Column(
                              children: <Widget>[
                                Text(
                                  numConfirmados,
                                  style: TextStyle(
                                      color: Colors.blueAccent, fontSize: 40),
                                ),
                                Text('casos confirmados')
                              ],
                            ),
                          ),
                        ),
                        Container(
                          height: 80,
                          width: 1,
                          color: Colors.blueAccent,
                        ),
                        Container(
                          margin: const EdgeInsets.all(10.0),
                          width: 150,
                          height: 80,
                          child: Center(
                            child: Column(
                              children: <Widget>[
                                Text(
                                  numRecuperados,
                                  style: TextStyle(
                                      color: Colors.green, fontSize: 40),
                                ),
                                Text('pessoas recuperadas')
                              ],
                            ),
                          ),
                        ),

//                  leading: Image.network(
//                      'https://www.countryflags.io/BR/shiny/64.png',
//                      height: 50,
//                      width: 50),
                      ],
                    ),
                  ],
                )),
              ])),
          Column(
            children: <Widget>[
              Container(
                height: 200,
                margin: const EdgeInsets.fromLTRB(10, 10, 10, 0.01),
                width: 200,
                child: Center(
                  child: Column(
                    children: <Widget>[
                      Text(
                        numMortes,
                        style:
                            TextStyle(color: Colors.red.shade500, fontSize: 20),
                      ),
                      Text('mortes registradas'),
                      Center(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Image.asset(
                              'assets/casaldemascara.png',
                              width: 160,
                              height: 161,
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    )
  ]);
}
