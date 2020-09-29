import 'package:letter_grader/src/model/abstract/grading_strategy.dart';
import 'package:letter_grader/src/model/strategy/classical_strategy.dart';
import 'package:letter_grader/src/model/strategy/triage_strategy.dart';

class Grade {
  double _score;
  GradingStrategy gradingStrategy;

  Grade.fromPercentage(double percentage, {isTriage = false}) {
    _score = percentage / 100;
    this.isTriage = isTriage;
  }

  Grade.fromFraction(
      double numerator, //
      double denominator,
      {isTriage = false}) {
    _score = numerator / denominator;
    this.isTriage = isTriage;
  }

  String get letter => gradingStrategy.getLetterGradeFromPercent(_score);

  set isTriage(bool isTriage) {
    if (isTriage) {
      gradingStrategy = TriageStrategy();
    } else {
      gradingStrategy = ClassicalStrategy();
    }
  }
}
