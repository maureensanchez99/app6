import 'dart:async';
import 'package:flutter/material.dart';

void main() {
  runApp(const PopQuiz());
}

class PopQuiz extends StatelessWidget {
  const PopQuiz({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'LSU PFT Quiz',
      theme: ThemeData(
        primaryColor: const Color(0xFF461D7C), // LSU Purple
        scaffoldBackgroundColor: const Color(0xFFFDD023), // LSU Gold
      ),
      home: const QuizScreen(),
    );
  }
}

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  final List<Map<String, dynamic>> questions = [
    {
      'question': 'Who is Patrick F. Taylor Hall named after?',
      'options': [
        'A former LSU president',
        'An LSU engineering alumnus',
        'A state governor',
        'A philanthropist'
      ],
      'answerIndex': 1,
    },
    {
      'question': 'What is the largest academic building in Louisiana?',
      'options': [
        'RoyOMartin Auditorium',
        'Cambre Atrium',
        'Patrick F. Taylor Hall',
        'Dow Lab'
      ],
      'answerIndex': 2,
    },
    {
      'question': 'How much did the PFT renovation cost?',
      'options': ['\$50M', '\$75M', '\$114M', '\$200M'],
      'answerIndex': 2,
    },
    {
      'question': 'Where is Panera Bread located in PFT?',
      'options': [
        'Capstone Gallery',
        'The Commons',
        'Cambre Atrium',
        'Brookshire Suite'
      ],
      'answerIndex': 1,
    },
    {
      'question': 'What is the largest classroom in PFT?',
      'options': [
        'Cambre Atrium',
        'RoyOMartin Auditorium',
        'Chevron Center',
        'Dow Incubator'
      ],
      'answerIndex': 1,
    },
    {
      'question': 'What company funded the Sustainable Living Lab?',
      'options': ['Chevron', 'ExxonMobil', 'BASF', 'Shell'],
      'answerIndex': 2,
    },
    {
      'question':
          'What is the purpose of the Dow Chemical Unit Operations Lab?',
      'options': [
        'To study robotics',
        'To perform chemical process experiments',
        'To research sustainable living',
        'To build computer processors'
      ],
      'answerIndex': 1,
    },
    {
      'question': 'Which lab in PFT allows students to test driving behaviors?',
      'options': [
        'Robotics Lab',
        'Civil Engineering Driving Simulator Lab',
        'BASF Sustainable Living Lab',
        'Proto Lab'
      ],
      'answerIndex': 1,
    },
    {
      'question':
          'Which space in PFT is a central hub for student organizations?',
      'options': [
        'The Commons',
        'Cambre Atrium',
        'RoyOMartin Auditorium',
        'Dow Student Leadership Incubator'
      ],
      'answerIndex': 3,
    },
    {
      'question': 'What feature makes the BIM Lab unique?',
      'options': [
        'It has 3D motion analysis systems',
        'It allows virtual walkthroughs of buildings',
        'It specializes in petroleum engineering',
        'It contains a mini humanoid robot'
      ],
      'answerIndex': 1,
    },
  ];

  int currentQuestionIndex = 0;
  int remainingTime = 30;
  Timer? timer;
  int? selectedAnswerIndex;
  bool answerRevealed = false;

  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (remainingTime > 0) {
          remainingTime--;
        } else {
          revealAnswer();
        }
      });
    });
  }

  void revealAnswer() {
    setState(() {
      answerRevealed = true;
    });

    Future.delayed(const Duration(seconds: 2), () {
      nextQuestion();
    });
  }

  void nextQuestion() {
    timer?.cancel();
    if (currentQuestionIndex < questions.length - 1) {
      setState(() {
        currentQuestionIndex++;
        remainingTime = 30;
        selectedAnswerIndex = null;
        answerRevealed = false;
      });
      startTimer();
    } else {
      showResults();
    }
  }

  void checkAnswer(int selectedIndex) {
    setState(() {
      selectedAnswerIndex = selectedIndex; // Store selected answer
      answerRevealed = true; // Reveal the correct answer
    });

    timer?.cancel(); // Stop the timer since the user answered

    // Delay before proceeding to the next question, allowing UI to update
    Future.delayed(const Duration(seconds: 2), () {
      nextQuestion();
    });
  }

  void showResults() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Quiz Completed!'),
        content: const Text('You have finished the quiz!'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              setState(() {
                currentQuestionIndex = 0;
                remainingTime = 30;
                selectedAnswerIndex = null;
                answerRevealed = false;
              });
              startTimer();
            },
            child: const Text('Restart'),
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var question = questions[currentQuestionIndex];
    int correctAnswerIndex = question['answerIndex'];

    return Scaffold(
      appBar: AppBar(
        title: const Text('LSU PFT Quiz'),
        backgroundColor: const Color(0xFF461D7C),
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Time Left: $remainingTime sec',
              textAlign: TextAlign.center,
              style: const TextStyle(
                  fontSize: 20, fontWeight: FontWeight.bold, color: Colors.red),
            ),
            const SizedBox(height: 20),
            Text(
              question['question'],
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),
            ...List.generate(4, (index) {
              Color buttonColor = const Color(0xFF461D7C); // Default LSU Purple
              if (answerRevealed) {
                if (index == correctAnswerIndex) {
                  buttonColor = Colors.green; // Correct answer
                } else if (selectedAnswerIndex == index) {
                  buttonColor = Colors.red; // Wrong selection
                }
              }

              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: ElevatedButton(
                  onPressed: selectedAnswerIndex == null
                      ? () => checkAnswer(index)
                      : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: buttonColor,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    textStyle: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  child: Text(question['options'][index]),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
