import 'package:flutter/material.dart';

class HorarioPage extends StatelessWidget {
  const HorarioPage({super.key});

  // Lista simulada de materias
  final List<Map<String, dynamic>> clases = const [
    {
      'materia': 'Matemáticas',
      'dias': 'Lunes y Miércoles',
      'hora': '8:00 AM a 9:30 AM',
      'icono': Icons.menu_book,
    },
    {
      'materia': 'Programación',
      'dias': 'Martes y Jueves',
      'hora': '10:00 AM a 11:30 AM',
      'icono': Icons.computer,
    },
    {
      'materia': 'Física',
      'dias': 'Viernes',
      'hora': '9:00 AM a 11:00 AM',
      'icono': Icons.science,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1C1C1E),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 40),
            const Text(
              'Mi Horario',
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: clases.length,
                itemBuilder: (context, index) {
                  final clase = clases[index];
                  return Container(
                    margin: const EdgeInsets.only(bottom: 16),
                    decoration: BoxDecoration(
                      color: const Color(0xFF2C2C2E),
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 6,
                          offset: const Offset(2, 4),
                        ),
                      ],
                    ),
                    child: ListTile(
                      leading: Icon(
                        clase['icono'],
                        color: Colors.lightGreenAccent,
                      ),
                      title: Text(
                        clase['materia'],
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                      subtitle: Text(
                        '${clase['dias']} - ${clase['hora']}',
                        style: const TextStyle(color: Colors.white70),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
