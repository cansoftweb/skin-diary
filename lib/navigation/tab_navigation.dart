import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:skin_care_diary/asstes/icon/icon.dart';
import 'package:skin_care_diary/screen/beauty_screen.dart';
import 'package:skin_care_diary/screen/calendar_screen.dart';
import 'package:skin_care_diary/screen/home_screen.dart';
import 'package:skin_care_diary/screen/more_screen.dart';

class MyHomePage extends StatefulWidget {
  static String route() => '/home';
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;

  // 각 탭에 해당하는 화면들
  final List<Widget> _pages = [
    HomeScreen(),
    const CalendarScreen(),
    const BeautyScreen(),
    const MoreScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    String baseColor = '#999999';
    String activeColor = '#FF6693';

    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Bottom Navigation Bar 예제d'),
      // ),
      appBar: null,
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedLabelStyle: TextStyle(
          color: Theme.of(context).primaryColor,
          fontSize: 12,
        ),
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Theme.of(context).primaryColor,
        items: [
          BottomNavigationBarItem(
            icon: SvgPicture.string(iconHome(baseColor)),
            activeIcon: SvgPicture.string(iconHome(activeColor)),
            label: '홈',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.string(iconCalendar(baseColor)),
            activeIcon: SvgPicture.string(iconCalendar(activeColor)),
            label: '피부일지',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.string(iconBeauty(baseColor)),
            activeIcon: SvgPicture.string(iconBeauty(activeColor)),
            label: '뷰티룸',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.string(iconMore(baseColor)),
            activeIcon: SvgPicture.string(iconMore(activeColor)),
            label: '더보기',
          ),
        ],
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}
