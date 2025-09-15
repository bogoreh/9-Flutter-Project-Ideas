import '../utils/calculator_operations.dart';

class CalculatorModel {
  String _output = '0';
  String _expression = '';
  bool _shouldResetOutput = false;

  String get output => _output;
  String get expression => _expression;

  void appendNumber(String number) {
    if (_shouldResetOutput) {
      _output = number;
      _shouldResetOutput = false;
    } else {
      _output = _output == '0' ? number : _output + number;
    }
  }

  void appendOperator(String operator) {
    if (_shouldResetOutput) {
      _expression = _output + operator;
      _shouldResetOutput = false;
    } else {
      _expression = _expression + _output + operator;
      _output = '0';
    }
  }

  void calculate() {
    if (_expression.isNotEmpty) {
      String fullExpression = _expression + _output;
      _output = CalculatorOperations.evaluateExpression(fullExpression);
      _expression = '';
      _shouldResetOutput = true;
    }
  }

  void clear() {
    _output = '0';
    _expression = '';
    _shouldResetOutput = false;
  }

  void clearEntry() {
    _output = '0';
  }

  void delete() {
    if (_output.length > 1) {
      _output = _output.substring(0, _output.length - 1);
    } else {
      _output = '0';
    }
  }

  void percentage() {
    try {
      double value = double.parse(_output);
      _output = (value / 100).toString();
    } catch (e) {
      _output = 'Error';
    }
  }

  void toggleSign() {
    if (_output != '0') {
      if (_output.startsWith('-')) {
        _output = _output.substring(1);
      } else {
        _output = '-' + _output;
      }
    }
  }

  void addDecimal() {
    if (!_output.contains('.')) {
      _output = _output + '.';
    }
  }
}