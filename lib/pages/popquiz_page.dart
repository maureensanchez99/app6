import 'dart:async';
import 'package:flutter/material.dart';
import 'home_page.dart';
import 'resultsquiz_page.dart';

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
        // Ensure button themes don't override our specific styling
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF461D7C),
            foregroundColor: Colors.white,
          ),
        ),
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
  List<int?> userAnswers = [];
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
  int maxTime = 10; // Changed to 10 seconds
  int remainingTime = 10;
  Timer? timer;
  int? selectedAnswerIndex;
  bool answerRevealed = false;

  // Add score tracking
  int score = 0;
  String scoreMessage = '';

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
      userAnswers[currentQuestionIndex] = null;

      // When time runs out, treat as wrong answer
      if (selectedAnswerIndex == null) {
        updateScore(false, 0); // Time ran out - no speed bonus
      }
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
        remainingTime = maxTime; // Reset to full time
        selectedAnswerIndex = null;
        answerRevealed = false;
        scoreMessage = ''; // Clear the score message for next question
      });
      startTimer();
    } else {
      showResults();
    }
  }

  void updateScore(bool isCorrect, int timeSpent) {
    setState(() {
      if (isCorrect) {
        // Calculate bonus based on speed
        int timeBonus = 0;
        if (timeSpent <= 5) {
          timeBonus = 5; // Extra 5 points for quick answers (5 seconds or less)
        }

        // Base points + time bonus
        int pointsGained = 10 + timeBonus;
        score += pointsGained;

        // Update score message
        if (timeBonus > 0) {
          scoreMessage = '+10 points + $timeBonus speed bonus!';
        } else {
          scoreMessage = '+10 points!';
        }
      } else {
        // Ensure score doesn't go below 0
        if (score >= 10) {
          score -= 10;
          scoreMessage = '-10 points';
        } else {
          score = 0;
          scoreMessage = 'No points deducted';
        }
      }
    });
  }

  void checkAnswer(int selectedIndex) {
    // Calculate time spent on this question
    int timeSpent = maxTime - remainingTime;

    timer?.cancel(); // Stop the timer since the user answered

    final bool isCorrect =
        selectedIndex == questions[currentQuestionIndex]['answerIndex'];

    userAnswers[currentQuestionIndex] = selectedIndex;

    setState(() {
      selectedAnswerIndex = selectedIndex; // Store selected answer
      answerRevealed = true; // Reveal the correct answer
    });

    // Update score based on answer and time spent
    updateScore(isCorrect, timeSpent);

    // Delay before proceeding to the next question, allowing UI to update and user to see feedback
    Future.delayed(const Duration(seconds: 2), () {
      nextQuestion();
    });
  }

  void showResults() {
    // Calculate total time taken
    int totalTimeTaken = questions.length * maxTime - remainingTime;

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const ResultsPage(
          score: score,
          totalTime: totalTimeTaken,
          questions: questions,
          userAnswers: userAnswers,
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    remainingTime = maxTime; // Initialize with the new max time
    userAnswers = List.filled(questions.length, null);
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
            // Scoreboard section
            Container(
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: const Color(0xFF461D7C),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Score: $score',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    'Time Left: $remainingTime sec',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: remainingTime <= 5 ? Colors.yellow : Colors.white,
                    ),
                  ),
                ],
              ),
            ),

            // Speed bonus indicator
            if (remainingTime > 5)
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(
                  'Answer within ${remainingTime - 5} seconds for a speed bonus!',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 14,
                    fontStyle: FontStyle.italic,
                    color: Colors.deepOrange,
                  ),
                ),
              ),

            // Score message (appears when answer is revealed)
            if (scoreMessage.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(
                  scoreMessage,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color:
                        scoreMessage.contains('+') ? Colors.green : Colors.red,
                  ),
                ),
              ),

            const SizedBox(height: 20),
            Text(
              question['question'],
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),
            ...List.generate(4, (index) {
              // Define base button color - make sure it's always applied
              Color buttonColor = const Color(0xFF461D7C); // Default LSU Purple

              // Modify buttonColor based on answer status
              if (answerRevealed) {
                if (index == correctAnswerIndex) {
                  buttonColor = Colors.green; // Correct answer
                } else if (selectedAnswerIndex == index) {
                  buttonColor = Colors.red; // Wrong selection
                }
              }

              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    color: buttonColor,
                  ),
                  child: ElevatedButton(
                    onPressed: answerRevealed ? null : () => checkAnswer(index),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: buttonColor, // Ensure color is applied
                      foregroundColor: Colors.white,
                      elevation: 4.0, // Add shadow for better visibility
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      textStyle: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                      // Ensure the button has no borders that might interfere
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    child: Text(question['options'][index]),
                  ),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
