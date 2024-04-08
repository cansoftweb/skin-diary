import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:skin_care_diary/module/home/home_observer.dart';
import 'package:skin_care_diary/navigation/tab_navigation.dart';
import 'package:skin_care_diary/routes.dart';
import 'package:skin_care_diary/screen/intro_screen.dart';
import 'package:skin_care_diary/theme.dart';

void main() {
  Bloc.observer = const HomeObserver();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      home: MaterialApp(
        // title: 'Flutter Demo',
        theme: appTheme,
        debugShowCheckedModeBanner: false,
        // home: MyHomePage(),
        routes: routes,
        home: const IntroScreen(),
      ),
    );
  }
}
