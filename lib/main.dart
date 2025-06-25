import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'admin/Admin_inicio.dart';
import 'usuario/Usuario_inicio.dart';
import 'conexion/conexion.dart';
import 'global.dart';
import 'dart:ui';

void main() =>
    runApp(MaterialApp(debugShowCheckedModeBanner: false, home: MyApp()));

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String _errorMessage = '';
  bool _isLoading = false;

  Future<void> _login({bool isAdmin = false}) async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
      _errorMessage = '';
    });

    final email = _emailController.text.trim();
    final password = _passwordController.text;

    try {
      if (!isAdmin) {
        final data = await iniciarSesion(email, password, 'alumno');
        Global().alumno = data['alumno'];
        Global().datos = data['datos'][0];
        Global().historial = data['calificaciones'];
        Global().horarios_faltantes = data['horarios_faltantes'];

        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('¡Login exitoso!')));

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const UsuarioInicio()),
        );
      } else {
        final data = await iniciarSesion(email, password, 'admin');

        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('¡Login exitoso!')));

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const AdminInicio()),
        );
      }
    } catch (e) {
      print('Error en login: $e');
      setState(() {
        _errorMessage = 'Credenciales incorrectas o error de conexión';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            colors: [
              Colors.grey.shade900,
              Colors.grey.shade800,
              Colors.grey.shade700,
            ],
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 80),
            Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  FadeInUp(
                    duration: Duration(milliseconds: 1000),
                    child: Text(
                      "Iniciar Sesion".toUpperCase(),
                      style: TextStyle(color: Colors.white, fontSize: 40),
                    ),
                  ),
                  SizedBox(height: 10),
                  FadeInUp(
                    duration: Duration(milliseconds: 1300),
                    child: Text(
                      "Bienvenido de vuelta",
                      style: TextStyle(color: Colors.white70, fontSize: 18),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                  image: DecorationImage(
                    image: AssetImage('assets/tec.webp'),
                    fit: BoxFit.cover,
                  ),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
                    child: Container(
                      // ignore: deprecated_member_use
                      color: const Color(0xFF2A2929).withOpacity(0.5),
                      padding: EdgeInsets.all(30),
                      child: SingleChildScrollView(
                        child: Form(
                          key: _formKey,
                          child: Column(
                            children: <Widget>[
                              SizedBox(height: 60),
                              FadeInUp(
                                duration: Duration(milliseconds: 1400),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.grey[850],
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black26,
                                        blurRadius: 10,
                                        offset: Offset(0, 5),
                                      ),
                                    ],
                                  ),
                                  child: Column(
                                    children: <Widget>[
                                      Container(
                                        padding: EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                          border: Border(
                                            bottom: BorderSide(
                                              color: Colors.grey.shade800,
                                            ),
                                          ),
                                        ),
                                        child: TextFormField(
                                          controller: _emailController,
                                          style: TextStyle(color: Colors.white),
                                          decoration: InputDecoration(
                                            hintText: "Correo institucional",
                                            hintStyle: TextStyle(
                                              color: Colors.white54,
                                            ),
                                            border: InputBorder.none,
                                          ),
                                          validator: (value) {
                                            if (value == null ||
                                                value.trim().isEmpty) {
                                              return 'Introduce un email';
                                            }
                                            return null;
                                          },
                                        ),
                                      ),
                                      Container(
                                        padding: EdgeInsets.all(10),
                                        child: TextFormField(
                                          controller: _passwordController,
                                          obscureText: true,
                                          style: TextStyle(color: Colors.white),
                                          decoration: InputDecoration(
                                            hintText: "Contraseña",
                                            hintStyle: TextStyle(
                                              color: Colors.white54,
                                            ),
                                            border: InputBorder.none,
                                          ),
                                          validator: (value) {
                                            if (value == null ||
                                                value.trim().isEmpty) {
                                              return 'Introduce una contraseña';
                                            }
                                            return null;
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(height: 20),
                              if (_isLoading)
                                FadeInUp(
                                  duration: Duration(milliseconds: 1400),
                                  child: CircularProgressIndicator(
                                    color:
                                        Colors
                                            .greenAccent, // O el color que combine con tu tema
                                  ),
                                ),
                              if (_errorMessage.isNotEmpty)
                                FadeInUp(
                                  duration: Duration(milliseconds: 1450),
                                  child: Text(
                                    _errorMessage,
                                    style: TextStyle(
                                      color: Colors.red,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              SizedBox(height: 20),
                              FadeInUp(
                                duration: Duration(milliseconds: 1500),
                                child: Text(
                                  "Forgot Password?",
                                  style: TextStyle(color: Colors.white60),
                                ),
                              ),
                              SizedBox(height: 30),
                              FadeInUp(
                                duration: Duration(milliseconds: 1600),
                                child: MaterialButton(
                                  onPressed:
                                      _isLoading
                                          ? null
                                          : () {
                                            if (_formKey.currentState!
                                                .validate()) {
                                              _login();
                                            }
                                          },
                                  height: 50,
                                  color: const Color.fromARGB(255, 9, 171, 47),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                  child: Center(
                                    child: Text(
                                      "Iniciar Sesión",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 20),
                              FadeInUp(
                                duration: Duration(milliseconds: 1650),
                                child: MaterialButton(
                                  onPressed:
                                      _isLoading
                                          ? null
                                          : () {
                                            if (_formKey.currentState!
                                                .validate()) {
                                              _login();
                                            }
                                          },
                                  height: 50,
                                  color: const Color.fromARGB(255, 14, 76, 169),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                  child: Center(
                                    child: Text(
                                      "Iniciar como Administrador",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
