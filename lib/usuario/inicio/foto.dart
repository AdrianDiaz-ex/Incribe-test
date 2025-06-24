import 'package:flutter/material.dart';
import 'package:inscribe_test/core/app_colors.dart';
import 'package:inscribe_test/core/text_style.dart';
import '../../global.dart';

class UserFotoPage extends StatefulWidget {
  const UserFotoPage({super.key});

  @override
  State<UserFotoPage> createState() => _UserFotoPageState();
}

class _UserFotoPageState extends State<UserFotoPage> {
  @override
  Widget build(BuildContext context) {
    final alumno = Global().alumno;
    final datos = Global().datos;

    // ignore: unused_local_variable
    final nombre = datos?['nombre'];
    // ignore: unused_local_variable
    final apellido = datos?['apellido'];
    // ignore: unused_local_variable
    final correo = alumno?['user'];
    // ignore: unused_local_variable
    final matricula = datos?['matricula'];
    final nombreCompleto =
        '${Global().datos?['nombre']} ${Global().datos?['apellido']}';
    return Row(
      children: [
        //UsuarioInfo
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(
              left: 20,
              top: 15,
              right: 20,
              bottom: 1,
            ),
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.containerBackground,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  children: [
                    Icon(
                      Icons.account_circle,
                      size: 150,
                      color: IconColors.primary,
                    ),
                    SizedBox(height: 8),
                    Text(
                      nombreCompleto.toUpperCase(),
                      style: TextStyles.headline1,
                    ),
                    Text("Alumno Regular", style: TextStyles.headline2),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
