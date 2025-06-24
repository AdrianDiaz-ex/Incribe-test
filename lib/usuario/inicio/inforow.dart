import 'package:flutter/material.dart';
import '../../core/app_colors.dart';
import '../../core/text_style.dart';

class InfoRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const InfoRow({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(icon, color: IconColors.primary),
        SizedBox(width: 8),
        Text("$label: ", style: TextStyles.body),
        SizedBox(width: 10),
        Expanded(
          child: Text(
            value,
            style: TextStyles.bodySecondary,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
