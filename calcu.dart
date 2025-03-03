import 'package:flutter/material.dart';

void main() {
  runApp(const CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  const CalculatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Colors.black,
        primaryColor: Colors.blueAccent,
      ),
      home: const CalculatorScreen(),
    );
  }
}

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String output = "0";
  String _output = "0";
  double num1 = 0;
  double num2 = 0;
  String operand = "";

  void buttonPressed(String buttonText) {
    if (buttonText == "C") {
      _output = "0";
      num1 = 0;
      num2 = 0;
      operand = "";
    } else if (buttonText == "=") {
      num2 = double.parse(output);
      if (operand == "+") {
        _output = (num1 + num2).toString();
      } else if (operand == "-") {
        _output = (num1 - num2).toString();
      } else if (operand == "*") {
        _output = (num1 * num2).toString();
      } else if (operand == "/") {
        _output = (num1 / num2).toString();
      }
      num1 = 0;
      num2 = 0;
      operand = "";
    } else if (["+", "-", "*", "/"].contains(buttonText)) {
      num1 = double.parse(output);
      operand = buttonText;
      _output = "0";
    } else {
      _output = _output == "0" ? buttonText : _output + buttonText;
    }
    setState(() {
      output = _output;
    });
  }

  Widget buildButton(String buttonText, {Color? color}) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ElevatedButton(
          onPressed: () => buttonPressed(buttonText),
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 20),
            backgroundColor: color ?? Colors.grey[800],
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
          ),
          child: Text(
            buttonText,
            style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Calculator"),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      body: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 12),
            child: Text(
              output,
              style: const TextStyle(fontSize: 56.0, fontWeight: FontWeight.bold, color: Colors.white),
            ),
          ),
          const Divider(color: Colors.white),
          Column(
            children: [
              Row(children: ["7", "8", "9", "/"].map((text) => buildButton(text, color: Colors.blueGrey)).toList()),
              Row(children: ["4", "5", "6", "*"].map((text) => buildButton(text, color: Colors.blueGrey)).toList()),
              Row(children: ["1", "2", "3", "-"].map((text) => buildButton(text, color: Colors.blueGrey)).toList()),
              Row(children: ["C", "0", "=", "+"].map((text) => buildButton(text, color: text == "C" ? Colors.red : Colors.orange)).toList()),
            ],
          )
        ],
      ),
    );
  }
}
