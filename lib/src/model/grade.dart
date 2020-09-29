import 'dart:js_util';

import 'package:letter_grader/src/model/strategy/classical_strategy.dart';
import 'package:letter_grader/src/model/strategy/triage_strategy.dart';

class Grade {
  double _score;
  bool triage;

  Grade.fromPercentage(double percentage, {this.triage = false}) {
    _score = percentage / 100;
  }

  Grade.fromFraction(
      double numerator, //
      double denominator,
      {this.triage = false}) {
    _score = numerator / denominator;
  }

  String _getLetterGrade() {
    if (triage) {
      return TriageStrategy().getLetterGradeFromPercent(_score);
    } else {
      return ClassicalStrategy().getLetterGradeFromPercent(_score);
    }
  }

  String get letter => _getLetterGrade();
}
