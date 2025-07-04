import 'package:flutter/material.dart';
import 'package:inscribe_test/core/app_colors.dart';
import 'pages/inicio_page.dart';
import 'pages/Maestros.dart';
import 'pages/Grupos.dart';
import 'pages/Alumnos.dart';
import '../main.dart';
import '../core/app_colors.dart';
import 'pages/informes.dart';

class AdminInicio extends StatelessWidget {
  const AdminInicio({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: BottomNavigationBarExample(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class BottomNavigationBarExample extends StatefulWidget {
  const BottomNavigationBarExample({super.key});

  @override
  State<BottomNavigationBarExample> createState() =>
      _BottomNavigationBarExampleState();
}

class _BottomNavigationBarExampleState
    extends State<BottomNavigationBarExample> {
  int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = <Widget>[
    InicioPage(),
    HorarioPage(),
    HistorialPage(),
    DatosAlumnosPage(),
    EstadisticasPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _logout() {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Cerrar sesión'),
            content: const Text('¿Estás seguro de que deseas cerrar sesión?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Cancelar'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => const MyApp()),
                    (Route<dynamic> route) => false,
                  );
                },
                child: const Text('Cerrar sesión'),
              ),
            ],
          ),
    );
  }

  final List<String> _titles = [
    'INICIO',
    'MAESTROS',
    'GRUPOS',
    'ALUMNOS',
    'INFORMES',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50.0),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [AppColors.background, AppColors.containerBackground],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
          ),
          child: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            centerTitle: true,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.school, color: Colors.white, size: 26),
                const SizedBox(width: 25),
                Text(
                  _titles[_selectedIndex],
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    letterSpacing: 1.2,
                  ),
                ),
              ],
            ),
            iconTheme: const IconThemeData(color: Colors.white),
            actions: [
              IconButton(
                icon: const Icon(Icons.logout, size: 26),
                tooltip: 'Cerrar sesión',
                onPressed: _logout,
              ),
            ],
          ),
        ),
      ),

      body: SafeArea(child: _widgetOptions[_selectedIndex]),

      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [AppColors.background, AppColors.containerBackground],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Inicio'),
            BottomNavigationBarItem(
              icon: Icon(Icons.calendar_month_outlined),
              label: 'Maestros',
            ),
            BottomNavigationBarItem(icon: Icon(Icons.history), label: 'Grupos'),
            BottomNavigationBarItem(
              icon: Icon(Icons.receipt_long_outlined),
              label: 'Alumno',
            ),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Informe'),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor:
              IconColors.primary, // Cambia a tu IconColors.primary si lo tienes
          unselectedItemColor: Colors.white,
          onTap: _onItemTapped,
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.transparent,
        ),
      ),
    );
  }
}
