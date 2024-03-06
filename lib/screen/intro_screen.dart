import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_svg/svg.dart';
import 'package:skin_care_diary/models/common_model.dart';
import 'package:skin_care_diary/navigation/tab_navigation.dart';
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
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                _buildSummary(),
                const SizedBox(height: 20),
                _buildCharts(),
                const SizedBox(height: 20),
                _buildIntroButton(context),
              ],
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

  Widget _buildCharts() {
    List<PercentModel> list = [
      PercentModel(
        percent: 0.80,
        title: '잡티',
        color: 0xFF31B0D3,
      ),
      PercentModel(
        percent: 0.92,
        title: '주름',
        color: 0xFF9DCB7A,
      ),
      PercentModel(
        percent: 0.85,
        title: '피부결',
        color: 0xFFC392C7,
      ),
      PercentModel(
        percent: 0.87,
        title: '다크서클',
        color: 0xFFE69A88,
      ),
    ];
    return Wrap(
      children: [
        Padding(
          padding: const EdgeInsets.only(
            left: 7,
            right: 7,
          ),
          child: Column(
            children: [
              Container(
                width: 59.0,
                height: 59.0,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Color(0xFFD64B74), // 테두리 색상 지정
                    width: 3.0, // 테두리 두께 지정
                  ),
                ),
                child: CircleAvatar(
                  backgroundColor: Color(0xFFFFC3D3).withOpacity(0.6),
                  child: SvgPicture.asset(
                    AssetsImg.iconFace,
                    width: 35,
                    height: 35,
                  ),
                ),
              ),
              const SizedBox(height: 5),
              const Text(
                '모두',
                style: const TextStyle(
                  fontSize: 13,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
        ...list
            .map(
              (e) => Padding(
                padding: const EdgeInsets.only(
                  left: 7,
                  right: 7,
                ),
                child: Column(
                  children: [
                    CustomPaint(
                      size: const Size(56, 56),
                      painter: LinePieChartPainter(
                        percentages: [e.percent ?? 0], // 백분율 값 (0.0 ~ 1.0)
                        textStyle: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.w500,
                          shadows: [
                            Shadow(
                              color: Colors.black.withOpacity(0.6),
                              offset: Offset(0, 2),
                              blurRadius: 2,
                            ),
                          ],
                        ),
                        colors: e.color != null
                            ? [Color(e.color!)]
                            : [Color(0xFF31B0D3)], // 각 섹션의 색상
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      e.title ?? '',
                      style: const TextStyle(
                        fontSize: 13,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            )
            .toList(),
      ],
    );
  }

  Widget _buildSummary() {
    return Column(
      children: [
        _buildSummaryText(
          title: '피부 건강',
          score: 86,
        ),
        _buildSummaryText(
          title: '피부 나이',
          score: 23,
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
