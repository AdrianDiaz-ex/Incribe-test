import 'package:flutter/material.dart';
import '../../core/app_colors.dart';
import '../../global.dart';

class HistorialPage extends StatelessWidget {
  const HistorialPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<dynamic> historial = Global().historial ?? [];
    // Agrupar materias por semestre
    final Map<int, List<Map<String, dynamic>>> agrupado = {};
    for (var materia in historial) {
      final semestre = materia['semestre'] as int;
      if (!agrupado.containsKey(semestre)) {
        agrupado[semestre] = [];
      }
      agrupado[semestre]!.add(Map<String, dynamic>.from(materia));
    }

    if (historial.isEmpty) {
      return const Center(
        child: Text(
          'No hay datos de historial',
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
      );
    }

    return Container(
      color: const Color.fromARGB(255, 20, 20, 20),
      child: ListView(
        padding: const EdgeInsets.all(16),
        children:
            agrupado.entries.map((entry) {
              final semestre = entry.key;
              final materias = entry.value;

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
                    iconColor: IconColors.primary,
                    title: Text(
                      'Semestre $semestre',
                      style: const TextStyle(
                        color: IconColors.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    children:
                        materias.map((materia) {
                          final calificacion =
                              double.tryParse(
                                materia['calificacion'].toString(),
                              ) ??
                              0.0;
                          final color =
                              calificacion >= 70
                                  ? IconColors.primary
                                  : Colors.redAccent;

                          return ListTile(
                            title: Text(
                              materia['nombre'],
                              style: const TextStyle(color: Colors.white),
                            ),
                            subtitle: Text(
                              'Créditos: ${materia['creaditos']}',
                              style: const TextStyle(
                                color: Colors.white70,
                                fontSize: 12,
                              ),
                            ),
                            trailing: Text(
                              materia['calificacion'].toString(),
                              style: TextStyle(
                                color: color,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          );
                        }).toList(),
                  ),
                ),
              );
            }).toList(),
      ),
    );
  }
}
