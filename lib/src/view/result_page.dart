import 'package:flutter/material.dart';
import 'package:letter_grader/src/model/grade.dart';
import 'package:letter_grader/src/view/grading_page.dart';

class ResultPage extends StatefulWidget {
  final double percent;
  final double numerator;
  final double denominator;
  final bool isTriage;

  ResultPage({
    this.percent,
    this.numerator,
    this.denominator,
    this.isTriage = false,
  })  : assert(percent != null || (numerator != null && denominator != null)),
        assert(percent != null ? percent >= 0.0 : true),
        assert(numerator != null ? numerator >= 0.0 : true),
        assert(denominator != null ? denominator > 0 : true);

  @override
  _ResultPageState createState() {
    return _ResultPageState(percent, numerator, denominator, isTriage);
  }
}

class _ResultPageState extends State<ResultPage> {
  double _percent;
  double _numerator;
  double _denominator;
  bool _isTriage;

  _ResultPageState(
      double percent, double numerator, double denominator, bool isTriage) {
    _percent = percent;
    _numerator = numerator;
    _denominator = denominator;
    _isTriage = isTriage;
  }

  String _getDisplayedScore() {
    if (_percent != null) {
      return _percent.toStringAsFixed(1) + " %";
    } else {
      return _numerator.toStringAsFixed(1) +
          ' / ' +
          _denominator.toStringAsFixed(1);
    }
  }

  Grade _getGrade() {
    var grade;
    if (_percent != null) {
      grade = Grade.fromPercentage(_percent, isTriage: _isTriage);
    } else {
      grade = Grade.fromFraction(_numerator, _denominator, isTriage: _isTriage);
    }
    return grade;
  }

  Widget _buildTriageGradingFormCheckBox() {
    return Checkbox(
      value: _isTriage,
      onChanged: (value) => {
        setState(() {
          _isTriage = value;
        })
      },
    );
  }

  Widget _buildTriageGradingRow() {
    return Row(
      children: [
        _buildTriageGradingFormCheckBox(),
        Padding(padding: EdgeInsets.all(1)),
        Text("Triage Grading?"),
      ],
      mainAxisAlignment: MainAxisAlignment.center,
    );
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
        Navigator.pop(context);
      },
      child: Text('Return'),
    );
  }

  Widget _buildContent() {
    return Column(
      children: [
        _buildTriageGradingRow(),
        Padding(padding: EdgeInsets.all(24)),
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
