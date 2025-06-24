import 'package:flutter/material.dart';
import 'package:inscribe_test/core/app_colors.dart';
import 'actualizar_datos.dart';
import 'crear_horario.dart';
import 'pago.dart';
import 'descargar_boleta.dart';
import '../../global.dart';

// ignore: non_constant_identifier_names

class ReinscripcionPage extends StatelessWidget {
  const ReinscripcionPage({super.key});

  Widget _buildStepCard({
    required IconData icon,
    required String title,
    required String description,
    required VoidCallback onTap,
  }) {
    return Card(
      color: const Color.fromARGB(255, 27, 27, 27),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.greenAccent.shade100.withOpacity(0.2),
          child: Icon(icon, color: IconColors.primary),
        ),
        title: Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(
          description,
          style: const TextStyle(color: Colors.white70),
        ),
        trailing: const Icon(
          Icons.arrow_forward_ios,
          color: Colors.white54,
          size: 16,
        ),
        onTap: onTap,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromARGB(255, 20, 20, 20),
      child: ListView(
        padding: const EdgeInsets.only(top: 20),
        children: [
          _buildStepCard(
            icon: Icons.edit_document,
            title: '1. Actualización de datos',
            description:
                'Verifica y actualiza tus datos personales y académicos.',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const ActualizarDatos()),
              );
            },
          ),
          _buildStepCard(
            icon: Icons.download,
            title: '2. Descarga de boleta',
            description: 'Descarga la boleta del último semestre cursado.',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const DescargarBoleta()),
              );
            },
          ),
          _buildStepCard(
            icon: Icons.picture_as_pdf,
            title: '3. Subir comprobante de pago',
            description: 'Escanea y sube el recibo de pago de reinscripción.',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const EscaneoPagoPage()),
              );
            },
          ),
          _buildStepCard(
            icon: Icons.schedule,
            title: '4. Crear nuevo horario',
            description: 'Selecciona tus materias y arma tu horario.',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const CrearHorario()),
              );
            },
          ),
        ],
      ),
    );
  }
}
