import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class DescargarBoleta extends StatelessWidget {
  const DescargarBoleta({super.key});

  final List<Map<String, dynamic>> _boleta = const [
    {'nombre': 'Cálculo Diferencial', 'calificacion': 73.20, 'creditos': 5},
    {
      'nombre': 'Fundamentos de Programación',
      'calificacion': 76.40,
      'creditos': 5,
    },
    {'nombre': 'Taller de Ética', 'calificacion': 78.00, 'creditos': 4},
    {'nombre': 'Matemáticas Discretas', 'calificacion': 71.80, 'creditos': 3},
    {
      'nombre': 'Taller de Administración',
      'calificacion': 90.20,
      'creditos': 4,
    },
    {'nombre': 'Álgebra Lineal', 'calificacion': 87.30, 'creditos': 3},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 20, 20, 20),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Boleta de Calificaciones',
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            color: const Color.fromARGB(255, 27, 27, 27),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children:
                    _boleta.map((materia) {
                      final color =
                          (materia['calificacion'] as double) >= 70
                              ? Colors.greenAccent
                              : Colors.redAccent;
                      return ListTile(
                        title: Text(
                          materia['nombre'],
                          style: const TextStyle(color: Colors.white),
                        ),
                        subtitle: Text(
                          'Créditos: ${materia['creditos']}',
                          style: const TextStyle(
                            color: Colors.white70,
                            fontSize: 12,
                          ),
                        ),
                        trailing: Text(
                          materia['calificacion'].toStringAsFixed(2),
                          style: TextStyle(
                            color: color,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      );
                    }).toList(),
              ),
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.greenAccent.shade400,
              foregroundColor: Colors.black,
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            onPressed: () async {
              final url = Uri.parse('http://192.168.0.6:5000/boleta/1');

              if (await canLaunchUrl(url)) {
                await launchUrl(
                  url,
                  mode:
                      LaunchMode
                          .platformDefault, // asegura que use el navegador
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('No hay navegador disponible')),
                );
              }
            },
            icon: const Icon(Icons.download),
            label: const Text(
              'Descargar Boleta (PDF)',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
