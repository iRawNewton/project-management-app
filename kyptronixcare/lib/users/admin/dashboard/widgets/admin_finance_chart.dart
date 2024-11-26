import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class FinancesChart extends StatelessWidget {
  final List<double> earnings;

  const FinancesChart({super.key, required this.earnings});

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.23,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        child: LineChart(
          LineChartData(
            lineTouchData: LineTouchData(
              enabled: true,
              touchTooltipData: LineTouchTooltipData(
                getTooltipColor: (touchedSpot) =>
                    Colors.blueAccent.withOpacity(0.7),

                // tooltipBgColor: Colors.blueAccent.withOpacity(0.7),
              ),
            ),
            gridData: FlGridData(
              show: true,
              drawVerticalLine: true,
              getDrawingHorizontalLine: (value) => FlLine(
                color: Colors.grey.withOpacity(0.2),
                strokeWidth: 1,
              ),
              getDrawingVerticalLine: (value) => FlLine(
                color: Colors.grey.withOpacity(0.2),
                strokeWidth: 1,
              ),
            ),
            titlesData: FlTitlesData(
              bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  getTitlesWidget: (value, meta) {
                    const style = TextStyle(
                      color: Colors.blueAccent,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    );
                    switch (value.toInt()) {
                      case 0:
                        return const Text('June', style: style);
                      case 1:
                        return const Text('July', style: style);
                      case 2:
                        return const Text('August', style: style);
                      case 3:
                        return const Text('September', style: style);
                      default:
                        return const Text('');
                    }
                  },
                  reservedSize: 32,
                  interval: 1,
                ),
              ),
              leftTitles: const AxisTitles(
                sideTitles: SideTitles(showTitles: false),
              ),
              topTitles: const AxisTitles(
                sideTitles: SideTitles(showTitles: false),
              ),
              rightTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  getTitlesWidget: (value, meta) {
                    return Text('${value.toInt()}',
                        style: Theme.of(context)
                            .textTheme
                            .displayLarge!
                            .copyWith(
                                color: Colors.blueAccent,
                                fontWeight: FontWeight.bold,
                                fontSize: 12.0));
                  },
                  reservedSize: 40,
                  interval: 1000,
                ),
              ),
            ),
            borderData: FlBorderData(
              show: true,
              border: Border.all(
                color: Colors.blueAccent.withOpacity(0.5),
                width: 1,
              ),
            ),
            minX: 0,
            maxX: 3,
            minY: 0,
            maxY: (earnings.reduce((a, b) => a > b ? a : b)) + 2000,
            lineBarsData: [
              LineChartBarData(
                isCurved: false,
                color: Colors.blueAccent,
                barWidth: 2,
                isStrokeCapRound: true,
                dotData: const FlDotData(show: true),
                belowBarData: BarAreaData(
                  show: true,
                  color: Colors.blueAccent.withOpacity(0.1),
                ),
                spots: List.generate(
                  earnings.length,
                  (index) => FlSpot(index.toDouble(), earnings[index]),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
