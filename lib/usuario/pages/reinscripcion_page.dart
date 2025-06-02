import 'package:flutter/material.dart';

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
          child: Icon(icon, color: Colors.greenAccent),
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
          const Center(
            child: Text(
              'Proceso de Reinscripción',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(height: 20),
          _buildStepCard(
            icon: Icons.edit_document,
            title: '1. Actualización de datos',
            description:
                'Verifica y actualiza tus datos personales y académicos.',
            onTap: () {
              // Acción para actualizar datos
            },
          ),
          _buildStepCard(
            icon: Icons.download,
            title: '2. Descarga de boleta',
            description: 'Descarga la boleta del último semestre cursado.',
            onTap: () {
              // Acción para descargar boleta
            },
          ),
          _buildStepCard(
            icon: Icons.picture_as_pdf,
            title: '3. Subir comprobante de pago',
            description: 'Escanea y sube el recibo de pago de reinscripción.',
            onTap: () {
              // Acción para escanear/subir archivo
            },
          ),
          _buildStepCard(
            icon: Icons.schedule,
            title: '4. Crear nuevo horario',
            description: 'Selecciona tus materias y arma tu horario.',
            onTap: () {
              // Acción para crear horario
            },
          ),
        ],
      ),
    );
  }
}
