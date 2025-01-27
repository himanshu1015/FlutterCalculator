import 'package:flutter/material.dart';

class CalculatorButton extends StatelessWidget {
  final String buttonText;
  final VoidCallback onTap;

  CalculatorButton({required this.buttonText, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      key: ValueKey(buttonText),
      child: Padding(
        padding: const EdgeInsets.all(2.0),
        child: InkWell(
          onTap: onTap,
          child: Container(
            height: 90,
            decoration: BoxDecoration(
              color: Colors.white,
              // border: Border.all(color: Colors.grey),
            ),
            child: Center(
              child: Text(
                buttonText,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
