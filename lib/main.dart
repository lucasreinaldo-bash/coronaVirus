import 'package:coronavirusinformativo/Routers/Informativos.dart';
import 'package:coronavirusinformativo/Routers/dashBoardPrincipal.dart';
import 'package:coronavirusinformativo/municipiosBaianosChart.dart';
import 'package:coronavirusinformativo/temp/impactoSeteDias.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:coronavirusinformativo/PaginaInicial.dart';

FirebaseAnalytics analytics = FirebaseAnalytics();
void main() => runApp(MaterialApp(
      home: PaginaInicial(),
      navigatorObservers: [
        FirebaseAnalyticsObserver(analytics: analytics),
      ],
    ));

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text(""),
      ),
    );
  }
}
