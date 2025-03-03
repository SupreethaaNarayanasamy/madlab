//quiz app
//no dependencies.
import 'dart:async';
import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(home: QuizApp()));

class QuizApp extends StatefulWidget {
  @override
  _QuizAppState createState() => _QuizAppState();
}

class _QuizAppState extends State<QuizApp> {
  List questions = [
    {"q": "Flutter is developed by Google?", "a": true},
    {"q": "Dart is used in Flutter?", "a": true},
    {"q": "Flutter is only for Android?", "a": false}
  ];
  int index = 0, score = 0, seconds = 10;
  late Timer timer;

  void startTimer() {
    timer = Timer.periodic(Duration(seconds: 1), (t) {
      if (seconds > 0) {
        setState(() => seconds--);
      } else {
        nextQuestion();
      }
    });
  }

  void checkAnswer(bool answer) {
    if (questions[index]['a'] == answer) score++;
    nextQuestion();
  }

  void nextQuestion() {
    timer.cancel();
    if (index < questions.length - 1) {
      setState(() {
        index++;
        seconds = 10;
      });
      startTimer();
    } else {
      showDialog(
          context: context,
          builder: (_) => AlertDialog(
            title: Text("Quiz Over"),
            content: Text("Score: $score"),
            actions: [TextButton(onPressed: () => resetQuiz(), child: Text("Retry"))],
          ));
    }
  }

  void resetQuiz() {
    setState(() {
      index = 0;
      score = 0;
      seconds = 10;
    });
    Navigator.pop(context);
    startTimer();
  }

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Quiz App")),
        body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text("Time Left: $seconds", style: TextStyle(fontSize: 20)),
          Padding(
              padding: EdgeInsets.all(20),
              child: Text(questions[index]['q'], style: TextStyle(fontSize: 24))),
          Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
            ElevatedButton(onPressed: () => checkAnswer(true), child: Text("True")),
            ElevatedButton(onPressed: () => checkAnswer(false), child: Text("False"))
          ])
        ]));
  }
}
