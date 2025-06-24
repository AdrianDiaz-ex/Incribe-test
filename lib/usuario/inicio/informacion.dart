import 'package:flutter/material.dart';
import 'package:inscribe_test/core/app_colors.dart';
import 'package:inscribe_test/core/text_style.dart';
import 'inforow.dart';
import '../../global.dart';

class Informacion extends StatefulWidget {
  const Informacion({super.key});

  @override
  State<Informacion> createState() => _InformacionState();
}

class _InformacionState extends State<Informacion> {
  @override
  Widget build(BuildContext context) {
    final alumno = Global().alumno;
    final datos = Global().datos;

    final nombre = datos?['nombre'];
    final apellido = datos?['apellido'];
    final correo = alumno?['user'];
    final matricula = datos?['matricula'];
    return Padding(
      padding: const EdgeInsets.only(left: 20, top: 15, right: 20, bottom: 1),
      child: Column(
        children: [
          // Estado Actual
          Container(
            width: double.infinity, // Expande al máximo ancho disponible
            decoration: BoxDecoration(
              color: AppColors.containerBackground,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Icon(Icons.assignment_turned_in, color: IconColors.primary),
                  Text(
                    "Estado Actual".toUpperCase(),
                    style: TextStyles.sectionTitle,
                  ),
                  Divider(
                    // ignore: deprecated_member_use
                    color: const Color(0xB5E7E6E6).withOpacity(0.4),
                    thickness: 1,
                    indent: 2,
                    endIndent: 15,
                  ),

                  //Grupo
                  InfoRow(
                    icon: Icons.person,
                    label: "Grupo",
                    value: "SIN ASIGNAR",
                  ),
                  SizedBox(height: 12),
                  InfoRow(
                    icon: Icons.school,
                    label: "Reinscripcion",
                    value: "Pendiente",
                  ),
                  SizedBox(height: 12),
                  InfoRow(
                    icon: Icons.show_chart,
                    label: "Semestre",
                    value: "Pendiente",
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 15),
          // Información Académica
          Container(
            width: double.infinity, // Expande al máximo ancho disponible
            decoration: BoxDecoration(
              color: AppColors.containerBackground,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Icon(Icons.school, color: IconColors.primary),
                  Text(
                    "Informacion academica".toUpperCase(),
                    style: TextStyles.sectionTitle,
                  ),
                  Divider(
                    // ignore: deprecated_member_use
                    color: AppColors.textSecondary.withOpacity(0.4),
                    thickness: 1,
                    indent: 2,
                    endIndent: 15,
                  ),
                  SizedBox(height: 12),
                  InfoRow(
                    icon: Icons.credit_score_outlined,
                    label: "Matricula",
                    value: (matricula.toString()),
                  ),
                  SizedBox(height: 12),
                  InfoRow(
                    icon: Icons.school,
                    label: "Carrera",
                    value: "Ingenieria en sistemas",
                  ),
                  SizedBox(height: 12),
                  InfoRow(icon: Icons.star, label: "Promedio", value: "85.5"),
                  SizedBox(height: 12),
                  InfoRow(
                    icon: Icons.check_circle,
                    label: "Estatus",
                    value: "Regular",
                  ),
                  SizedBox(height: 12),
                  InfoRow(
                    icon: Icons.credit_score_outlined,
                    label: "Creditos",
                    value: "280/340",
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
