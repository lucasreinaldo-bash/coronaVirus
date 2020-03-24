class graficoConfirmados {
  final int numeroDeCasos;
  final String dataCaso;
  final String colorCaso;

  graficoConfirmados(this.numeroDeCasos, this.colorCaso, this.dataCaso);

  graficoConfirmados.fromMap(Map<String, dynamic> map)
      : assert(map['numeroDeCasos'] != null),
        assert(map['dataCaso'] != null),
        assert(map['colorCaso'] != null),
        numeroDeCasos = map['numeroDeCasos'],
        dataCaso = map['dataCaso'],
        colorCaso = map['colorCaso'];

  @override
  String toString() => "Record<$numeroDeCasos:$dataCaso:$colorCaso>";
}

//Classe usada para recuperar os elementos do Google Firestore
