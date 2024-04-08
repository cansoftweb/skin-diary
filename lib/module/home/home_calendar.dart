import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:skin_care_diary/models/home_model.dart';
import 'package:skin_care_diary/module/home/home_cubit.dart';
import 'package:intl/intl.dart';
import 'package:skin_care_diary/store/get_calendar.dart';

class HomeCalendar extends StatelessWidget {
  /// {@macro counter_page}
  const HomeCalendar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => HomeCubit(),
      child: const HomeWeekCalendar(),
    );
  }
}

class HomeWeekCalendar extends StatefulWidget {
  const HomeWeekCalendar({super.key});

  @override
  State<HomeWeekCalendar> createState() => _HomeWeekCalendarState();
}

class _HomeWeekCalendarState extends State<HomeWeekCalendar> {
  String activeDate = '13';
  @override
  Widget build(BuildContext context) {
    // 현재 날짜를 가져옵니다.
    DateTime currentDate = DateTime.now();

    // 이번 주의 시작 날짜와 마지막 날짜를 계산합니다.
    DateTime firstDayOfWeek =
        currentDate.subtract(Duration(days: currentDate.weekday - 1));
    DateTime lastDayOfWeek = firstDayOfWeek.add(Duration(days: 6));

    // 이번 주의 날짜와 요일을 계산합니다.
    List<CalendarWeeks> weeks = [
      CalendarWeeks(
        date: '11',
        day: 'Mon',
      ),
      CalendarWeeks(
        date: '12',
        day: 'Tue',
      ),
      CalendarWeeks(
        date: '13',
        day: 'Wed',
      ),
      CalendarWeeks(
        date: '14',
        day: 'Thu',
      ),
      CalendarWeeks(
        date: '15',
        day: 'Fri',
      ),
      CalendarWeeks(
        date: '16',
        day: 'Sat',
      ),
      CalendarWeeks(
        date: '17',
        day: 'Sun',
      ),
    ];

    // List<String> daysOfWeek = [];
    // List<String> datesOfWeek = [];
    // for (int i = 0; i < 7; i++) {
    //   DateTime currentDay = firstDayOfWeek.add(Duration(days: i));
    //   String dayOfWeek = DateFormat('EEEE').format(currentDay); // 요일
    //   String dateOfMonth = DateFormat('d').format(currentDay); // 날짜

    //   // weeks.add(newWe);
    //   daysOfWeek.add(dayOfWeek);
    //   datesOfWeek.add(dateOfMonth);
    // }

    // debugPrint(weeks.toString());

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            ...weeks.map((e) {
              // debugPrint(e.toString());
              return _buildDateButton(
                day: e.day ?? '',
                date: e.date ?? '',
                active: e.date == activeDate,
              );
            }).toList(),
          ],
        ),
      ),
    );
  }

  _buildDateButton({
    required String day,
    required String date,
    bool active = false,
  }) {
    TextStyle weekStyle = TextStyle(
      fontSize: 12,
      color: active ? Colors.white : Colors.black38,
    );
    TextStyle dateStyle = TextStyle(
      fontSize: 18,
      color: active ? Colors.white : Colors.black,
      fontWeight: FontWeight.w700,
    );

    return InkWell(
      onTap: () {
        setState(() {
          activeDate = date;
        });
        Get.find<PerCentController>().updateData();
      },
      child: Container(
        width: 70,
        height: 70,
        margin: const EdgeInsets.only(right: 7),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: active ? Theme.of(context).primaryColor : Color(0xFFF1F3FA),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              day,
              style: weekStyle,
            ),
            const SizedBox(height: 5),
            Text(
              date,
              style: dateStyle,
            ),
          ],
        ),
      ),
    );
  }
}
