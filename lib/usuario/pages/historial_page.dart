import 'package:flutter/material.dart';

class HistorialPage extends StatelessWidget {
  const HistorialPage({super.key});

  // Simulación de datos
  final List<Map<String, dynamic>> historial = const [
    {
      'semestre': '1er Semestre',
      'materias': [
        {'nombre': 'Matemáticas I', 'calificacion': 85},
        {'nombre': 'Programación I', 'calificacion': 90},
        {'nombre': 'Fundamentos de TIC', 'calificacion': 88},
      ],
    },
    {
      'semestre': '2do Semestre',
      'materias': [
        {'nombre': 'Matemáticas II', 'calificacion': 82},
        {'nombre': 'Programación II', 'calificacion': 89},
        {'nombre': 'Contabilidad', 'calificacion': 91},
      ],
    },
    {
      'semestre': '3er Semestre',
      'materias': [
        {'nombre': 'Estructura de Datos', 'calificacion': 87},
        {'nombre': 'POO', 'calificacion': 90},
        {'nombre': 'Sistemas Operativos', 'calificacion': 84},
      ],
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromARGB(255, 20, 20, 20),
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Center(
            child: Text(
              'Historial Académico',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(height: 20),
          ...historial.map((semestreData) {
            return Card(
              color: const Color.fromARGB(255, 32, 32, 32),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Theme(
                data: Theme.of(context).copyWith(
                  dividerColor: Colors.transparent,
                  unselectedWidgetColor: Colors.white70,
                  textTheme: const TextTheme(
                    bodyMedium: TextStyle(color: Colors.white),
                  ),
                ),
                child: ExpansionTile(
                  collapsedIconColor: Colors.white54,
                  iconColor: Colors.greenAccent,
                  title: Text(
                    semestreData['semestre'],
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  children:
                      (semestreData['materias'] as List)
                          .map<Widget>(
                            (materia) => ListTile(
                              title: Text(
                                materia['nombre'],
                                style: const TextStyle(color: Colors.white),
                              ),
                              trailing: Text(
                                '${materia['calificacion']}',
                                style: const TextStyle(
                                  color: Colors.greenAccent,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          )
                          .toList(),
                ),
              ),
            );
          }).toList(),
        ],
      ),
    );
  }
}
