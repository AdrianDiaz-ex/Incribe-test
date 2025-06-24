import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:inscribe_test/core/app_colors.dart';
import 'package:inscribe_test/core/text_style.dart';
import 'package:inscribe_test/usuario/inicio/inforow.dart';

class HistorialPage extends StatefulWidget {
  const HistorialPage({super.key});

  @override
  State<HistorialPage> createState() => _HistorialPageState();
}

class _HistorialPageState extends State<HistorialPage> {
  final TextEditingController _grupoController = TextEditingController();
  String grupoActual = '';
  double promedioGeneral = 85.4;

  final List<MateriaNota> materias = [
    MateriaNota('Modelo y Ciencia de Datos', 88),
    MateriaNota('Inteligencia de Negocios', 90),
    MateriaNota('Taller de Investigacion II', 78),
    MateriaNota('Administracion de Redes', 92),
    MateriaNota('Gestion de Proyectos de Software', 85),
    MateriaNota('Desarrollo de Aplicaciones Moviles', 80),
  ];

  final int adeudoMedico = 5;
  final int adeudoControlEscolar = 3;
  final int adeudoBiblioteca = 7;

  void _buscarGrupo() {
    setState(() {
      grupoActual = _grupoController.text.trim();
    });

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text('Buscando grupo: $grupoActual')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            Container(
              decoration: BoxDecoration(
                color: AppColors.containerBackground,
                borderRadius: BorderRadius.circular(16),
              ),
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  const Icon(Icons.group, color: IconColors.primary, size: 30),
                  Text(
                    "Buscar por grupo".toUpperCase(),
                    style: TextStyles.sectionTitle,
                  ),
                  const Divider(thickness: 1, color: Colors.grey),
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _grupoController,
                          decoration: const InputDecoration(
                            labelText: 'Grupo',
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.search),
                            prefixIconColor: IconColors.primary,
                            suffixIconColor: Colors.white,
                            focusColor: Colors.white,
                            labelStyle: TextStyles.body,
                            fillColor: AppColors.textSecondary,
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      ElevatedButton(
                        onPressed: _buscarGrupo,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(
                            0xFF476723,
                          ), // Color de fondo
                          foregroundColor: Colors.white, // Color del texto
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 14,
                          ),
                        ),
                        child: const Text('Buscar'),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            if (grupoActual.isNotEmpty) ...[
              Container(
                decoration: BoxDecoration(
                  color: AppColors.containerBackground,
                  borderRadius: BorderRadius.circular(16),
                ),
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Icon(Icons.bar_chart, color: IconColors.primary),
                    Text(
                      "Estadísticas del grupo".toUpperCase(),
                      style: TextStyles.sectionTitle,
                    ),
                    const Divider(thickness: 1, color: Colors.grey),
                    const SizedBox(height: 10),
                    Text(
                      'Promedio General: ${promedioGeneral.toStringAsFixed(2)}',
                      style: TextStyles.headline2,
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      height: 250,
                      child: BarChart(
                        BarChartData(
                          alignment: BarChartAlignment.spaceAround,
                          maxY: 100,
                          titlesData: FlTitlesData(
                            leftTitles: AxisTitles(
                              sideTitles: SideTitles(
                                showTitles: true,
                                getTitlesWidget:
                                    (value, meta) => Text(
                                      value.toInt().toString(),
                                      style: const TextStyle(fontSize: 10),
                                    ),
                              ),
                            ),
                            bottomTitles: AxisTitles(
                              sideTitles: SideTitles(
                                showTitles: true,
                                getTitlesWidget: (value, meta) {
                                  final i = value.toInt();
                                  if (i < materias.length) {
                                    return Padding(
                                      padding: const EdgeInsets.only(top: 8.0),
                                      child: Text(
                                        materias[i].nombre.split(' ')[0],
                                        style: const TextStyle(fontSize: 10),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    );
                                  }
                                  return const SizedBox();
                                },
                              ),
                            ),
                            topTitles: AxisTitles(
                              sideTitles: SideTitles(showTitles: false),
                            ),
                            rightTitles: AxisTitles(
                              sideTitles: SideTitles(showTitles: false),
                            ),
                          ),
                          barGroups: List.generate(
                            materias.length,
                            (index) => BarChartGroupData(
                              x: index,
                              barRods: [
                                BarChartRodData(
                                  toY: materias[index].nota.toDouble(),
                                  color: IconColors.primary,
                                  width: 16,
                                  borderRadius: BorderRadius.circular(4),
                                ),
                              ],
                            ),
                          ),
                          gridData: FlGridData(show: true),
                          borderData: FlBorderData(show: false),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),
              Container(
                decoration: BoxDecoration(
                  color: AppColors.containerBackground,
                  borderRadius: BorderRadius.circular(16),
                ),
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    const Icon(Icons.report, color: IconColors.primary),
                    Text(
                      "Adeudos del grupo".toUpperCase(),
                      style: TextStyles.sectionTitle,
                    ),
                    const Divider(thickness: 1, color: Colors.grey),
                    InfoRow(
                      icon: Icons.medical_services,
                      label: "Área Médica",
                      value: adeudoMedico.toString(),
                    ),
                    SizedBox(height: 10),
                    InfoRow(
                      icon: Icons.school,
                      label: "Control Escolar",
                      value: adeudoControlEscolar.toString(),
                    ),
                    SizedBox(height: 10),
                    InfoRow(
                      icon: Icons.library_books,
                      label: "Biblioteca",
                      value: adeudoBiblioteca.toString(),
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class MateriaNota {
  final String nombre;
  final int nota;
  MateriaNota(this.nombre, this.nota);
}
