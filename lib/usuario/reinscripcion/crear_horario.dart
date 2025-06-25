import 'package:flutter/material.dart';
import 'package:inscribe_test/core/app_colors.dart';
import 'package:inscribe_test/core/text_style.dart';
import '../../global.dart';

class CrearHorario extends StatefulWidget {
  const CrearHorario({super.key});

  @override
  State<CrearHorario> createState() => _CrearHorarioState();
}

class Horario {
  final String grupo;
  final String materia;
  final int creditos;
  final int semestre;
  final String dia;
  final String hora;

  Horario({
    required this.grupo,
    required this.materia,
    required this.creditos,
    required this.semestre,
    required this.dia,
    required this.hora,
  });

  factory Horario.fromJson(Map<String, dynamic> json) {
    final horaInicio = json['hora_inicio'] ?? '';
    final horaFin = json['hora_fin'] ?? '';
    return Horario(
      grupo: json['grupo'] ?? '',
      materia: json['nombre'] ?? '',
      creditos: json['creaditos'] ?? 0,
      semestre: json['semestre'] ?? 0,
      dia: json['dia'] ?? '',
      hora: '$horaInicio - $horaFin',
    );
  }
}

class MateriaAgrupada {
  final String grupo;
  final String materia;
  final int creditos;
  final int semestre;
  final List<Horario> sesiones;

  MateriaAgrupada({
    required this.grupo,
    required this.materia,
    required this.creditos,
    required this.semestre,
    required this.sesiones,
  });
}

class _CrearHorarioState extends State<CrearHorario> {
  final List<Horario> horarios =
      (Global().horarios_faltantes ?? [])
          .map<Horario>((h) => Horario.fromJson(h))
          .toList();

  Set<String> gruposSeleccionados = {};
  List<String> materiasSeleccionadas = []; // "3901|Internet de las cosas"

  void toggleGrupo(String grupo) {
    setState(() {
      if (gruposSeleccionados.contains(grupo)) {
        gruposSeleccionados.remove(grupo);
        materiasSeleccionadas.removeWhere((id) => id.startsWith("$grupo|"));
      } else {
        gruposSeleccionados.add(grupo);
      }
    });
  }

  void intentarSeleccionarMateria(MateriaAgrupada nueva) {
    final nuevasSesiones = nueva.sesiones;

    final sesionesSeleccionadas =
        horarios
            .where(
              (h) => materiasSeleccionadas.contains("${h.grupo}|${h.materia}"),
            )
            .toList();

    for (var ns in nuevasSesiones) {
      for (var ss in sesionesSeleccionadas) {
        if (ns.dia == ss.dia && _horasEmpalmadas(ns.hora, ss.hora)) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("¡Hay un empalme de horario!"),
              backgroundColor: Colors.redAccent,
            ),
          );
          return;
        }
      }
    }

    final id = "${nueva.grupo}|${nueva.materia}";
    setState(() {
      if (materiasSeleccionadas.contains(id)) {
        materiasSeleccionadas.remove(id);
      } else {
        materiasSeleccionadas.add(id);
      }
    });
  }

  bool _horasEmpalmadas(String rango1, String rango2) {
    final parts1 = rango1.split(' - ');
    final parts2 = rango2.split(' - ');

    final inicio1 = _horaToInt(parts1[0]);
    final fin1 = _horaToInt(parts1[1]);
    final inicio2 = _horaToInt(parts2[0]);
    final fin2 = _horaToInt(parts2[1]);

    return (inicio1 < fin2) && (inicio2 < fin1);
  }

  int _horaToInt(String hora) {
    final partes = hora.split(':');
    return int.parse(partes[0]) * 60 + int.parse(partes[1]);
  }

  List<MateriaAgrupada> agruparMaterias(List<Horario> materiasDelGrupo) {
    final Map<String, MateriaAgrupada> agrupadas = {};

    for (var h in materiasDelGrupo) {
      final key = "${h.grupo}|${h.materia}";
      if (!agrupadas.containsKey(key)) {
        agrupadas[key] = MateriaAgrupada(
          grupo: h.grupo,
          materia: h.materia,
          creditos: h.creditos,
          semestre: h.semestre,
          sesiones: [],
        );
      }
      agrupadas[key]!.sesiones.add(h);
    }

    return agrupadas.values.toList();
  }

  void continuar() {
    if (gruposSeleccionados.isEmpty || materiasSeleccionadas.isEmpty) return;

    final confirmados =
        horarios
            .where(
              (h) => materiasSeleccionadas.contains("${h.grupo}|${h.materia}"),
            )
            .toList();

    if (confirmados.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("No hay materias seleccionadas para guardar."),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    Global().horariosConfirmados = confirmados;

    showDialog(
      context: context,
      builder:
          (contextDialog) => AlertDialog(
            title: const Text("Confirmar Horario"),
            content: Text(
              "Grupos: ${gruposSeleccionados.join(', ')}\n"
              "Materias: ${materiasSeleccionadas.map((e) => e.replaceFirst('|', ' - ')).join(', ')}",
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(contextDialog),
                child: const Text("Cancelar"),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(contextDialog); // Cierra el diálogo

                  // Muestra el SnackBar con un delay en el contexto correcto
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    if (mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Horario confirmado y guardado"),
                          backgroundColor: Colors.green,
                        ),
                      );
                    }
                  });
                },
                child: const Text("Confirmar"),
              ),
            ],
          ),
    );
  }

  Widget _buildMateriaAgrupadaCard(MateriaAgrupada materia) {
    final id = "${materia.grupo}|${materia.materia}";
    final seleccionada = materiasSeleccionadas.contains(id);

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      decoration: BoxDecoration(
        color: const Color(0xFF1E1E1E),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: seleccionada ? Colors.greenAccent : Colors.grey.shade700,
          width: 1.2,
        ),
      ),
      child: ListTile(
        leading: Icon(
          Icons.book_outlined,
          color: seleccionada ? Colors.greenAccent : Colors.white70,
        ),
        title: Text(
          materia.materia,
          style: TextStyle(
            color: seleccionada ? Colors.greenAccent : Colors.white,
            fontWeight: seleccionada ? FontWeight.bold : FontWeight.normal,
          ),
        ),
        subtitle: Text(
          materia.sesiones.map((s) => "${s.dia} ${s.hora}").join(" | "),
          style: const TextStyle(color: Colors.white54, fontSize: 12),
        ),
        isThreeLine: true,
        trailing: Checkbox(
          value: seleccionada,
          onChanged: (_) => intentarSeleccionarMateria(materia),
          activeColor: Colors.greenAccent,
        ),
      ),
    );
  }

  Widget _buildMateriasContainer(List<MateriaAgrupada> materias) {
    final Map<int, List<MateriaAgrupada>> porSemestre = {};
    for (var m in materias) {
      porSemestre.putIfAbsent(m.semestre, () => []).add(m);
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children:
          porSemestre.entries.map((entry) {
            final semestre = entry.key;
            final lista = entry.value;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Text(
                    'Semestre $semestre',
                    style: const TextStyle(
                      color: Colors.greenAccent,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                ...lista.map(_buildMateriaAgrupadaCard).toList(),
              ],
            );
          }).toList(),
    );
  }

  Widget _buildHorarioGeneral(List<Horario> seleccionadas) {
    if (seleccionadas.isEmpty) return const SizedBox();

    // Agrupar por materia
    final Map<String, Map<String, String>> tabla = {}; // materia -> día -> hora

    for (var h in seleccionadas) {
      tabla.putIfAbsent(h.materia, () => {});
      tabla[h.materia]![h.dia] = h.hora;
    }

    final dias = ["Lunes", "Martes", "Miércoles", "Jueves", "Viernes"];

    return Container(
      margin: const EdgeInsets.only(top: 20),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.containerBackground,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: const [
              Icon(Icons.schedule, color: Colors.greenAccent),
              SizedBox(width: 8),
              Text(
                "HORARIO GENERAL",
                style: TextStyle(
                  color: Colors.greenAccent,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const Divider(color: Colors.white24, thickness: 1),
          const SizedBox(height: 6),
          // Encabezado
          Container(
            padding: const EdgeInsets.symmetric(vertical: 6),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(color: Colors.white24.withOpacity(0.3)),
              ),
            ),
            child: Row(
              children: [
                const Expanded(
                  flex: 3,
                  child: Text(
                    "MATERIA",
                    style: TextStyle(
                      color: Colors.white70,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                ...dias
                    .map(
                      (d) => Expanded(
                        flex: 2,
                        child: Text(
                          d.toUpperCase(),
                          style: const TextStyle(
                            color: Colors.white70,
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    )
                    .toList(),
              ],
            ),
          ),
          // Filas
          ...tabla.entries.map((entry) {
            final materia = entry.key;
            final sesiones = entry.value;
            return Container(
              padding: const EdgeInsets.symmetric(vertical: 6),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: Colors.white24.withOpacity(0.2)),
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: Text(
                      materia,
                      style: const TextStyle(
                        color: Colors.greenAccent,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  ...dias
                      .map(
                        (dia) => Expanded(
                          flex: 2,
                          child: Text(
                            sesiones[dia] ?? "",
                            style: const TextStyle(color: Colors.white),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      )
                      .toList(),
                ],
              ),
            );
          }).toList(),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final List<String> grupos =
        horarios.map((h) => h.grupo).toSet().toList()..sort();

    final List<Horario> materiasDelGrupo =
        gruposSeleccionados.isNotEmpty
            ? horarios
                .where((h) => gruposSeleccionados.contains(h.grupo))
                .toList()
            : [];

    final materiasAgrupadas = agruparMaterias(materiasDelGrupo);

    final seleccionadasList =
        horarios
            .where(
              (h) => materiasSeleccionadas.contains("${h.grupo}|${h.materia}"),
            )
            .toList();

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
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: AppColors.containerBackground,
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(Icons.groups, color: IconColors.primary),
                    Text(
                      "Grupos disponibles".toUpperCase(),
                      style: TextStyles.sectionTitle,
                    ),
                    const SizedBox(height: 10),
                    Wrap(
                      spacing: 10,
                      runSpacing: 10,
                      children:
                          grupos.map((grupo) {
                            final seleccionado = gruposSeleccionados.contains(
                              grupo,
                            );
                            return ChoiceChip(
                              label: Text(
                                grupo,
                                style: TextStyle(
                                  color:
                                      seleccionado
                                          ? Colors.black
                                          : Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              selected: seleccionado,
                              selectedColor: Colors.greenAccent,
                              backgroundColor: Colors.grey[800],
                              onSelected: (_) => toggleGrupo(grupo),
                              labelPadding: const EdgeInsets.symmetric(
                                horizontal: 12,
                              ),
                            );
                          }).toList(),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              gruposSeleccionados.isEmpty
                  ? const SizedBox()
                  : Container(
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
                        _buildMateriasContainer(materiasAgrupadas),
                        const SizedBox(height: 12),
                      ],
                    ),
                  ),
              if (materiasSeleccionadas.isNotEmpty)
                _buildHorarioGeneral(seleccionadasList),
            ],
          ),
        ),
      ),
      floatingActionButton:
          materiasSeleccionadas.isNotEmpty
              ? FloatingActionButton.extended(
                onPressed: continuar,
                icon: const Icon(Icons.check),
                label: const Text("Confirmar"),
                backgroundColor: Colors.green.shade700,
              )
              : null,
    );
  }
}
