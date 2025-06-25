library globals;

import 'usuario/reinscripcion/crear_horario.dart';

class Global {
  static final Global _instancia = Global._internal();

  factory Global() => _instancia;

  Global._internal();

  Map<String, dynamic>? alumno;
  Map<String, dynamic>? datos; // datos[0]
  List<dynamic>? historial;
  // ignore: non_constant_identifier_names
  List<dynamic>? horarios_faltantes;
  List<Horario> horariosConfirmados = [];

  void reset() {
    alumno = null;
    datos = null;
    historial = null;
  }
}

class ReinscripcionStatus {
  static bool datosActualizados = false;
  static bool boletaDescargada = false;
  static bool pagoSubido = false;
  static bool horarioCreado = false;
}

class DatosActualizadosTemp {
  static String celular = '';
  static String casa = '';
  static String trabajo = '';
  static String emergencia = '';
  static String nombreEmergencia = '';
  static String parentesco = '';
  static String calle = '';
  static String numExt = '';
  static String numInt = '';
  static String calle1 = '';
  static String calle2 = '';
  static String referencias = '';
  static String genero = 'Hombre';
}
