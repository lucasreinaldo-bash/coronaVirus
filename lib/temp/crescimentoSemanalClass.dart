class crescimentoSemanalClass {
  final int numeroConfirmados;
  final String data;
  final String colorValue;
  crescimentoSemanalClass(this.numeroConfirmados, this.data, this.colorValue);

  crescimentoSemanalClass.fromMap(Map<String, dynamic> map)
      : assert(map['numeroConfirmados'] != null),
        assert(map['data'] != null),
        assert(map['colorValue'] != null),
        numeroConfirmados = map['numeroConfirmados'],
        colorValue = map['colorValue'],
        data = map['data'];

  @override
  String toString() => "Record<$numeroConfirmados:$data:$colorValue>";
}
