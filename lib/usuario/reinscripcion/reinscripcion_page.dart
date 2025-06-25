import 'package:flutter/material.dart';
import 'package:inscribe_test/core/app_colors.dart';
import 'actualizar_datos.dart';
import 'crear_horario.dart';
import 'pago.dart';
import 'descargar_boleta.dart';
import '../../global.dart';

class ReinscripcionPage extends StatelessWidget {
  const ReinscripcionPage({super.key});

  Widget _buildStepCard({
    required IconData icon,
    required String title,
    required String description,
    required VoidCallback onTap,
    required bool enabled,
  }) {
    return Card(
      color:
          enabled
              ? const Color.fromARGB(255, 27, 27, 27)
              : const Color.fromARGB(255, 50, 50, 50),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.greenAccent.shade100.withOpacity(0.2),
          child: Icon(icon, color: enabled ? IconColors.primary : Colors.grey),
        ),
        title: Text(
          title,
          style: TextStyle(
            color: enabled ? Colors.white : Colors.white38,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(
          description,
          style: TextStyle(color: enabled ? Colors.white70 : Colors.white30),
        ),
        trailing: Icon(
          Icons.arrow_forward_ios,
          color: enabled ? Colors.white54 : Colors.white24,
          size: 16,
        ),
        onTap: enabled ? onTap : null,
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
            enabled: true, // Siempre disponible
            onTap: () async {
              final result = await Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const ActualizarDatos()),
              );
              if (result == true) {
                ReinscripcionStatus.datosActualizados = true;
                (context as Element).markNeedsBuild();
              }

              (context as Element).markNeedsBuild();
            },
          ),
          _buildStepCard(
            icon: Icons.download,
            title: '2. Descarga de boleta',
            description: 'Descarga la boleta del último semestre cursado.',
            enabled: ReinscripcionStatus.datosActualizados,
            onTap: () async {
              final result = await Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const DescargarBoleta()),
              );
              if (result == true) {
                ReinscripcionStatus.boletaDescargada = true;
                (context as Element).markNeedsBuild();
              }

              (context as Element).markNeedsBuild();
            },
          ),
          _buildStepCard(
            icon: Icons.picture_as_pdf,
            title: '3. Subir comprobante de pago',
            description: 'Escanea y sube el recibo de pago de reinscripción.',
            enabled: ReinscripcionStatus.boletaDescargada,
            onTap: () async {
              final result = await Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const EscaneoPagoPage()),
              );
              if (result == true) {
                ReinscripcionStatus.pagoSubido = true;
                (context as Element).markNeedsBuild();
              }
            },
          ),
          _buildStepCard(
            icon: Icons.schedule,
            title: '4. Crear nuevo horario',
            description: 'Selecciona tus materias y arma tu horario.',
            enabled: ReinscripcionStatus.pagoSubido,
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
