import 'package:flutter/material.dart';
import 'package:letter_grader/src/view/grading_page.dart';

class Home extends StatefulWidget {
  Home({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    var body = GradingPage();
    print("Building Home");

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: body,
    );
  }
}
