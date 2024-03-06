import 'package:flutter/material.dart';
import 'package:skin_care_diary/module/home/home_calendar.dart';
import 'package:skin_care_diary/module/home/home_photo.dart';
import 'package:skin_care_diary/module/home/home_today_skin.dart';
import 'package:skin_care_diary/module/home/honeXAI.dart';
import 'package:skin_care_diary/theme.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 로고 이미지
            Padding(
              padding: const EdgeInsets.only(
                top: 30,
                bottom: 30,
              ),
              child: Image.asset(
                AssetsImg.logo,
              ),
            ),

            // 이번주 선택
            const HomeCalendar(),

            // 찍은 사진
            const HomePhoto(),

            // 오늘의 피부 분석
            const HomeTodaySkin(),

            // 오늘 xai 설명
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '오늘 XAI설명',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 10),
                  const HomeXAI(),
                ],
              ),
            ),
            const SizedBox(height: 50),
          ],
        ),
      ),
    );
  }
}
