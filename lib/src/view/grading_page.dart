import 'package:flutter/material.dart';
import 'package:letter_grader/src/view/result_page.dart';
import 'package:letter_grader/src/view/util.dart';

class GradingPage extends StatefulWidget {
  static const route = 'GradingPage';

  @override
  _GradingPageState createState() {
    return _GradingPageState();
  }
}

class _GradingPageState extends State<GradingPage> {
  final _formKey = GlobalKey<FormState>();

  static const percentMethod = 'Percent';
  static const fractionMethod = 'Fraction';
  static const validateZeroOrGreater = 'Must be zero or greater';
  static const validateNotEmpty = 'Cannot be empty';
  static const validateGreaterThanZero = 'Must be greater than zero';
  static const validateNumber = 'Must be a number';

  static const _inputDecoration = InputDecoration(
    border: OutlineInputBorder(),
    labelText: 'Enter a number',
  );

  double _numerator;
  double _denominator;
  double _percent;
  String _selectedMethod;
  bool _isTriaged;

  @override
  void initState() {
    super.initState();
    _selectedMethod = percentMethod;
    _isTriaged = false;
  }

  String Function(String) _numeratorValidator() {
    String validate(value) {
      if (value.isEmpty) {
        return validateNotEmpty;
      }
      double parsed = double.tryParse(value);
      if (parsed == null) {
        return validateNumber;
      }
      if (double.parse(value) < 0) {
        return validateZeroOrGreater;
      }
      return null;
    }

    return validate;
  }

  String Function(String) _denominatorValidator() {
    String validate(value) {
      if (value.isEmpty) {
        return validateNotEmpty;
      }
      double parsed = double.tryParse(value);
      if (parsed == null) {
        return validateNumber;
      }
      if (0 > parsed) {
        return validateGreaterThanZero;
      }
      return null;
    }

    return validate;
  }

  String Function(String) _percentValidator() {
    String validate(value) {
      if (value.isEmpty) {
        return validateNotEmpty;
      }
      double parsed = double.tryParse(value);
      if (parsed == null) {
        return validateNumber;
      }
      if (parsed < 0) {
        return validateZeroOrGreater;
      }
    }

    return validate;
  }

  Widget _buildMethodSelectDropdownFormButton() {
    return ButtonTheme(
      alignedDropdown: true,
      child: DropdownButton<String>(
        value: _selectedMethod,
        icon: Icon(Icons.arrow_drop_down),
        iconSize: 16,
        elevation: 16,
        style: TextStyle(color: Colors.blueAccent),
        onChanged: (value) {
          setState(
            () {
              _selectedMethod = value;
              _percent = null;
              _numerator = null;
              _denominator = null;
            },
          );
        },
        items: <String>[percentMethod, fractionMethod]
            .map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(value: value, child: Text(value));
        }).toList(),
      ),
    );
  }

  Widget _buildTriageGradingFormCheckBox() {
    return Checkbox(
      value: _isTriaged,
      onChanged: (value) => {
        setState(() {
          _isTriaged = value;
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

  Widget _buildNumeratorTextFormField() {
    return TextFormField(
      initialValue: "",
      decoration: _inputDecoration,
      validator: _numeratorValidator(),
      onSaved: (value) {
        _numerator = double.tryParse(value);
      },
    );
  }

  Widget _buildDenominatorTextFormField() {
    return TextFormField(
      initialValue: "",
      decoration: _inputDecoration,
      validator: _denominatorValidator(),
      onSaved: (value) {
        _denominator = double.tryParse(value);
      },
    );
  }

  Widget _buildPercentageTextFormField() {
    return TextFormField(
      initialValue: "",
      decoration: _inputDecoration,
      validator: _percentValidator(),
      onSaved: (value) {
        _percent = double.tryParse(value);
      },
    );
  }

  Route _percentRoute() {
    return routeWithSlideTransition(
      ResultPage(
        percent: _percent,
        isTriage: _isTriaged,
      ),
    );
  }

  Route _fractionRoute() {
    return routeWithSlideTransition(
      ResultPage(
        numerator: _numerator,
        denominator: _denominator,
      ),
    );
  }

  Widget _buildSubmitButton() {
    return RaisedButton(
      onPressed: () {
        if (_formKey.currentState.validate()) {
          _formKey.currentState.save();
          if (_percent != null) {
            Navigator.push(
              context,
              _percentRoute(),
            );
          } else {
            Navigator.push(
              context,
              _fractionRoute(),
            );
          }
        }
      },
      child: Text('Submit'),
      padding: EdgeInsets.all(16),
    );
  }

  Widget _buildPercentForm() {
    return Row(
      children: [
        Expanded(flex: 3, child: Container()),
        Expanded(flex: 3, child: _buildPercentageTextFormField()),
        Expanded(flex: 3, child: Text(' %', textScaleFactor: 2)),
      ],
      mainAxisAlignment: MainAxisAlignment.center,
    );
  }

  Widget _buildFractionForm() {
    return Column(
      children: [
        Row(
          children: [
            Expanded(flex: 3, child: Container()),
            Expanded(flex: 4, child: _buildNumeratorTextFormField()),
            Expanded(flex: 3, child: Container()),
          ],
        ),
        Padding(padding: EdgeInsets.all(8)),
        Row(
          children: [
            Expanded(flex: 3, child: Container()),
            Expanded(
                flex: 5, child: Divider(color: Colors.black87, thickness: 2)),
            Expanded(flex: 3, child: Container()),
          ],
        ),
        Padding(padding: EdgeInsets.all(8)),
        Row(
          children: [
            Expanded(flex: 3, child: Container()),
            Expanded(flex: 4, child: _buildDenominatorTextFormField()),
            Expanded(flex: 3, child: Container()),
          ],
        ),
      ],
    );
  }

  Widget _buildValueInputFormWidgets() {
    switch (_selectedMethod) {
      case percentMethod:
        {
          return _buildPercentForm();
        }
      case fractionMethod:
        {
          return _buildFractionForm();
        }
      default:
        {
          return _buildPercentForm();
        }
    }
  }

  Widget _buildPageContent() {
    return Column(
      children: [
        _buildMethodSelectDropdownFormButton(),
        Padding(padding: EdgeInsets.all(24)),
        _buildTriageGradingRow(),
        Padding(padding: EdgeInsets.all(24)),
        _buildValueInputFormWidgets(),
        Padding(padding: EdgeInsets.all(24)),
        _buildSubmitButton(),
      ],
      mainAxisAlignment: MainAxisAlignment.center,
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
        child: Form(child: _buildPageContent(), key: _formKey),
      ),
    );
  }
}
