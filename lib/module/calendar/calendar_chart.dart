import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CalendarChart extends StatelessWidget {
  const CalendarChart({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: LineChart(
        LineChartData(
          gridData: FlGridData(
            show: true,
            drawHorizontalLine: false,
            getDrawingVerticalLine: (value) {
              return FlLine(
                color: Colors.black12, // 수직 라인의 색상 설정
                strokeWidth: 1, // 수직 라인의 두께 설정
                dashArray: [5, 2], // 선택적으로 점선 형태로 설정
              );
            },
          ),
          borderData: FlBorderData(
              show: true,
              border: const Border(
                top: BorderSide(
                  width: 1,
                  color: Colors.black12,
                ),
                bottom: BorderSide(
                  width: 1,
                  color: Colors.black12,
                ),
              )),
          minX: 0,
          maxX: 7,
          minY: 0,
          maxY: 6,
          titlesData: FlTitlesData(
            show: true,
            leftTitles: AxisTitles(drawBehindEverything: false),
            rightTitles: AxisTitles(drawBehindEverything: false),
            topTitles: AxisTitles(drawBehindEverything: false),
            // bottomTitles: AxisTitles(
            //   sideTitles: SideTitles(
            //     showTitles: true,
            //     reservedSize: 30,
            //     getTitlesWidget: bottomTitleWidgets,
            //     interval: 1,
            //   ),
            // ),
          ),
          lineBarsData: [
            LineChartBarData(
              spots: [
                FlSpot(0, 3),
                FlSpot(1, 1),
                FlSpot(2, 4),
                FlSpot(3, 2),
                FlSpot(4, 5),
                FlSpot(5, 1),
                FlSpot(6, 4),
              ],
              isCurved: false,
              barWidth: 1,
              color: Theme.of(context).primaryColor,
              dotData: FlDotData(
                show: true,
                getDotPainter: (spot, percent, barData, index) {
                  return FlDotCirclePainter(
                    radius: 3,
                    color: Colors.white,
                    strokeColor: Theme.of(context).primaryColor,
                    strokeWidth: 1,
                  );
                },
              ),
              belowBarData: BarAreaData(
                show: true,
                // color: Colors.blue.withOpacity(0.3),
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [
                    Theme.of(context).primaryColor.withOpacity(0.0),
                    Theme.of(context).primaryColor.withOpacity(0.6),
                  ].toList(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 16,
    );
    Widget text;
    switch (value.toInt()) {
      case 2:
        text = const Text('MAR', style: style);
        break;
      case 5:
        text = const Text('JUN', style: style);
        break;
      case 8:
        text = const Text('SEP', style: style);
        break;
      default:
        text = const Text('', style: style);
        break;
    }

    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: text,
    );
  }
}
