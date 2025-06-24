library globals;

class Global {
  static final Global _instancia = Global._internal();

  factory Global() => _instancia;

  Global._internal();

  Map<String, dynamic>? alumno;
  Map<String, dynamic>? datos; // datos[0]
  List<dynamic>? historial;

  void reset() {
    alumno = null;
    datos = null;
    historial = null;
  }

  bool datosActualizados = false;
  bool boletaDescargada = false;
  bool pagoSubido = false;
  bool horarioCreado = false;
}
