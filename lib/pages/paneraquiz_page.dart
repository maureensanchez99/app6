import 'package:flutter/material.dart';

class PaneraQuiz extends StatelessWidget {
  const PaneraQuiz({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 101, 112, 0),
        title: const Text(
          'Panera Quiz Challenge',
          style: TextStyle(
              color: Color.fromARGB(255, 228, 228, 228),
              fontSize: 40,
              fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
      ),
      body: const Center(
        child: Quiz(),
      ),
    );
  }
}

class Quiz extends StatefulWidget {
  const Quiz({super.key});
  @override
  State<Quiz> createState() => _Quiz();
}

class _Quiz extends State<Quiz> {
  int correctQuestions = 0;
  bool started = false;
  int n = 0;

  void incrementQuestions() {
    setState(() {
      correctQuestions++;
    });
  }

  void nextPage() {
    setState(() {
      n++;
    });
  }

  @override
  Widget build(BuildContext context) {
    switch (n) {
      case 0:
        {
          return StartScreen(
            function: nextPage,
          );
        }

      case 1:
        {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              DrinkQuestion(
                function: incrementQuestions,
                nextFunction: nextPage,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
                child: Text(
                  "SCORE: $correctQuestions and n: $n",
                  style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic),
                ),
              )
            ],
          );
        }
      case 2:
        {
          return Text('Page 3');
        }

      default:
        return StartScreen(
          function: nextPage,
        );
    } //StartScreen(function: startQuiz,);
  }
}

class StartScreen extends StatefulWidget {
  Function? function;
  StartScreen({super.key, this.function});

  @override
  State<StartScreen> createState() => _StartScreen();
}

class _StartScreen extends State<StartScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset("assets/paneraLogo.png"),
        Text(
          "Let's learn about an Engineering Diet at Panera!",
          style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
        ),
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: TextButton(
              onPressed: () => widget.function!(),
              child: Text(
                "START",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              )),
        )
      ],
    );
  }
}

class DrinkQuestion extends StatefulWidget {
  Function? function;
  Function? nextFunction;
  DrinkQuestion({super.key, this.function, this.nextFunction});

  @override
  State<DrinkQuestion> createState() => _DrinkQuestion();
}

class _DrinkQuestion extends State<DrinkQuestion> {
  bool answered = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 0, 0, 30),
          child: Text.rich(TextSpan(
              text: "What do Engineers Binge during ",
              style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
              children: [
                TextSpan(
                    text: 'Finals Week',
                    style: TextStyle(
                      fontStyle: FontStyle.italic,
                      decoration: TextDecoration.underline,
                    )),
                TextSpan(
                  text: '?',
                )
              ])),
        ),
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 50),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 80, 0),
                    child: OutlinedButton(
                      onPressed: answered
                          ? null
                          : () => {
                                answered = true,
                                incorrectAnswer(context, widget.nextFunction),
                                setState(() {})
                              },
                      style: ButtonStyle(
                          shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)))),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: Image.asset('assets/coffee.png',
                                  fit: BoxFit.fill, width: 200),
                            ),
                          ),
                          Text(
                            'SALADS!',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18),
                          ),
                        ],
                      ),
                    ),
                  ),
                  OutlinedButton(
                    onPressed: answered
                        ? null
                        : () => {
                              widget.function!(),
                              answered = true,
                              correctAnswer(context, widget.nextFunction)
                            },
                    style: ButtonStyle(
                        shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)))),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: Image.asset('assets/coffee.png',
                                fit: BoxFit.fill, width: 200),
                          ),
                        ),
                        Text(
                          'CAFFIENE!',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 80, 0),
                  child: OutlinedButton(
                    onPressed: answered
                        ? null
                        : () => {
                              answered = true,
                              incorrectAnswer(context, widget.nextFunction),
                              setState(() {})
                            },
                    style: ButtonStyle(
                        shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)))),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: Image.asset('assets/coffee.png',
                                fit: BoxFit.fill, width: 200),
                          ),
                        ),
                        Text(
                          'SANDWICHES!',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                      ],
                    ),
                  ),
                ),
                OutlinedButton(
                  onPressed: answered
                      ? null
                      : () => {
                            answered = true,
                            incorrectAnswer(context, widget.nextFunction),
                            setState(() {})
                          },
                  style: ButtonStyle(
                      shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)))),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: Image.asset('assets/coffee.png',
                              fit: BoxFit.fill, width: 200),
                        ),
                      ),
                      Text(
                        'BAGELS!',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ],
    );
  }
}

Future<void> correctAnswer(BuildContext context, Function? function) {
  return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Correct!",
              style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center),
          content: Text(
            "One point for you!",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            textAlign: TextAlign.center,
          ),
          actions: [
            TextButton(
              onPressed: () {
                function!();
                Navigator.of(context).pop();
              },
              child: Text(
                'Next Question',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
            )
          ],
        );
      });
}

Future<void> incorrectAnswer(BuildContext context, Function? function) {
  return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("WRONG!",
              style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center),
          content: Text(
            "No points for you!",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            textAlign: TextAlign.center,
          ),
          actions: [
            TextButton(
              onPressed: () {
                function!();
                Navigator.of(context).pop();
              },
              child: Text(
                'Next Question',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
            )
          ],
        );
      });
}
