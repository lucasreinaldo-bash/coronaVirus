import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coronavirusinformativo/temp/crescimentoSemanalClass.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class impactoSeteDias extends StatefulWidget {
  @override
  _impactoSeteDiasState createState() {
    return _impactoSeteDiasState();
  }
}

class _impactoSeteDiasState extends State<impactoSeteDias> {
  List<charts.Series<crescimentoSemanalClass, String>> _seriesBarData;
  List<crescimentoSemanalClass> mydata;
  _generateData(mydata) {
    _seriesBarData = List<charts.Series<crescimentoSemanalClass, String>>();
    _seriesBarData.add(
      charts.Series(
        domainFn:
            (crescimentoSemanalClass crescimentoSemanalClassInstancia, _) =>
                crescimentoSemanalClassInstancia.numeroConfirmados.toString(),
        measureFn:
            (crescimentoSemanalClass crescimentoSemanalClassInstancia, _) =>
                crescimentoSemanalClassInstancia.numeroConfirmados,
        colorFn: (crescimentoSemanalClass crescimentoSemanalClassInstancia,
                _) =>
            charts.ColorUtil.fromDartColor(
                Color(int.parse(crescimentoSemanalClassInstancia.colorValue))),
        id: 'crescimentoCorona',
        data: mydata,
        labelAccessorFn: (crescimentoSemanalClass row, _) => "${row.data}",
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('')),
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection('crescimentoCorona').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return LinearProgressIndicator();
        } else {
          List<crescimentoSemanalClass> crescimentoSemanalClassInstancia =
              snapshot.data.documents
                  .map((documentSnapshot) =>
                      crescimentoSemanalClass.fromMap(documentSnapshot.data))
                  .toList();
          return _buildChart(context, crescimentoSemanalClassInstancia);
        }
      },
    );
  }

  Widget _buildChart(
      BuildContext context, List<crescimentoSemanalClass> saledata) {
    mydata = saledata;
    _generateData(mydata);
    return Padding(
      padding: EdgeInsets.all(1.0),
      child: Container(
        margin: EdgeInsets.all(10),
        child: Center(
          child: Column(
            children: <Widget>[
              Center(
                child: Text(
                  'Confirmação dos casos no Brasil - ÚLTIMOS 7 DIAS',
                  style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              Expanded(
                child: charts.BarChart(
                  _seriesBarData,
                  animate: true,
                  animationDuration: Duration(seconds: 2),
                  behaviors: [
                    new charts.DatumLegend(
                      entryTextStyle: charts.TextStyleSpec(
                          color: charts.MaterialPalette.purple.shadeDefault,
                          fontFamily: 'Roboto',
                          fontSize: 8),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
