import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../core/app_colors.dart';
import '../../core/text_style.dart';

// ignore: camel_case_types
class graficapage extends StatefulWidget {
  const graficapage({super.key});

  @override
  State<graficapage> createState() => _graficapageState();
}

// ignore: camel_case_types
class _graficapageState extends State<graficapage> {
  final List<double> promedios = [9.0, 8.5, 9.2, 8.8, 9.1, 8.7];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          // Tarjeta de gráfica
          Container(
            decoration: BoxDecoration(
              color: AppColors.containerBackground,
              borderRadius: BorderRadius.circular(16),
            ),
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(Icons.bar_chart, color: IconColors.primary, size: 30),
                Text(
                  "Promedio por semestre".toUpperCase(),
                  style: TextStyles.sectionTitle,
                ),
                Divider(
                  // ignore: deprecated_member_use
                  color: const Color(0xB5E7E6E6).withOpacity(0.4),
                  thickness: 1,
                  indent: 2,
                  endIndent: 15,
                ),
                SizedBox(height: 10),
                SizedBox(
                  height: 250,
                  child: LineChart(
                    LineChartData(
                      gridData: FlGridData(
                        show: true,
                        drawVerticalLine: true,
                        getDrawingHorizontalLine:
                            (value) =>
                                FlLine(color: Colors.white24, strokeWidth: 1),
                        getDrawingVerticalLine:
                            (value) =>
                                FlLine(color: Colors.white24, strokeWidth: 1),
                      ),
                      titlesData: FlTitlesData(
                        leftTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            getTitlesWidget: (value, meta) {
                              return Text(
                                value.toStringAsFixed(1),
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                ),
                              );
                            },
                            reservedSize: 35,
                            interval: 0.5,
                          ),
                        ),
                        bottomTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            interval: 1,
                            getTitlesWidget: (value, meta) {
                              return Text(
                                'S${value.toInt() + 1}',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                ),
                              );
                            },
                          ),
                        ),
                        topTitles: AxisTitles(
                          sideTitles: SideTitles(showTitles: false),
                        ),
                        rightTitles: AxisTitles(
                          sideTitles: SideTitles(showTitles: false),
                        ),
                      ),
                      borderData: FlBorderData(
                        show: true,
                        border: Border.all(color: Colors.white24, width: 1),
                      ),
                      minX: 0,
                      maxX: (promedios.length - 1).toDouble(),
                      minY: 7.5,
                      maxY: 10,
                      lineBarsData: [
                        LineChartBarData(
                          spots: List.generate(
                            promedios.length,
                            (index) =>
                                FlSpot(index.toDouble(), promedios[index]),
                          ),
                          isCurved: true,
                          color: IconColors.primary,
                          barWidth: 4,
                          isStrokeCapRound: true,
                          dotData: FlDotData(
                            show: true,
                            getDotPainter:
                                (spot, _, __, ___) => FlDotCirclePainter(
                                  radius: 4,
                                  color: Colors.white,
                                  strokeWidth: 2,
                                  strokeColor: IconColors.primary,
                                ),
                          ),
                          belowBarData: BarAreaData(
                            show: true,
                            // ignore: deprecated_member_use
                            color: IconColors.primary.withOpacity(0.2),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
