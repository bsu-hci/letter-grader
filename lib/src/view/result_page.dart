import 'package:flutter/material.dart';
import 'package:letter_grader/src/model/grade.dart';
import 'package:letter_grader/src/view/grading_page.dart';

class ResultPage extends StatefulWidget {
  double _percent;
  double _numerator;
  double _denominator;

  ResultPage.fromPercent(double percent) {
    _percent = percent;
  }

  ResultPage.fromFraction(double numerator, double denominator) {
    _numerator = numerator;
    _denominator = denominator;
  }

  @override
  _ResultPageState createState() {
    return _ResultPageState(_percent, _numerator, _denominator);
  }
}

class _ResultPageState extends State<ResultPage> {
  double _percent;
  double _numerator;
  double _denominator;

  _ResultPageState(double percent, double numerator, double denominator) {
    _percent = percent;
    _numerator = numerator;
    _denominator = denominator;
  }

  String _getDisplayedScore() {
    if (_percent != null) {
      return _percent.toStringAsFixed(1);
    } else {
      return _numerator.toStringAsFixed(1) +
          ' / ' +
          _denominator.toStringAsFixed(1);
    }
  }

  Grade _getGrade() {
    var grade;
    if (_percent != null) {
      grade = Grade.fromPercentage(_percent);
    } else {
      grade = Grade.fromFraction(_numerator, _denominator);
    }
    return grade;
  }

  Widget _buildDisplayedScoreText() {
    return Text(
      _getDisplayedScore(),
      textScaleFactor: 1.2,
      textAlign: TextAlign.center,
    );
  }

  Widget _buildLetterText() {
    return Text(
      _getGrade().letter,
      textScaleFactor: 3,
    );
  }

  Widget _buildBackButton() {
    return RaisedButton(
      onPressed: () {
        Navigator.pushNamed(context, GradingPage.route);
      },
      child: Text('Return'),
    );
  }

  Widget _buildContent() {
    return Column(
      children: [
        Row(
          children: [
            Expanded(flex: 3, child: Container()),
            Expanded(flex: 4, child: _buildDisplayedScoreText()),
            Expanded(flex: 3, child: Container()),
          ],
        ),
        Padding(padding: EdgeInsets.all(12)),
        _buildLetterText(),
        Padding(padding: EdgeInsets.all(24)),
        _buildBackButton(),
      ],
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
    );
  }

  @override
  build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Letter Grader'),
      ),
      body: Padding(
        padding: EdgeInsets.all(24),
        child: _buildContent(),
      ),
    );
  }
}
