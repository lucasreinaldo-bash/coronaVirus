class valoresDaTelaInicial {
  final int numConfirmados;
  final int numRecuperados;
  final int numMortes;
  valoresDaTelaInicial(
      this.numConfirmados, this.numRecuperados, this.numMortes);

  valoresDaTelaInicial.fromMap(Map<String, dynamic> map)
      : assert(map['numConfirmados'] != null),
        assert(map['numRecuperados'] != null),
        assert(map['numMortes'] != null),
        numConfirmados = map['numConfirmados'],
        numRecuperados = map['numRecuperados'],
        numMortes = map['numMortes'];

  @override
  String toString() => "Record<$numMortes:$numRecuperados:$numConfirmados>";
}
//Recuperando valores da Tela Inicial
