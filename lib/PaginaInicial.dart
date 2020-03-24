import 'package:coronavirusinformativo/Routers/dashBoardPrincipal.dart';
import 'package:coronavirusinformativo/municipiosBaianosChart.dart';
import 'package:coronavirusinformativo/temp/impactoSeteDias.dart';
import 'package:flutter/material.dart';
import 'package:coronavirusinformativo/Widgets/AnimatedBottomNavBar.dart';
import 'package:flutter/services.dart';
import 'package:coronavirusinformativo/Routers/Informativos.dart';
import 'package:coronavirusinformativo/Routers/ChatBot.dart';
import 'package:firebase_database/firebase_database.dart';

class PaginaInicial extends StatefulWidget {
  final List<BarItem> barItems = [
    BarItem(
      text: "Últimos 7 dias",
      iconData: Icons.insert_chart,
      color: Colors.indigo,
    ),
    BarItem(
      text: "Relatório Geral",
      iconData: Icons.show_chart,
      color: Colors.blueAccent.shade700,
    ),
    BarItem(
      text: "Impacto na Bahia",
      iconData: Icons.pie_chart,
      color: Colors.lightBlue.shade900,
    ),

    /*BarItem(
      text: "Search",
      iconData: Icons.search,
      color: Colors.yellow.shade900,
    ),
    */
  ];
  @override
  _PaginaInicialState createState() => _PaginaInicialState();
}

class _PaginaInicialState extends State<PaginaInicial> {
  int selectedBarIndex = 1;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        //systemNavigationBarColor: Colors.lightBlue[700], // navigation bar color
        //statusBarColor: Colors.lightBlue[700],
        systemNavigationBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: Colors.blueAccent,
        statusBarIconBrightness: Brightness.dark // status bar color
        ));

    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

    List<Widget> telas = [
      impactoSeteDias(),
      PaisesAfetados(),
      municipiosBaianosChart()
    ];

    return Scaffold(
      body: telas[selectedBarIndex],
      bottomNavigationBar: AnimatedBottomBar(
        barItems: widget.barItems,
        animationDuration: const Duration(milliseconds: 150),
        barStyle: BarStyle(fontSize: width * 0.045, iconSize: width * 0.07),
        onBarTap: (index) {
          setState(() {
            selectedBarIndex = index;
          });
        },
      ),
    );
  }
}
