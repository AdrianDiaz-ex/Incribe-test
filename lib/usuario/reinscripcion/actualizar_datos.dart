import 'package:flutter/material.dart';
import 'package:inscribe_test/core/app_colors.dart';
import '../../global.dart';

class ActualizarDatos extends StatefulWidget {
  const ActualizarDatos({super.key});

  @override
  State<ActualizarDatos> createState() => _ActualizarDatosState();
}

class _ActualizarDatosState extends State<ActualizarDatos> {
  final _formKey = GlobalKey<FormState>();

  // Controladores para los campos
  final celularController = TextEditingController(
    text: DatosActualizadosTemp.celular,
  );
  final casaController = TextEditingController(
    text: DatosActualizadosTemp.casa,
  );
  final trabajoController = TextEditingController(
    text: DatosActualizadosTemp.trabajo,
  );
  final emergenciaController = TextEditingController(
    text: DatosActualizadosTemp.emergencia,
  );
  final nombreEmergenciaController = TextEditingController(
    text: DatosActualizadosTemp.nombreEmergencia,
  );
  final parentescoController = TextEditingController(
    text: DatosActualizadosTemp.parentesco,
  );
  final calleController = TextEditingController(
    text: DatosActualizadosTemp.calle,
  );
  final numExtController = TextEditingController(
    text: DatosActualizadosTemp.numExt,
  );
  final numIntController = TextEditingController(
    text: DatosActualizadosTemp.numInt,
  );
  final calle1Controller = TextEditingController(
    text: DatosActualizadosTemp.calle1,
  );
  final calle2Controller = TextEditingController(
    text: DatosActualizadosTemp.calle2,
  );
  final referenciasController = TextEditingController(
    text: DatosActualizadosTemp.referencias,
  );

  String genero = DatosActualizadosTemp.genero;

  @override
  void dispose() {
    // Liberar recursos
    celularController.dispose();
    casaController.dispose();
    trabajoController.dispose();
    emergenciaController.dispose();
    nombreEmergenciaController.dispose();
    parentescoController.dispose();
    calleController.dispose();
    numExtController.dispose();
    numIntController.dispose();
    calle1Controller.dispose();
    calle2Controller.dispose();
    referenciasController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: _buildAppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSectionTitle('Información Personal'),
              _buildReadOnlyField('Matrícula', '202123019'),
              _buildReadOnlyField('Nombre', 'ALEX ADRIAN DELGADILLO DIAZ'),
              _buildReadOnlyField('Curp', 'DEDA031013HMCLZLA8'),
              _buildReadOnlyField('Fecha Nacimiento', '13/10/2003'),
              _buildDropdownField('Género', ['Hombre', 'Mujer'], genero),

              const SizedBox(height: 16),
              _buildSectionTitle('Contacto'),
              _buildInputField(
                'Teléfono celular',
                celularController,
                isNumeric: true,
              ),
              _buildInputField(
                'Teléfono casa',
                casaController,
                isNumeric: true,
              ),
              _buildInputField(
                'Teléfono trabajo',
                trabajoController,
                requiredField: false,
                isNumeric: true,
              ),
              _buildInputField(
                'Teléfono de emergencia',
                emergenciaController,
                isNumeric: true,
              ),
              _buildInputField(
                'Nombre del contacto de emergencia',
                nombreEmergenciaController,
              ),
              _buildInputField(
                'Parentesco del contacto de emergencia',
                parentescoController,
              ),

              const SizedBox(height: 16),
              _buildSectionTitle('Dirección'),
              _buildInputField(
                'Mi calle',
                calleController,
                initialValue: 'Vicente Guerrero',
              ),
              _buildInputField(
                'Número exterior',
                numExtController,
                isNumeric: true,
                initialValue: '41',
              ),
              _buildInputField(
                'Número interior',
                numIntController,
                isNumeric: true,
                requiredField: false,
              ),
              _buildInputField(
                'Calle 1',
                calle1Controller,
                initialValue: 'Granaditas',
              ),
              _buildInputField(
                'Calle 2',
                calle2Controller,
                initialValue: 'Corregidora',
              ),
              _buildInputField(
                'Referencias',
                referenciasController,
                initialValue: 'Ninguna',
              ),

              const SizedBox(height: 30),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Datos guardados')),
                      );
                      Navigator.pop(context, true);
                      DatosActualizadosTemp.celular = celularController.text;
                      DatosActualizadosTemp.casa = casaController.text;
                      DatosActualizadosTemp.trabajo = trabajoController.text;
                      DatosActualizadosTemp.emergencia =
                          emergenciaController.text;
                      DatosActualizadosTemp.nombreEmergencia =
                          nombreEmergenciaController.text;
                      DatosActualizadosTemp.parentesco =
                          parentescoController.text;
                      DatosActualizadosTemp.calle = calleController.text;
                      DatosActualizadosTemp.numExt = numExtController.text;
                      DatosActualizadosTemp.numInt = numIntController.text;
                      DatosActualizadosTemp.calle1 = calle1Controller.text;
                      DatosActualizadosTemp.calle2 = calle2Controller.text;
                      DatosActualizadosTemp.referencias =
                          referenciasController.text;
                      DatosActualizadosTemp.genero =
                          genero; // 🔑 Devuelve true para desbloquear
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Por favor completa todos los campos'),
                        ),
                      );
                    }
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
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return PreferredSize(
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
          title: const Text(
            'ACTUALIZAR DATOS',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              letterSpacing: 0,
            ),
          ),
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

  Widget _buildInputField(
    String label,
    TextEditingController controller, {
    bool isNumeric = false,
    bool requiredField = true,
    String? initialValue, // <- nuevo parámetro opcional
  }) {
    // Si hay un valor inicial y el controlador está vacío, lo asignamos
    if (initialValue != null && controller.text.isEmpty) {
      controller.text = initialValue;
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: TextFormField(
        controller: controller,
        keyboardType: isNumeric ? TextInputType.number : TextInputType.text,
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
        validator: (value) {
          if (requiredField) {
            if (value == null || value.trim().isEmpty) {
              return 'Campo requerido';
            }
          }
          return null;
        },
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
          if (newValue != null) {
            setState(() {
              genero = newValue;
            });
          }
        },
      ),
    );
  }
}
