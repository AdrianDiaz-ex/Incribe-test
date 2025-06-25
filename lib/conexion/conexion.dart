import 'dart:convert';
import 'package:http/http.dart' as http;

Future<Map<String, dynamic>> iniciarSesion(
  String correo,
  String password,
  String tipo, // <- puede ser "alumno" o "admin"
) async {
  try {
    final url = Uri.parse('https://api-279a.onrender.com/login');
    print("Esperando conexión: $tipo");

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'correo': correo, 'password': password, 'tipo': tipo}),
    );
    print('Código de respuesta: ${response.statusCode}');
    print('Cuerpo de respuesta: ${response.body}');

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data;
    } else {
      throw Exception('Error en el servidor: ${response.statusCode}');
    }
  } catch (e) {
    print('Error real: $e');
    throw Exception('Error de conexión: $e');
  }
}
