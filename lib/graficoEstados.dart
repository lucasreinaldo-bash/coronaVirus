class graficoEstados {
  final int num;
  final String estado;
  final String colorVal;
  graficoEstados(this.num, this.estado, this.colorVal);

  graficoEstados.fromMap(Map<String, dynamic> map)
      : assert(map['num'] != null),
        assert(map['estado'] != null),
        assert(map['colorVal'] != null),
        num = map['num'],
        estado = map['estado'],
        colorVal = map['colorVal'];

  @override
  String toString() => "Record<$num:$estado:$colorVal>";
}
//Obs: apesar de ter a String Estado, ela ta utilizada para armazenar a cidade
//Irei fazer a correção
