import 'package:coronavirusinformativo/Routers/dashBoardPrincipal.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

var _firebaseRef = FirebaseDatabase.instance.reference();

class Informativos extends StatefulWidget {
  @override
  _InformativosState createState() => _InformativosState();
}

class _InformativosState extends State<Informativos> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
