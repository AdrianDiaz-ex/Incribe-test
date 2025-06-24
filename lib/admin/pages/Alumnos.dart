import 'package:flutter/material.dart';
import '../../core/app_colors.dart';
import '../../core/text_style.dart';

class DatosAlumnosPage extends StatefulWidget {
  const DatosAlumnosPage({super.key});

  @override
  State<DatosAlumnosPage> createState() => _DatosAlumnosPageState();
}

class _DatosAlumnosPageState extends State<DatosAlumnosPage> {
  final TextEditingController _matriculaController = TextEditingController();

  bool mostrarDatos = false;

  // Datos de ejemplo
  final String nombre = 'Arturo';
  final String apellidoPaterno = 'Alvarado';
  final String apellidoMaterno = 'Dávila';
  final String domicilio = 'Carretera Recursos Hidráulicos S/N';
  final String municipio = 'Capulhuac';
  final String matricula = '202123006';
  final String carrera = 'Ingeniería en Sistemas Computacionales';
  final String grupo = '3802';
  final bool adeudoMedico = false;
  final bool adeudoControlEscolar = true;
  final bool adeudoBiblioteca = true;

  void _buscarAlumno() {
    final buscada = _matriculaController.text.trim();

    if (buscada == matricula) {
      setState(() {
        mostrarDatos = true;
      });
    } else {
      setState(() {
        mostrarDatos = false;
      });

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Matrícula no encontrada')));
    }
  }

  Widget _adeudoTile(String titulo, bool tieneAdeudo) {
    return ListTile(
      leading: Icon(
        tieneAdeudo ? Icons.close : Icons.check_circle,
        color: tieneAdeudo ? Colors.red : Colors.green,
      ),
      title: Text(titulo, style: TextStyles.body),
    );
  }

  Widget _infoTile(String titulo, String valor) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('$titulo: ', style: TextStyles.button),
          Expanded(
            child: Text(
              valor,
              style: TextStyles.bodySecondary,
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            // 🟦 Búsqueda de alumno
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.containerBackground,
                borderRadius: BorderRadius.circular(16),
                boxShadow: const [
                  BoxShadow(color: Colors.black12, blurRadius: 4),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(Icons.person, color: IconColors.primary, size: 40),
                  Divider(
                    thickness: 1,
                    color: const Color.fromARGB(255, 221, 220, 220),
                  ),
                  Text('Buscar alumno', style: TextStyles.headline1),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _matriculaController,
                          decoration: InputDecoration(
                            hintText: 'Matrícula',
                            prefixIcon: const Icon(Icons.search),
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
                        ),
                      ),
                      const SizedBox(width: 10),
                      ElevatedButton(
                        onPressed: _buscarAlumno,
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

            if (mostrarDatos) ...[
              const SizedBox(height: 15),

              // 🟩 Información personal
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.containerBackground,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: const [
                    BoxShadow(color: Colors.black12, blurRadius: 4),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: const [
                        Icon(Icons.person, color: IconColors.primary),
                        SizedBox(width: 8),
                        Text(
                          'INFORMACIÓN PERSONAL',
                          style: TextStyles.sectionTitle,
                        ),
                      ],
                    ),
                    const Divider(thickness: 1),
                    _infoTile('Nombre', nombre),
                    _infoTile('Apellido Paterno', apellidoPaterno),
                    _infoTile('Apellido Materno', apellidoMaterno),
                    _infoTile('Domicilio', domicilio),
                    _infoTile('Municipio', municipio),
                    _infoTile('Matrícula', matricula),
                    _infoTile('Carrera', carrera),
                    _infoTile('Grupo', grupo),
                  ],
                ),
              ),

              const SizedBox(height: 15),

              // 🔴 Adeudos
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.containerBackground,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: const [
                    BoxShadow(color: Colors.black12, blurRadius: 4),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: const [
                        Icon(Icons.warning, color: Colors.orange),
                        SizedBox(width: 4),
                        Text('ADEUDOS', style: TextStyles.sectionTitle),
                      ],
                    ),
                    const Divider(thickness: 1),
                    _adeudoTile('Área Médica', adeudoMedico),
                    _adeudoTile('Control Escolar', adeudoControlEscolar),
                    _adeudoTile('Biblioteca', adeudoBiblioteca),
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
