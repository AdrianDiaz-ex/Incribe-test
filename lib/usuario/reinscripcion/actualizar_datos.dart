import 'package:flutter/material.dart';
import 'package:inscribe_test/core/app_colors.dart';

class ActualizarDatos extends StatelessWidget {
  const ActualizarDatos({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50.0),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [AppColors.background, AppColors.containerBackground],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
          ),
          child: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            centerTitle: true,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text(
                  'ACTUALIZAR DATOS',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    letterSpacing: 0,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionTitle('Información Personal'),
            _buildReadOnlyField('Matrícula', '202123019'),
            _buildReadOnlyField('Nombre', 'ALEX ADRIAN DELGADILLO DIAZ'),
            _buildReadOnlyField('Curp', 'DEDA031013HMCLZLA8'),
            _buildReadOnlyField('Fecha Nacimiento', '13/10/2003'),
            _buildDropdownField('Género', ['Hombre', 'Mujer'], 'Hombre'),

            const SizedBox(height: 16),
            _buildSectionTitle('Contacto'),
            _buildInputField('Teléfono celular'),
            _buildInputField('Teléfono casa'),
            _buildInputField('Teléfono trabajo'),
            _buildInputField('Teléfono de emergencia'),
            _buildInputField('Nombre del contacto de emergencia'),
            _buildInputField('Parentesco del contacto de emergencia'),

            const SizedBox(height: 16),
            _buildSectionTitle('Dirección'),
            _buildInputField('Mi calle'),
            _buildInputField('Número exterior'),
            _buildInputField('Número interior'),
            _buildInputField('Calle 1'),
            _buildInputField('Calle 2'),
            _buildInputField('Referencias'),

            const SizedBox(height: 30),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // Aquí colocas la lógica de guardar datos
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Datos guardados')),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 42, 39, 39),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 40,
                    vertical: 15,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: const Text(
                  'GUARDAR DATOS',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 8),
      color: const Color.fromARGB(255, 51, 48, 47),
      child: Text(
        title,
        style: const TextStyle(color: Colors.white, fontSize: 18),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _buildReadOnlyField(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(color: Colors.white70)),
          const SizedBox(height: 2),
          Text(value, style: const TextStyle(color: Colors.white)),
          const Divider(color: Colors.white24),
        ],
      ),
    );
  }

  Widget _buildInputField(String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: TextField(
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(color: Colors.white54),
          enabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white24),
          ),
          focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.greenAccent),
          ),
        ),
      ),
    );
  }

  Widget _buildDropdownField(String label, List<String> items, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: DropdownButtonFormField<String>(
        value: value,
        dropdownColor: AppColors.containerBackground,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(color: Colors.white54),
          enabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white24),
          ),
        ),
        iconEnabledColor: Colors.white,
        items:
            items
                .map(
                  (item) => DropdownMenuItem(
                    value: item,
                    child: Text(
                      item,
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                )
                .toList(),
        onChanged: (newValue) {
          // Aquí manejas el cambio
        },
      ),
    );
  }
}
