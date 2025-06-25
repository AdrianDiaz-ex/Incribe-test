import 'package:flutter/material.dart';
import 'package:inscribe_test/usuario/reinscripcion/crear_horario.dart'; // Asegúrate que esta sea la ruta correcta

class HorarioPage extends StatelessWidget {
  final List<Horario> clases;

  const HorarioPage({super.key, required this.clases});

  @override
  Widget build(BuildContext context) {
    final Map<String, List<Horario>> clasesAgrupadas = {};

    // Agrupar por materia
    for (var clase in clases) {
      clasesAgrupadas.putIfAbsent(clase.materia, () => []).add(clase);
    }

    return Scaffold(
      backgroundColor: const Color(0xFF1C1C1E),
      body:
          clases.isEmpty
              ? Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      Icon(
                        Icons.info_outline,
                        size: 64,
                        color: Colors.lightGreenAccent,
                      ),
                      SizedBox(height: 16),
                      Text(
                        "Tu horario está vacío.\nCompleta la reinscripción para habilitar tu horario.",
                        style: TextStyle(
                          color: Colors.lightGreenAccent,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          shadows: [
                            Shadow(
                              offset: Offset(1, 1),
                              blurRadius: 3,
                              color: Colors.black54,
                            ),
                          ],
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              )
              : Padding(
                padding: const EdgeInsets.all(16.0),
                child: ListView(
                  children:
                      clasesAgrupadas.entries.map((entry) {
                        final materia = entry.key;
                        final sesiones = entry.value;

                        // Combinar sesiones (día - hora)
                        final sesionesTexto = sesiones
                            .map((e) => '${e.dia} - ${e.hora}')
                            .join('\n');

                        final grupo = sesiones.first.grupo;
                        final creditos = sesiones.first.creditos;

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
                            leading: const Icon(
                              Icons.menu_book,
                              color: Colors.lightGreenAccent,
                            ),
                            title: Text(
                              materia,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: Colors.white,
                              ),
                            ),
                            subtitle: Text(
                              '$sesionesTexto\nGrupo: $grupo | Créditos: $creditos',
                              style: const TextStyle(color: Colors.white70),
                            ),
                          ),
                        );
                      }).toList(),
                ),
              ),
    );
  }
}
