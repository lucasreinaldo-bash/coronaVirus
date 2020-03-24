class apiPumber {
  String data, confirmados, mortes, recuperados;

  apiPumber(this.recuperados, this.data, this.mortes, this.confirmados);

  apiPumber.fromJson(Map<String, dynamic> json) {
    data = json["date"];
    confirmados = json["confirmed"];
    mortes = json["deaths"];
    recuperados = json["recovered"];
  }
}
//Essa classe era na versão anterior
// O App consumia os dados de uma API em Json https://pomber.github.io/covid19/timeseries.json
