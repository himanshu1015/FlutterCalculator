// lib/utils/calculator_logic.dart
class CalculatorLogic {
  double firstNumber = 0.0;
  double secondNumber = 0.0;
  String operand = "";
  
  String calculate() {
    switch (operand) {
      case "+":
        return (firstNumber + secondNumber).toString();
      case "-":
        return (firstNumber - secondNumber).toString();
      case "X":
        return (firstNumber * secondNumber).toString();
      case "/":
        return secondNumber != 0 ? (firstNumber / secondNumber).toString() : "Error";
      default:
        return "0";
    }
  }
}
