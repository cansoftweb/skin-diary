import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:skin_care_diary/models/common_model.dart';
import 'package:skin_care_diary/store/get_calendar.dart';
import 'package:skin_care_diary/widget/chart/line_pie_chart.dart';

class HomeXAI extends StatelessWidget {
  const HomeXAI({super.key});

  @override
  Widget build(BuildContext context) {
    return _buildChart(context);
  }

  Widget _buildChart(context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double radius = screenWidth * 0.11;

    List<PercentModel> list = [
      PercentModel(
        percent: 0.85,
        title: '수분',
        color: 0xFFD64B74,
      ),
      PercentModel(
        percent: 0.86,
        title: '모공',
        color: 0xFF31B0D3,
      ),
      PercentModel(
        percent: 0.80,
        title: '주름',
        color: 0xFF9DCB7A,
      ),
      PercentModel(
        percent: 0.92,
        title: '탄력',
        color: 0xFFC392C7,
      ),
      PercentModel(
        percent: 0.50,
        title: '색소침착',
        color: 0xFFE69A88,
      ),
    ];

    return Container(
      alignment: Alignment.center,
      width: double.infinity,
      child: GetX<PerCentController>(
        init: PerCentController(), // 컨트롤러 초기화
        builder: (controller) {
          return Wrap(
            runAlignment: WrapAlignment.center,
            children: [
              ...controller.list
                  .map((e) => Padding(
                        padding: const EdgeInsets.all(8),
                        child: Column(
                          children: [
                            CustomPaint(
                              size: Size(radius, radius),
                              painter: LinePieChartPainter(
                                  percentages: [e.percent ?? 0],
                                  colors: e.color != null
                                      ? [Color(e.color!)]
                                      : [Color(0xFF31B0D3)],
                                  textStyle: TextStyle(
                                    color: e.color != null
                                        ? Color(e.color!)
                                        : Color(0xFF31B0D3),
                                    fontSize: 24,
                                    fontWeight: FontWeight.w500,
                                  )),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              e.title ?? '',
                              style: const TextStyle(
                                fontSize: 13,
                                color: Colors.black87,
                              ),
                            ),
                          ],
                        ),
                      ))
                  .toList()
            ],
          );
        },
      ),
    );
  }
}
