import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:skin_care_diary/models/calendar_model.dart';
import 'package:skin_care_diary/store/get_calendar.dart';

class CalendarChart extends StatefulWidget {
  const CalendarChart({super.key});

  @override
  State<CalendarChart> createState() => _CalendarChartState();
}

class _CalendarChartState extends State<CalendarChart> {
  int activeBtn = 7;

  List<FlSpot> generateRandomData(int count, int maxNumber) {
    Random random = Random();
    List<FlSpot> spots = [];
    for (int i = 0; i < count; i++) {
      int y = 82 + random.nextInt(10);
      spots.add(FlSpot(i.toDouble(), y.toDouble()));
    }
    return spots;
  }

  List<CalendarBtnModel> btns = [
    CalendarBtnModel(
      num: 7,
      title: '1W',
    ),
    CalendarBtnModel(
      num: 14,
      title: '2W',
    ),
    CalendarBtnModel(
      num: 31,
      title: '1M',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Wrap(
          children: [
            ...btns.map(
              (e) => Wrap(
                children: [
                  OutlinedButton(
                    onPressed: () {
                      setState(() {
                        activeBtn = e.num ?? 0;
                      });
                      Get.find<PerCentController>().updateData();
                    },
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(
                          color: activeBtn == e.num
                              ? Theme.of(context).primaryColor
                              : Colors.black12),
                      foregroundColor: activeBtn == e.num
                          ? Theme.of(context).primaryColor
                          : Colors.black87,
                    ),
                    child: Text(e.title ?? ''),
                  ),
                  const SizedBox(width: 10),
                ],
              ),
            ),
          ],
        ),
        Container(
          height: 200,
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
              // maxX: 7,
              minY: 0,
              // maxY: 6,
              titlesData: FlTitlesData(
                show: true,
                leftTitles: AxisTitles(drawBehindEverything: false),
                rightTitles: AxisTitles(drawBehindEverything: false),
                topTitles: AxisTitles(drawBehindEverything: false),
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    reservedSize: 30,
                    // getTitlesWidget: bottomTitleWidgets,
                    interval: activeBtn > 14 ? 5 : 1,
                  ),
                ),
              ),
              lineBarsData: [
                LineChartBarData(
                  spots: generateRandomData(activeBtn, 100),
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
        ),
      ],
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
