import 'package:flutter/material.dart';
import '../../core/app_colors.dart';
import '../../core/text_style.dart';

class HorarioPage extends StatefulWidget {
  const HorarioPage({super.key});

  @override
  State<HorarioPage> createState() => _HorarioPageState();
}

class _HorarioPageState extends State<HorarioPage> {
  final TextEditingController _busquedaController = TextEditingController();
  String? maestroSeleccionado;

  final List<String> maestros = [
    'Genaro Chavez',
    'Brenda Sunuami',
    'Jorge Landa',
  ];

  final Map<String, Map<String, dynamic>> datosMaestros = {
    'Genaro Chavez': {
      'horario': {'Lunes': '5:00 - 8:00', 'Miércoles': '6:00 - 8:00'},
      'materias': ['Desarrollo de Aplicaciones Moviles', 'Sistemas Operativos'],
      'aprobados': 80,
      'reprobados': 20,
    },
    'Brenda Sunuami': {
      'horario': {'Lunes': '2:00 - 4:00', 'Martes': '4:00 - 6:00'},
      'materias': ['Modelo y Ciencia de Datos', 'Bases de Datos'],
      'aprobados': 92,
      'reprobados': 8,
    },
    'Jorge Landa': {
      'horario': {'Miercoles': '2:00 - 5:00', 'Jueves': '6:00 - 8:00'},
      'materias': ['Inteligencia de Negocios', 'Administracion de Redes'],
      'aprobados': 70,
      'reprobados': 30,
    },
  };

  List<String> _filtrarMaestros(String query) {
    return maestros
        .where((m) => m.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final maestrosFiltrados = _filtrarMaestros(_busquedaController.text);

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
                boxShadow: const [
                  BoxShadow(color: Colors.black26, blurRadius: 4),
                ],
              ),
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(Icons.group, size: 30, color: IconColors.primary),
                  Text(
                    "FILTRAR POR MAESTRO".toUpperCase(),
                    style: TextStyles.headline2,
                  ),
                  Divider(
                    // ignore: deprecated_member_use
                    color: const Color(0xB5E7E6E6).withOpacity(0.4),
                    thickness: 1,
                    indent: 2,
                    endIndent: 15,
                  ),

                  TextField(
                    controller: _busquedaController,
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      hintText: 'Buscar maestro...',
                      hintStyle: const TextStyle(
                        color: Color.fromARGB(255, 254, 254, 254),
                      ),
                      hoverColor: Colors.white,
                      focusColor: Colors.white,
                      suffixIconColor: Colors.white,

                      prefixIcon: const Icon(
                        Icons.search,
                        color: IconColors.primary,
                      ),
                      filled: true,
                      fillColor: AppColors.textSecondary,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    onChanged: (_) => setState(() {}),
                  ),
                  const SizedBox(height: 12),

                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        isExpanded: true,
                        dropdownColor: AppColors.containerBackground,
                        value: maestroSeleccionado,
                        icon: const Icon(
                          Icons.arrow_drop_down,
                          color: IconColors.primary,
                        ),
                        hint: const Text(
                          'Selecciona un maestro',
                          style: TextStyle(color: Colors.white),
                        ),
                        style: const TextStyle(color: Colors.white),
                        items:
                            _filtrarMaestros(_busquedaController.text).map((
                              maestro,
                            ) {
                              return DropdownMenuItem(
                                value: maestro,
                                child: Text(
                                  maestro,
                                  style: const TextStyle(color: Colors.white),
                                ),
                              );
                            }).toList(),
                        onChanged: (value) {
                          setState(() {
                            maestroSeleccionado = value;
                          });
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            if (maestroSeleccionado != null)
              _mostrarInfoMaestro(maestroSeleccionado!),
          ],
        ),
      ),
    );
  }

  Widget _mostrarInfoMaestro(String maestro) {
    final datos = datosMaestros[maestro]!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSection(
          title: 'Horario de Clases',
          icon: Icons.access_time,
          color: IconColors.primary,
          children:
              datos['horario'].entries.map<Widget>((e) {
                return ListTile(
                  leading: const Icon(
                    Icons.calendar_today,
                    color: IconColors.primary,
                  ),
                  title: Text('${e.key}: ${e.value}', style: TextStyles.body),
                );
              }).toList(),
        ),
        const SizedBox(height: 20),
        _buildSection(
          title: 'Materias Asignadas',
          icon: Icons.menu_book,
          color: IconColors.primary,
          children:
              (datos['materias'] as List<String>).map<Widget>((m) {
                return ListTile(
                  leading: const Icon(Icons.book, color: IconColors.primary),
                  title: Text(m, style: TextStyles.body),
                );
              }).toList(),
        ),
        const SizedBox(height: 20),
        _buildSection(
          title: 'Desempeño del Grupo',
          icon: Icons.bar_chart,
          color: IconColors.primary,
          children: [
            ListTile(
              leading: const Icon(Icons.check_circle, color: Colors.green),
              title: const Text('Aprobados', style: TextStyles.body),
              trailing: Text('${datos['aprobados']}%', style: TextStyles.body),
            ),
            ListTile(
              leading: const Icon(Icons.cancel, color: Colors.red),
              title: const Text('Reprobados', style: TextStyles.body),
              trailing: Text('${datos['reprobados']}%', style: TextStyles.body),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSection({
    required String title,
    required IconData icon,
    required Color color,
    required List<Widget> children,
  }) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.containerBackground,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 4)],
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: color),
              const SizedBox(width: 10),
              Text(
                title.toUpperCase(),
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          const Divider(thickness: 1),
          ...children,
        ],
      ),
    );
  }
}
