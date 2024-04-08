import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:skin_care_diary/models/common_model.dart';
import 'package:skin_care_diary/navigation/tab_navigation.dart';
import 'package:skin_care_diary/store/get_calendar.dart';
import 'package:skin_care_diary/theme.dart';
import 'package:skin_care_diary/widget/chart/line_pie_chart.dart';
import 'package:skin_care_diary/widget/header/header_icon.dart';

class IntroScreen extends StatelessWidget {
  const IntroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.black12,
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        // leading: HeaderIcon(icon: Icons.arrow_back_ios_new),
        leading: Container(),
        title: HeaderIcon(
          icon: Icons.calendar_month,
          color: Theme.of(context).secondaryHeaderColor,
        ),
        actions: [
          HeaderIcon(icon: Icons.camera_alt_outlined),
        ],
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        centerTitle: true,
      ),
      body: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          image: DecorationImage(
            fit: BoxFit.cover,
            image: NetworkImage(
              'https://images.unsplash.com/photo-1554151228-14d9def656e4?q=80&w=1586&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
            ),
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: GetX<PerCentController>(
              init: PerCentController(), // 컨트롤러 초기화
              builder: (controller) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    _buildSummary(
                      healthy: controller.healthy.value,
                      age: controller.age.value,
                    ),
                    const SizedBox(height: 20),
                    _buildCharts(
                      context: context,
                      list: controller.list,
                    ),
                    const SizedBox(height: 20),
                    _buildIntroButton(context),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildIntroButton(context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(
          context,
          MyHomePage.route(),
        );
      },
      child: Container(
        height: 45,
        decoration: BoxDecoration(
          color: Theme.of(context).secondaryHeaderColor,
          borderRadius: const BorderRadius.all(
            Radius.circular(5),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: const [
            Icon(
              Icons.calendar_month,
              color: Colors.white,
              size: 24,
            ),
            SizedBox(width: 5),
            Text(
              '스다 쓰기',
              style: TextStyle(
                color: Colors.white,
                fontSize: 15,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCharts({
    required BuildContext context,
    required List<PercentModel> list,
  }) {
    double screenWidth = MediaQuery.of(context).size.width;
    double radius = screenWidth * 0.11;

    // List<PercentModel> list = [
    //   PercentModel(
    //     percent: 0.80,
    //     title: '잡티',
    //     color: 0xFF31B0D3,
    //   ),
    //   PercentModel(
    //     percent: 0.92,
    //     title: '주름',
    //     color: 0xFF9DCB7A,
    //   ),
    //   PercentModel(
    //     percent: 0.85,
    //     title: '피부결',
    //     color: 0xFFC392C7,
    //   ),
    //   PercentModel(
    //     percent: 0.87,
    //     title: '다크서클',
    //     color: 0xFFE69A88,
    //   ),
    // ];

    return Wrap(
      children: list.map((model) {
        return Padding(
          padding: const EdgeInsets.only(
            left: 7,
            right: 7,
          ),
          child: Column(
            children: [
              CustomPaint(
                size: Size(radius, radius),
                painter: LinePieChartPainter(
                  percentages: [model.percent ?? 0], // 백분율 값 (0.0 ~ 1.0)
                  textStyle: TextStyle(
                    color: Colors.white,
                    fontSize: radius * 0.5,
                    fontWeight: FontWeight.w500,
                    shadows: [
                      Shadow(
                        color: Colors.black.withOpacity(0.6),
                        offset: Offset(0, 2),
                        blurRadius: 2,
                      ),
                    ],
                  ),
                  colors: model.color != null
                      ? [Color(model.color!)]
                      : [Color(0xFF31B0D3)], // 각 섹션의 색상
                ),
              ),
              const SizedBox(height: 5),
              Text(
                model.title ?? '',
                style: const TextStyle(
                  fontSize: 13,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildSummary({
    required int healthy,
    required int age,
  }) {
    return Column(
      children: [
        _buildSummaryText(
          title: '피부 건강',
          score: healthy,
        ),
        _buildSummaryText(
          title: '피부 나이',
          score: age,
        )
      ],
    );
  }

  Widget _buildSummaryText({
    required String title,
    required int score,
  }) {
    return Padding(
      padding: EdgeInsets.only(
        top: 5,
        bottom: 5,
      ),
      child: Row(
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 15,
              color: Colors.white,
              shadows: [
                Shadow(
                  color: Colors.black.withOpacity(0.6),
                  offset: Offset(0, 1),
                  blurRadius: 1,
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          Text(
            score.toString(),
            style: TextStyle(
              fontSize: 32,
              color: Colors.white,
              fontWeight: FontWeight.w700,
              shadows: [
                Shadow(
                  color: Colors.black.withOpacity(0.6),
                  offset: Offset(0, 2),
                  blurRadius: 2,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
