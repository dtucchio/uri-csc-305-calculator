//
// Dominic Tucchio [dtucchio@uri.edu]
// CSC 305 - Software Engineering
// Assignment 2
//

import 'package:flutter/material.dart';
import 'package:expressions/expressions.dart';

class Calculator extends StatefulWidget {
  const Calculator({super.key});

  @override
  State<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  String _expression = '';
  String _result = '';

  void _onPressed(String value) {
    setState(() {
      if (value == 'C') {
        _expression = '';
        _result = '';
      } else if (value == '=') {
        try {
          final expression = Expression.parse(_expression);
          const evaluator = ExpressionEvaluator();
          final result = evaluator.eval(expression, {});
          _result = result.toString();
        } catch (e) {
          _result = 'Error';
        }
      } else if (value == 'x²') {
        try {
          final expression = Expression.parse('($_expression) * ($_expression)');
          const evaluator = ExpressionEvaluator();
          final result = evaluator.eval(expression, {});
          _expression = result.toString();
          _result = _expression;
        } catch (e) {
          _result = 'Error';
        }
      } else {
        _expression += value;
      }
    });
  }

  Widget _buildButton(String value, {Color? color, Color? textColor, double padding = 20}) {
    return Expanded(
      child: ElevatedButton(
        onPressed: () => _onPressed(value),
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.all(padding),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          backgroundColor: color ?? Colors.grey[700],
        ),
        child: Text(value, style: TextStyle(fontSize: 24, color: textColor ?? Colors.white)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dominic Tucchio\'s Calculator'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Flexible(
              child: Container(
                alignment: Alignment.bottomRight,
                child: Text(
                  _expression,
                  style: const TextStyle(fontSize: 32),
                  textAlign: TextAlign.right,
                ),
              ),
            ),
            Flexible(
              child: Container(
                alignment: Alignment.bottomRight,
                child: Text(
                  _result,
                  style: const TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.right,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              flex: 3,
              child: Column(
                children: [
                  Row(
                    children: [
                      _buildButton('C', color: Colors.grey, padding: 10),
                      const Spacer(),
                      const SizedBox(width: 8),
                      _buildButton('%', color: Colors.orange, padding: 10),
                      const SizedBox(width: 8),
                      _buildButton('x²', color: Colors.orange, padding: 10),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Expanded(
                    child: Row(
                      children: [
                        _buildButton('7'),
                        const SizedBox(width: 8),
                        _buildButton('8'),
                        const SizedBox(width: 8),
                        _buildButton('9'),
                        const SizedBox(width: 8),
                        _buildButton('/', color: Colors.orange),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Row(
                      children: [
                        _buildButton('4'),
                        const SizedBox(width: 8),
                        _buildButton('5'),
                        const SizedBox(width: 8),
                        _buildButton('6'),
                        const SizedBox(width: 8),
                        _buildButton('*', color: Colors.orange),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Row(
                      children: [
                        _buildButton('1'),
                        const SizedBox(width: 8),
                        _buildButton('2'),
                        const SizedBox(width: 8),
                        _buildButton('3'),
                        const SizedBox(width: 8),
                        _buildButton('-', color: Colors.orange),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Row(
                      children: [
                        _buildButton('.'),
                        const SizedBox(width: 8),
                        _buildButton('0'),
                        const SizedBox(width: 8),
                        _buildButton('=', color: Colors.orange),
                        const SizedBox(width: 8),
                        _buildButton('+', color: Colors.orange),
                      ],
                    ),
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