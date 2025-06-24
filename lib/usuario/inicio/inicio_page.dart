import 'package:flutter/material.dart';
import 'package:inscribe_test/core/app_colors.dart';
//import 'package:inscribe_test/usuario/inicio/grafica.dart';
import 'foto.dart';
import 'informacion.dart';

class InicioPage extends StatelessWidget {
  const InicioPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.background,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(5),
        child: Column(children: const [UserFotoPage(), Informacion()]),
      ),
    );
  }
}
