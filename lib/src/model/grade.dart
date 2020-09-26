class Grade {
  String _letter;

  Grade.fromPercent(double percent) {
    _letter = _getLetterGradeFromPercent(percent);
  }

  Grade.fromFraction(double numerator, double denominator) {
    var percent = numerator / denominator;
    _letter = _getLetterGradeFromPercent(percent);
  }

  static String _getLetterGradeFromPercent(double percent) {
    if (percent < 0.6) {
      return 'F';
    }
    if (percent < 0.7) {
      return 'D';
    }
    if (percent < 0.8) {
      return 'C';
    }
    if (percent < 0.9) {
      return 'B';
    }
    return 'A';
  }

  String get letter => _letter;
}
