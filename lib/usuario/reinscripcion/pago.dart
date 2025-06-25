import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import '../../core/app_colors.dart';
import '../../global.dart';

class EscaneoPagoPage extends StatefulWidget {
  const EscaneoPagoPage({super.key});

  @override
  State<EscaneoPagoPage> createState() => _EscaneoPagoPageState();
}

class _EscaneoPagoPageState extends State<EscaneoPagoPage> {
  File? imagenComprobante;
  bool comprobanteValido = false;
  bool escaneando = false;

  final ImagePicker picker = ImagePicker();

  String sinAcentos(String s) {
    const withAccents = 'áéíóúüñ';
    const withoutAccents = 'aeiouun';
    for (int i = 0; i < withAccents.length; i++) {
      s = s.replaceAll(withAccents[i], withoutAccents[i]);
    }
    return s;
  }

  Future<void> tomarFoto() async {
    final alumno = Global().alumno;
    final datos = Global().datos;
    final nombre = datos?['nombre'];
    final matricula = datos?['matricula'];
    final apellido = datos?['apellido'];
    final nombreCompleto =
        '${Global().datos?['nombre']} ${Global().datos?['apellido']}'
            .toUpperCase();
    final XFile? foto = await picker.pickImage(source: ImageSource.camera);

    if (foto != null) {
      setState(() {
        imagenComprobante = File(foto.path);
        escaneando = true;
        comprobanteValido = false;
      });

      final inputImage = InputImage.fromFilePath(foto.path);
      final textRecognizer = TextRecognizer(
        script: TextRecognitionScript.latin,
      );
      final RecognizedText recognizedText = await textRecognizer.processImage(
        inputImage,
      );
      textRecognizer.close();

      // Procesar texto
      String textoReconocido =
          recognizedText.text
              .toLowerCase()
              .replaceAll(RegExp(r'\s+'), ' ')
              .replaceAll('\n', ' ')
              .trim();
      textoReconocido = sinAcentos(textoReconocido);
      final nombreSinAcentos = sinAcentos(nombreCompleto.toLowerCase());

      int score = 0;

      // Validar monto con regex flexible
      final montoRegex = RegExp(r'3[\.,]?\s*4\s*6\s*7');
      if (montoRegex.hasMatch(textoReconocido)) score++;

      // Validar inscripcion
      if (textoReconocido.contains('inscripcion')) score++;

      // Validar nombre
      if (textoReconocido.contains(nombreSinAcentos)) score++;

      // Validar matrícula
      if (textoReconocido.contains(matricula.toString())) score++;

      bool valido = score >= 3;

      setState(() {
        comprobanteValido = valido;
        escaneando = false;
      });

      if (valido) {
        Future.delayed(const Duration(milliseconds: 500), () {
          Navigator.pop(context, true);
        });
      }

      print('Texto detectado: ${recognizedText.text}');
      print('Informacion a comparar:');
      print('Nombre: $nombreCompleto');
      print('Matrícula: $matricula');
    } else {
      print('No se tomó ninguna foto');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [AppColors.background, const Color(0xFF616161)],
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
              'Escanear Comprobante',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            if (imagenComprobante != null)
              Column(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.file(imagenComprobante!, height: 200),
                  ),
                  const SizedBox(height: 10),
                  escaneando
                      ? const CircularProgressIndicator()
                      : Text(
                        comprobanteValido
                            ? '✅ Comprobante válido'
                            : '❌ Comprobante inválido',
                        style: TextStyle(
                          color:
                              comprobanteValido
                                  ? Colors.greenAccent
                                  : Colors.redAccent,
                          fontSize: 16,
                        ),
                      ),
                ],
              )
            else
              const Text(
                'Aún no has escaneado ningún comprobante.',
                style: TextStyle(color: Colors.white70),
              ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: escaneando ? null : tomarFoto,
              icon: const Icon(Icons.camera_alt, color: Color(0xFF265223)),
              label: const Text(
                'Escanear Comprobante',
                style: TextStyle(color: Color(0xFFBCBCBC)),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green.shade800,
                minimumSize: const Size.fromHeight(50),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
