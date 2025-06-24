import 'package:flutter/material.dart';
import 'app_colors.dart';

class TextStyles {
  // Título principal (pantallas importantes)
  static const TextStyle headline1 = TextStyle(
    color: AppColors.textPrimary,
    fontSize: 22,
    fontWeight: FontWeight.bold,
  );

  // Subtítulo principal
  static const TextStyle headline2 = TextStyle(
    color: Color(0xFFDFDEDE),
    fontSize: 20,
    fontWeight: FontWeight.w600,
  );

  // Títulos de secciones dentro de pantallas
  static const TextStyle sectionTitle = TextStyle(
    color: AppColors.textPrimary,
    fontSize: 18,
    fontWeight: FontWeight.w600,
  );

  // Texto normal (cuerpo de la app)
  static const TextStyle body = TextStyle(
    color: AppColors.textPrimary,
    fontSize: 16,
    fontWeight: FontWeight.normal,
  );

  // Texto secundario (descripciones, subtítulos)
  static const TextStyle bodySecondary = TextStyle(
    color: Color.fromARGB(255, 224, 224, 224),
    fontSize: 14,
    fontWeight: FontWeight.normal,
  );

  // Texto pequeño (labels, captions, pequeños detalles)
  static const TextStyle caption = TextStyle(
    color: AppColors.textSecondary,
    fontSize: 12,
    fontWeight: FontWeight.normal,
  );

  // Texto de botones
  static const TextStyle button = TextStyle(
    color: Colors.white,
    fontSize: 16,
    fontWeight: FontWeight.bold,
  );

  // Texto para AppBar
  static const TextStyle appBarTitle = TextStyle(
    color: Colors.white,
    fontSize: 20,
    fontWeight: FontWeight.bold,
  );
}
