import 'package:flutter/material.dart';

void main() {
  runApp(SimpleCalculator());
}




class SimpleCalculator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Calculator',
      home: CalculatorHome(),
    );
  }
}




class CalculatorHome extends StatefulWidget {
  @override
  _CalculatorHomeState createState() => _CalculatorHomeState();
}

class _CalculatorHomeState extends State<CalculatorHome> {
  String _display = "0";
  String _operand = "";
  double? _firstNumber;
  double? _secondNumber;
  bool _shouldClearDisplay = false;

  void _clear() {
    setState(() {
      _display = "0";
      _operand = "";
      _firstNumber = null;
      _secondNumber = null;
      _shouldClearDisplay = false;
    });
  }

  void _appendNumber(String number) {
    setState(() {
      if (_shouldClearDisplay) {
        _display = number;
        _shouldClearDisplay = false;
      } else if (_display == "0") {
        _display = number;
      } else {
        _display += number;
      }
    });
  }

  void _setOperand(String operand) {
    setState(() {
      if (_firstNumber == null) {
        _firstNumber = double.tryParse(_display);
        _operand = operand;
        _shouldClearDisplay = true;
      } else if (_operand.isNotEmpty) {
        _calculate();
        _operand = operand;
        _shouldClearDisplay = true;
      }
    });
  }

  void _calculate() {
    setState(() {
      if (_firstNumber != null && _operand.isNotEmpty) {
        _secondNumber = double.tryParse(_display);
        if (_secondNumber != null) {
          switch (_operand) {
            case "+":
              _display = (_firstNumber! + _secondNumber!).toString();
              break;
            case "-":
              _display = (_firstNumber! - _secondNumber!).toString();
              break;
            case "X":
              _display = (_firstNumber! * _secondNumber!).toString();
              break;
            case "/":
              _display = _secondNumber != 0
                  ? (_firstNumber! / _secondNumber!).toString()
                  : "Error";
              break;
          }
          _firstNumber = double.tryParse(_display);
          _operand = "";
          _secondNumber = null;
          _shouldClearDisplay = true;
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculator'),
        backgroundColor: Colors.blue,
      ),
      body: Column(
        children: [
          Expanded(
            flex: 3,
            child: Container(
              color: Colors.white,
              alignment: Alignment.bottomRight,
              padding: const EdgeInsets.all(20),
              child: Text(
                _display,
                style: const TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 5,
            child: Container(
              color: Colors.grey[200],
              child: Column(
                children: [
                  _buildButtonRow(["7", "8", "9", "/"]),
                  _buildButtonRow(["4", "5", "6", "X"]),
                  _buildButtonRow(["1", "2", "3", "-"]),
                  _buildButtonRow(["0", ".", "00", "+"]),
                  _buildButtonRow(["CLEAR", "="]),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildButtonRow(List<String> buttons) {
    return Expanded(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: buttons
            .map(
              (button) => Expanded(
                key: ValueKey(button), 
                child: Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: InkWell(
                    onTap: () {
                      if (button == "CLEAR") {
                        _clear();
                      } else if (button == "=") {
                        _calculate();
                      } else if (["+", "-", "X", "/"].contains(button)) {
                        _setOperand(button);
                      } else {
                        _appendNumber(button);
                      }
                    },
                    child: Container(
                      height: 80,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        // border: Border.all(color: Colors.grey),
                      ),
                      child: Center(
                        child: Text(
                          button,
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}
