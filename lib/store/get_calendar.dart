import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skin_care_diary/models/common_model.dart';

class PerCentController extends GetxController {
  // GetX 컨트롤러를 사용하여 데이터를 관리
  RxList<PercentModel> list = [
    PercentModel(percent: 0.53, title: '수분', color: 0xFFD64B74),
    PercentModel(percent: 0.51, title: '모공', color: 0xFF31B0D3),
    PercentModel(percent: 0.25, title: '주름', color: 0xFF9DCB7A),
    PercentModel(percent: 0.72, title: '탄력', color: 0xFFC392C7),
    PercentModel(percent: 0.17, title: '색소침착', color: 0xFFE69A88),
  ].obs;

  // 피부건강
  var healthy = 22.obs;

  // 피부나이
  var age = 30.obs;

  // 데이터 업데이트 메서드
  void updateData() {
    var newList = list.forEach((element) {
      // 랜덤 객체 생성
      Random random = Random();
      double min = 0;
      double max = 1;
      if (element.title == '수분') {
        min = 0.10;
        max = 0.15;
      } else if (element.title == '모공') {
        min = 0.01;
        max = 0.10;
      } else if (element.title == '주름') {
        min = 0.00;
        max = 0.10;
      } else if (element.title == '탄력') {
        min = 0.70;
        max = 0.90;
      } else if (element.title == '색소침착') {
        min = 0.00;
        max = 0.10;
      }

      double randomNumber = min + random.nextDouble() * (max - min);
      element.percent = randomNumber;
    });
    // 업데이트를 감지하고 UI를 업데이트
    list.refresh();

    int randomHealthy = 82 + Random().nextInt(10);
    healthy(randomHealthy);

    int randomAge = 30 - Random().nextInt(5);
    age(randomAge);
  }
}
