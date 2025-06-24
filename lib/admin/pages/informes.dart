import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../core/app_colors.dart';
import '../../core/text_style.dart';

class EstadisticasPage extends StatelessWidget {
  const EstadisticasPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _buildChartSection(
              title: "Promedio general de grupos 3801 y 3802",
              sections: [
                PieChartSectionData(
                  value: 70,
                  title: '3801\n70',
                  color: Colors.blue,
                  titleStyle: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                  ),
                ),
                PieChartSectionData(
                  value: 65,
                  title: '3802\n65',
                  color: Colors.green,
                  titleStyle: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            _buildChartSection(
              title: "3801 - Aprobados vs Reprobados",
              sections: [
                PieChartSectionData(
                  value: 25,
                  title: 'Aprobados\n25',
                  color: Colors.green,
                  titleStyle: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                  ),
                ),
                PieChartSectionData(
                  value: 5,
                  title: 'Reprobados\n5',
                  color: Colors.red,
                  titleStyle: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            _buildChartSection(
              title: "3802 - Aprobados vs Reprobados",
              sections: [
                PieChartSectionData(
                  value: 28,
                  title: 'Aprobados\n28',
                  color: Colors.green,
                  titleStyle: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                  ),
                ),
                PieChartSectionData(
                  value: 7,
                  title: 'Reprobados\n7',
                  color: Colors.red,
                  titleStyle: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildChartSection({
    required String title,
    required List<PieChartSectionData> sections,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.containerBackground,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 4)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.pie_chart, color: IconColors.primary),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  title.toUpperCase(),
                  style: TextStyles.sectionTitle,
                ),
              ),
            ],
          ),
          const Divider(thickness: 1),
          const SizedBox(height: 12),
          SizedBox(
            height: 200,
            child: PieChart(
              PieChartData(
                sections: sections,
                sectionsSpace: 2,
                centerSpaceRadius: 40,
                borderData: FlBorderData(show: false),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
