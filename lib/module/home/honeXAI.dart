import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:skin_care_diary/models/common_model.dart';
import 'package:skin_care_diary/widget/chart/line_pie_chart.dart';

class HomeXAI extends StatelessWidget {
  const HomeXAI({super.key});

  @override
  Widget build(BuildContext context) {
    return _buildChart();
  }

  Widget _buildChart() {
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
    return Wrap(
      children: [
        ...list
            .map((e) => Padding(
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    children: [
                      CustomPaint(
                        size: const Size(56, 56),
                        painter: LinePieChartPainter(
                          percentages: [0.86],
                          colors: e.color != null
                              ? [Color(e.color!)]
                              : [Color(0xFF31B0D3)],
                        ),
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
  }
}
