import 'package:flutter/material.dart';
import 'package:inscribe_test/core/app_colors.dart';

class InicioPage extends StatelessWidget {
  const InicioPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(children: [const Text('Hola gente')]),
      ),
    );
  }
}
