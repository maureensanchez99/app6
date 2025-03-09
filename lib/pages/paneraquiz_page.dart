import 'package:flutter/material.dart';

class PaneraQuiz extends StatelessWidget {
  const PaneraQuiz({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 101, 112, 0),
        title: const Text(
          'Panera Menu Quiz for Engineers!',
          style: TextStyle(
              color: Color.fromARGB(255, 208, 186, 177),
              fontSize: 40,
              fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
      ),
      backgroundColor: Colors.brown[100],
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

  void reset() {
    setState(() {
      n = 0;
      correctQuestions = 0;
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
              BreakfastQuestion(
                function: incrementQuestions,
                nextFunction: nextPage,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
                child: Text(
                  "SCORE: $correctQuestions",
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
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SnackQuestion(
                function: incrementQuestions,
                nextFunction: nextPage,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
                child: Text(
                  "SCORE: $correctQuestions",
                  style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic),
                ),
              )
            ],
          );
        }
      case 3:
        {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              LunchQuestion(
                function: incrementQuestions,
                nextFunction: nextPage,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
                child: Text(
                  "SCORE: $correctQuestions",
                  style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic),
                ),
              )
            ],
          );
        }
      case 4:
        {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              DinnerQuestion(
                function: incrementQuestions,
                nextFunction: nextPage,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
                child: Text(
                  "SCORE: $correctQuestions",
                  style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic),
                ),
              )
            ],
          );
        }
      case 5:
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
                  "SCORE: $correctQuestions",
                  style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic),
                ),
              )
            ],
          );
        }
      case 6:
        {
          return EndScreen(
            function: reset,
            score: correctQuestions,
          );
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

class BreakfastQuestion extends StatefulWidget {
  Function? function;
  Function? nextFunction;
  BreakfastQuestion({super.key, this.function, this.nextFunction});

  @override
  State<BreakfastQuestion> createState() => _BreakfastQuestion();
}

class _BreakfastQuestion extends State<BreakfastQuestion> {
  bool answered = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 0, 0, 30),
          child: Text.rich(TextSpan(
              text: "What would an Engineer eat for ",
              style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
              children: [
                TextSpan(
                    text: 'Breakfast',
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
                              child: Image.asset('assets/bagels.png',
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
                            child: Image.asset('assets/oats.png',
                                fit: BoxFit.fill, width: 200),
                          ),
                        ),
                        Text(
                          'OATS!',
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
                            child: Image.asset('assets/fruits.png',
                                fit: BoxFit.fill, width: 200),
                          ),
                        ),
                        Text(
                          'FRUITS!',
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
                          child: Image.asset('assets/dietPepsi.png',
                              fit: BoxFit.fill, width: 200),
                        ),
                      ),
                      Text(
                        'NOTHING!',
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

class SnackQuestion extends StatefulWidget {
  Function? function;
  Function? nextFunction;
  SnackQuestion({super.key, this.function, this.nextFunction});

  @override
  State<SnackQuestion> createState() => _SnackQuestion();
}

class _SnackQuestion extends State<SnackQuestion> {
  bool answered = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 0, 0, 30),
          child: Text.rich(TextSpan(
              text: "What can an Engineer Snack on ",
              style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
              children: [
                TextSpan(
                    text: 'in Class',
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
                              child: Image.asset('assets/mac.png',
                                  fit: BoxFit.fill, width: 200),
                            ),
                          ),
                          Text(
                            'MAC & CHEESE!',
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
                            child: Image.asset('assets/sandwich1.png',
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
                            child: Image.asset('assets/salad1.png',
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
                          child: Image.asset('assets/pepsi.png',
                              fit: BoxFit.fill, width: 200),
                        ),
                      ),
                      Text(
                        'NON-DIET PEPSI!',
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

class LunchQuestion extends StatefulWidget {
  Function? function;
  Function? nextFunction;
  LunchQuestion({super.key, this.function, this.nextFunction});

  @override
  State<LunchQuestion> createState() => _LunchQuestion();
}

class _LunchQuestion extends State<LunchQuestion> {
  bool answered = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 0, 0, 30),
          child: Text.rich(TextSpan(
              text: "Which drink do Engineers pick to be ",
              style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
              children: [
                TextSpan(
                    text: 'Healthy',
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
                              child: Image.asset('assets/soup1.png',
                                  fit: BoxFit.fill, width: 200),
                            ),
                          ),
                          Text(
                            'SOUP!',
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
                            child: Image.asset('assets/pepsi.png',
                                fit: BoxFit.fill, width: 200),
                          ),
                        ),
                        Text(
                          'PEPSI!',
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
                            child: Image.asset('assets/dietPepsi.png',
                                fit: BoxFit.fill, width: 200),
                          ),
                        ),
                        Text(
                          'DIET-PEPSI!',
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
                          child: Image.asset('assets/sbSmoothie.png',
                              fit: BoxFit.fill, width: 200),
                        ),
                      ),
                      Text(
                        'S.B. SMOOTHIE!',
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

class DinnerQuestion extends StatefulWidget {
  Function? function;
  Function? nextFunction;
  DinnerQuestion({super.key, this.function, this.nextFunction});

  @override
  State<DinnerQuestion> createState() => _DinnerQuestion();
}

class _DinnerQuestion extends State<DinnerQuestion> {
  bool answered = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 0, 0, 30),
          child: Text.rich(TextSpan(
              text: "What is the ",
              style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
              children: [
                TextSpan(
                    text: 'MOST EFFICIENT',
                    style: TextStyle(
                      fontStyle: FontStyle.italic,
                      decoration: TextDecoration.underline,
                    )),
                TextSpan(
                  text: ' Engineer Dinner?',
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
                              child: Image.asset('assets/sandwich2.png',
                                  fit: BoxFit.fill, width: 200),
                            ),
                          ),
                          Text(
                            'SANDWICH!!',
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
                            child: Image.asset('assets/salad2.png',
                                fit: BoxFit.fill, width: 200),
                          ),
                        ),
                        Text(
                          'SALAD!',
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
                            child: Image.asset('assets/pastries.png',
                                fit: BoxFit.fill, width: 200),
                          ),
                        ),
                        Text(
                          'PASTIRES!!!',
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
                          child: Image.asset('assets/soup2.png',
                              fit: BoxFit.fill, width: 200),
                        ),
                      ),
                      Text(
                        'SOUP!',
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
                          'CAFFEINE!',
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

class EndScreen extends StatefulWidget {
  Function? function;
  int? score;
  EndScreen({super.key, this.function, this.score});

  @override
  State<EndScreen> createState() => _EndScreen();
}

class _EndScreen extends State<EndScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset("assets/paneraLogo.png"),
        widget.score == 1
            ? Text(
                "You Scored ${widget.score} Point!",
                style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
              )
            : Text(
                "You Scored ${widget.score} Points!",
                style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
              ),
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: TextButton(
              onPressed: () => widget.function!(),
              child: Text(
                "RESTART?",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              )),
        )
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
