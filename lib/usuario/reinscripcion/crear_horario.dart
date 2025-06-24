import 'package:flutter/material.dart';
import 'package:inscribe_test/core/app_colors.dart';
import 'package:inscribe_test/core/text_style.dart';

class Horario {
  final String grupo;
  final String materia;
  final String dia;
  final String hora;
  final String docente;

  Horario({
    required this.grupo,
    required this.materia,
    required this.dia,
    required this.hora,
    required this.docente,
  });

  // No usamos fromJson porque los datos son estáticos, pero podrías usarlo igual
}

class CrearHorario extends StatefulWidget {
  const CrearHorario({super.key});

  @override
  State<CrearHorario> createState() => _CrearHorarioState();
}

class _CrearHorarioState extends State<CrearHorario> {
  final List<String> grupos = ['3801', '3802'];
  String? grupoSeleccionado;

  // Datos estáticos simulando respuesta JSON
  final List<Horario> horarios = [
    Horario(
      grupo: '3801',
      materia: 'Cálculo',
      dia: 'Lunes',
      hora: '08:00 - 10:00',
      docente: 'Dr. Gómez',
    ),
    Horario(
      grupo: '3801',
      materia: 'Programación',
      dia: 'Martes',
      hora: '10:00 - 12:00',
      docente: 'Ing. Rivera',
    ),
    Horario(
      grupo: '3801',
      materia: 'Ética',
      dia: 'Miércoles',
      hora: '12:00 - 14:00',
      docente: 'Mtra. López',
    ),
    Horario(
      grupo: '3802',
      materia: 'Álgebra',
      dia: 'Lunes',
      hora: '08:00 - 10:00',
      docente: 'Dr. Romero',
    ),
    Horario(
      grupo: '3802',
      materia: 'Contabilidad',
      dia: 'Martes',
      hora: '10:00 - 12:00',
      docente: 'Lic. Pérez',
    ),
    Horario(
      grupo: '3802',
      materia: 'Redes',
      dia: 'Miércoles',
      hora: '12:00 - 14:00',
      docente: 'Ing. Torres',
    ),
  ];

  List<String> materiasSeleccionadas = [];

  void seleccionarGrupo(String grupo) {
    setState(() {
      grupoSeleccionado = grupo;
      materiasSeleccionadas.clear();
    });
  }

  void toggleMateria(String materia) {
    setState(() {
      if (materiasSeleccionadas.contains(materia)) {
        materiasSeleccionadas.remove(materia);
      } else {
        materiasSeleccionadas.add(materia);
      }
    });
  }

  void continuar() {
    if (grupoSeleccionado == null || materiasSeleccionadas.isEmpty) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Horario creado: Grupo $grupoSeleccionado, Materias: ${materiasSeleccionadas.join(', ')}',
        ),
        backgroundColor: Colors.green.shade800,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final materiasDelGrupo =
        grupoSeleccionado != null
            ? horarios.where((h) => h.grupo == grupoSeleccionado).toList()
            : [];

    return Scaffold(
      backgroundColor: const Color(0xFF141414),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [AppColors.background, AppColors.containerBackground],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: const Text(
              'Crear Horario',
              style: TextStyle(color: Colors.white),
            ),
            centerTitle: true,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Selección de grupo
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: AppColors.containerBackground,
                  borderRadius: BorderRadius.circular(16),
                ),
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    const Icon(Icons.groups, color: IconColors.primary),
                    Text(
                      "Selecciona tu grupo".toUpperCase(),
                      style: TextStyles.sectionTitle,
                    ),
                    Divider(
                      color: AppColors.textSecondary.withOpacity(0.4),
                      thickness: 1,
                    ),
                    const SizedBox(height: 10),
                    ...grupos.map((grupo) {
                      final seleccionado = grupo == grupoSeleccionado;
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 6),
                        child: Container(
                          decoration: BoxDecoration(
                            color: const Color(0xFF1E1E1E),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color:
                                  seleccionado
                                      ? Colors.greenAccent
                                      : Colors.grey.shade700,
                              width: 1.2,
                            ),
                          ),
                          child: ListTile(
                            leading: Icon(
                              Icons.class_,
                              color:
                                  seleccionado
                                      ? Colors.greenAccent
                                      : Colors.white70,
                            ),
                            title: Text(
                              'Grupo $grupo',
                              style: const TextStyle(color: Colors.white),
                            ),
                            trailing:
                                seleccionado
                                    ? const Icon(
                                      Icons.check_circle,
                                      color: Colors.greenAccent,
                                    )
                                    : ElevatedButton(
                                      onPressed: () => seleccionarGrupo(grupo),
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.green.shade600,
                                      ),
                                      child: const Text('Seleccionar'),
                                    ),
                          ),
                        ),
                      );
                    }).toList(),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Lista de materias
              if (grupoSeleccionado != null)
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: AppColors.containerBackground,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      const Icon(Icons.book, color: IconColors.primary),
                      Text(
                        "Selecciona tus materias".toUpperCase(),
                        style: TextStyles.sectionTitle,
                      ),
                      Divider(
                        color: AppColors.textSecondary.withOpacity(0.4),
                        thickness: 1,
                      ),
                      const SizedBox(height: 10),
                      ...materiasDelGrupo.map((materia) {
                        final seleccionada = materiasSeleccionadas.contains(
                          materia.materia,
                        );
                        return Container(
                          margin: const EdgeInsets.symmetric(vertical: 6),
                          decoration: BoxDecoration(
                            color: const Color(0xFF1E1E1E),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color:
                                  seleccionada
                                      ? Colors.greenAccent
                                      : Colors.grey.shade700,
                              width: 1.2,
                            ),
                          ),
                          child: ListTile(
                            leading: Icon(
                              Icons.book_outlined,
                              color:
                                  seleccionada
                                      ? Colors.greenAccent
                                      : Colors.white70,
                            ),
                            title: Text(
                              materia.materia,
                              style: TextStyle(
                                color:
                                    seleccionada
                                        ? Colors.greenAccent
                                        : Colors.white,
                                fontWeight:
                                    seleccionada
                                        ? FontWeight.bold
                                        : FontWeight.normal,
                              ),
                            ),
                            subtitle: Text(
                              '${materia.dia} | ${materia.hora}\nDocente: ${materia.docente}',
                              style: const TextStyle(
                                color: Colors.white54,
                                fontSize: 12,
                              ),
                            ),
                            isThreeLine: true,
                            trailing: Checkbox(
                              value: seleccionada,
                              onChanged: (_) => toggleMateria(materia.materia),
                              activeColor: Colors.greenAccent,
                            ),
                          ),
                        );
                      }).toList(),
                      const SizedBox(height: 12),
                      if (materiasSeleccionadas.isNotEmpty)
                        ElevatedButton.icon(
                          onPressed: continuar,
                          icon: const Icon(Icons.check),
                          label: const Text("Confirmar Horario"),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green.shade700,
                            foregroundColor: Colors.white,
                            minimumSize: const Size.fromHeight(45),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
