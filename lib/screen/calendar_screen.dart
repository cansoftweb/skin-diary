import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:skin_care_diary/module/calendar/calendar_chart.dart';
import 'package:skin_care_diary/module/home/honeXAI.dart';
import 'package:skin_care_diary/theme.dart';
import 'package:skin_care_diary/widget/header/header_icon.dart';

class CalendarScreen extends StatelessWidget {
  const CalendarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        // leading: HeaderIcon(icon: Icons.arrow_back_ios_new),
        leading: Container(),
        title: const Text(
          '피부일지',
          style: TextStyle(
            fontSize: 20,
          ),
        ),
        backgroundColor: Theme.of(context).primaryColor,
        shadowColor: Colors.transparent,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildUserInfo(context),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const HomeXAI(),
                  const SizedBox(height: 20),
                  const SizedBox(
                    height: 200,
                    child: CalendarChart(),
                  ),
                  const SizedBox(height: 20),
                  // Text(
                  //   'XAI피부설명',
                  //   style: Theme.of(context).textTheme.titleMedium,
                  // ),
                  // const SizedBox(height: 10),
                  // const HomeXAI(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUserInfo(context) {
    double screenWidth = MediaQuery.of(context).size.width;
    String userImg =
        'https://images.unsplash.com/photo-1554151228-14d9def656e4?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8OHx8cGVyc29ufGVufDB8fDB8fHww';
    int userAge = 28;
    return Container(
      padding: const EdgeInsets.all(20),
      width: screenWidth,
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        borderRadius: const BorderRadius.only(
          bottomRight: Radius.circular(50),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Container(
              alignment: Alignment.center,
              child: Container(
                width: 110,
                height: 170,
                child: Stack(
                  children: [
                    SvgPicture.asset(AssetsImg.iconDrop),
                    Positioned(
                      bottom: 10,
                      left: 10,
                      child: CircleAvatar(
                        radius: 45,
                        backgroundImage: NetworkImage(userImg),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: Column(
              children: [
                _buildUserInfoText(
                  title: '피부 건강',
                  num: 86,
                ),
                _buildUserInfoText(
                  title: '실제 나이',
                  num: 28,
                ),
                const SizedBox(height: 10),
                Text(
                  '실제 나이 : $userAge',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUserInfoText({
    required String title,
    required int num,
  }) {
    return Row(
      children: [
        Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 15,
          ),
        ),
        const SizedBox(width: 10),
        Text(
          num.toString(),
          style: const TextStyle(
            color: Colors.white,
            fontSize: 40,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}
