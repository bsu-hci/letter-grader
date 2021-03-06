import 'package:flutter/material.dart';
import 'package:letter_grader/src/view/grading_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Letter Grader',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: GradingPage(),
      routes: {
        GradingPage.route: (BuildContext context) => GradingPage(),
      },
    );
  }
}
