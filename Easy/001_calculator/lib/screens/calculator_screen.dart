import 'package:flutter/material.dart';
import '../models/calculator_model.dart';
import '../widgets/calculator_button.dart';

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  final CalculatorModel _calculator = CalculatorModel();

  void _onButtonPressed(String buttonText) {
    setState(() {
      switch (buttonText) {
        case 'C':
          _calculator.clear();
          break;
        case 'CE':
          _calculator.clearEntry();
          break;
        case '⌫':
          _calculator.delete();
          break;
        case '%':
          _calculator.percentage();
          break;
        case '±':
          _calculator.toggleSign();
          break;
        case '=':
          _calculator.calculate();
          break;
        case '.':
          _calculator.addDecimal();
          break;
        case '+':
        case '-':
        case '×':
        case '÷':
          _calculator.appendOperator(buttonText);
          break;
        default:
          if (RegExp(r'[0-9]').hasMatch(buttonText)) {
            _calculator.appendNumber(buttonText);
          }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: [
            // Display area
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      _calculator.expression,
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 24,
                      ),
                      textAlign: TextAlign.right,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      _calculator.output,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 48,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.right,
                    ),
                  ],
                ),
              ),
            ),
            
            // Buttons area
            Expanded(
              flex: 2,
              child: GridView.count(
                crossAxisCount: 4,
                padding: const EdgeInsets.all(16),
                childAspectRatio: 0.8,
                children: [
                  // Row 1
                  CalculatorButton(
                    text: 'C',
                    backgroundColor: Colors.grey[300]!,
                    onPressed: () => _onButtonPressed('C'),
                  ),
                  CalculatorButton(
                    text: 'CE',
                    backgroundColor: Colors.grey[300]!,
                    onPressed: () => _onButtonPressed('CE'),
                  ),
                  CalculatorButton(
                    text: '⌫',
                    backgroundColor: Colors.grey[300]!,
                    onPressed: () => _onButtonPressed('⌫'),
                  ),
                  CalculatorButton(
                    text: '÷',
                    backgroundColor: Colors.orange,
                    textColor: Colors.white,
                    onPressed: () => _onButtonPressed('÷'),
                  ),
                  
                  // Row 2
                  CalculatorButton(
                    text: '7',
                    onPressed: () => _onButtonPressed('7'),
                  ),
                  CalculatorButton(
                    text: '8',
                    onPressed: () => _onButtonPressed('8'),
                  ),
                  CalculatorButton(
                    text: '9',
                    onPressed: () => _onButtonPressed('9'),
                  ),
                  CalculatorButton(
                    text: '×',
                    backgroundColor: Colors.orange,
                    textColor: Colors.white,
                    onPressed: () => _onButtonPressed('×'),
                  ),
                  
                  // Row 3
                  CalculatorButton(
                    text: '4',
                    onPressed: () => _onButtonPressed('4'),
                  ),
                  CalculatorButton(
                    text: '5',
                    onPressed: () => _onButtonPressed('5'),
                  ),
                  CalculatorButton(
                    text: '6',
                    onPressed: () => _onButtonPressed('6'),
                  ),
                  CalculatorButton(
                    text: '-',
                    backgroundColor: Colors.orange,
                    textColor: Colors.white,
                    onPressed: () => _onButtonPressed('-'),
                  ),
                  
                  // Row 4
                  CalculatorButton(
                    text: '1',
                    onPressed: () => _onButtonPressed('1'),
                  ),
                  CalculatorButton(
                    text: '2',
                    onPressed: () => _onButtonPressed('2'),
                  ),
                  CalculatorButton(
                    text: '3',
                    onPressed: () => _onButtonPressed('3'),
                  ),
                  CalculatorButton(
                    text: '+',
                    backgroundColor: Colors.orange,
                    textColor: Colors.white,
                    onPressed: () => _onButtonPressed('+'),
                  ),
                  
                  // Row 5
                  CalculatorButton(
                    text: '±',
                    onPressed: () => _onButtonPressed('±'),
                  ),
                  CalculatorButton(
                    text: '0',
                    onPressed: () => _onButtonPressed('0'),
                  ),
                  CalculatorButton(
                    text: '.',
                    onPressed: () => _onButtonPressed('.'),
                  ),
                  CalculatorButton(
                    text: '=',
                    backgroundColor: Colors.orange,
                    textColor: Colors.white,
                    onPressed: () => _onButtonPressed('='),
                  ),
                  
                  // Row 6 - Percentage button
                  CalculatorButton(
                    text: '%',
                    onPressed: () => _onButtonPressed('%'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}