import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

import 'graficoEstados.dart';

class municipiosBaianosChart extends StatefulWidget {
  @override
  _municipiosBaianosChartState createState() {
    return _municipiosBaianosChartState();
  }
}

class _municipiosBaianosChartState extends State<municipiosBaianosChart> {
  List<charts.Series<graficoEstados, String>> _seriesPieData;
  List<graficoEstados> mydata;
  _generateData(mydata) {
    _seriesPieData = List<charts.Series<graficoEstados, String>>();
    _seriesPieData.add(
      charts.Series(
        domainFn: (graficoEstados task, _) => task.estado,
        measureFn: (graficoEstados task, _) => task.num,
        colorFn: (graficoEstados task, _) =>
            charts.ColorUtil.fromDartColor(Color(int.parse(task.colorVal))),
        id: 'graficoPorEstado',
        data: mydata,
        labelAccessorFn: (graficoEstados row, _) => "${row.num}",
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("")),
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection('graficoPorEstado').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return LinearProgressIndicator();
        } else {
          List<graficoEstados> task = snapshot.data.documents
              .map((documentSnapshot) =>
                  graficoEstados.fromMap(documentSnapshot.data))
              .toList();
          return _buildChart(context, task);
        }
      },
    );
  }

  Widget _buildChart(BuildContext context, List<graficoEstados> taskdata) {
    mydata = taskdata;
    _generateData(mydata);
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Container(
        child: Center(
          child: Column(
            children: <Widget>[
              Text(
                'Municípios baianos afetados',
                style: TextStyle(
                    fontSize: 24.0,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.normal),
              ),
              SizedBox(
                height: 10.0,
              ),
              Expanded(
                child: charts.PieChart(_seriesPieData,
                    animate: true,
                    animationDuration: Duration(seconds: 2),
                    behaviors: [
                      new charts.DatumLegend(
                        outsideJustification:
                            charts.OutsideJustification.startDrawArea,
                        horizontalFirst: false,
                        desiredMaxRows: 6,
                        cellPadding: new EdgeInsets.only(
                            right: 4.0, bottom: 4.0, top: 4.0),
                        entryTextStyle: charts.TextStyleSpec(
                            color: charts.MaterialPalette.blue.shadeDefault,
                            fontFamily: 'QuickSand',
                            fontSize: 12),
                      )
                    ],
                    defaultRenderer: new charts.ArcRendererConfig(
                        arcWidth: 100,
                        arcRendererDecorators: [
                          new charts.ArcLabelDecorator(
                              labelPosition: charts.ArcLabelPosition.inside)
                        ])),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
