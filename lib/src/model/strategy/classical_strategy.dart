import 'package:letter_grader/src/model/abstract/grading_strategy.dart';

class ClassicalStrategy extends GradingStrategy {
  static const _dBoundary = 0.6;
  static const _cBoundary = 0.7;
  static const _bBoundary = 0.8;
  static const _aBoundary = 0.9;

  ClassicalStrategy();

  @override
  String getLetterGradeFromPercent(double percent) {
    if (percent < _dBoundary) {
      return 'F';
    }
    if (percent < _cBoundary) {
      return 'D';
    }
    if (percent < _bBoundary) {
      return 'C';
    }
    if (percent < _aBoundary) {
      return 'B';
    } else {
      return 'A';
    }
  }
}
