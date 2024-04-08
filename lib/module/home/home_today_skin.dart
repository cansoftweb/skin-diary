import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:skin_care_diary/models/common_model.dart';
import 'package:skin_care_diary/store/get_calendar.dart';
import 'package:skin_care_diary/theme.dart';

class HomeTodaySkin extends StatelessWidget {
  const HomeTodaySkin({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '오늘의 피부 분석',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              // 이미지
              Expanded(
                flex: 2,
                child: AspectRatio(
                  aspectRatio: 1,
                  child: Image.asset(AssetsImg.face),
                ),
              ),
              const SizedBox(width: 10),
              // 그래프
              Expanded(
                flex: 3,
                child: _buildChart(),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBarChart({
    required String title,
    required double per,
    required int color,
  }) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 3,
        bottom: 3,
      ),
      child: Row(
        children: [
          SizedBox(
            width: 70,
            child: Text(
              title,
              style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Expanded(
            child: Container(
              alignment: Alignment.centerLeft,
              height: 10,
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Colors.black12,
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              child: FractionallySizedBox(
                widthFactor: per,
                child: Container(
                  decoration: BoxDecoration(
                    color: Color(color),
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
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

    // 랜덤한 퍼센트 값을 생성하는 함수
    List<PercentModel> generateRandomPercentValues() {
      Random random = Random();
      List<PercentModel> randomList = [];

      for (var item in list) {
        double randomPercent =
            random.nextDouble(); // 0.0부터 1.0까지의 랜덤한 double 값 생성
        randomList.add(PercentModel(
          percent: randomPercent,
          title: item.title,
          color: item.color,
        ));
      }

      return randomList;
    }

    List<PercentModel> randomList = generateRandomPercentValues();

    return GetX<PerCentController>(
      init: PerCentController(), // 컨트롤러 초기화
      builder: (controller) {
        return Column(
          children: controller.list
              .map((e) => _buildBarChart(
                  title: e.title ?? '',
                  per: e.percent ?? 0,
                  color: e.color ?? 0xFFE69A88))
              .toList(),
        );
      },
    );

    // return Column(
    //   children: randomList
    //       .map((e) => _buildBarChart(
    //           title: e.title ?? '',
    //           per: e.percent ?? 0,
    //           color: e.color ?? 0xFFE69A88))
    //       .toList(),
    // );
  }
}
