import 'package:flutter/material.dart';
import 'package:skin_care_diary/navigation/tab_navigation.dart';
import 'package:skin_care_diary/screen/gpt_screen.dart';

final Map<String, WidgetBuilder> routes = {
  MyHomePage.route(): (context) => MyHomePage(),
  GptScreen.route(): (context) => GptScreen(),
};
