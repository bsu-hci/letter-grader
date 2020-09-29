import 'package:letter_grader/src/model/abstract/grading_strategy.dart';

class TriageStrategy extends GradingStrategy {
  static const _dBoundary = 7.0 / 15.0;
  static const _cBoundary = 2.0 / 3.0;
  static const _bBoundary = 5.0 / 6.0;
  static const _aBoundary = 17.0 / 18.0;

  TriageStrategy() {}

  @override
  String getLetterGradeFromPercent(double percent) {
    if (percent <= _dBoundary) {
      return 'F';
    }
    if (percent <= _cBoundary) {
      return 'D';
    }
    if (percent <= _bBoundary) {
      return 'C';
    }
    if (percent <= _aBoundary) {
      return 'B';
    } else {
      return 'A';
    }
  }
}
