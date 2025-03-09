import 'package:flutter/material.dart';
import 'package:confetti/confetti.dart';
import 'home_page.dart';

class ResultsPage extends StatefulWidget {
  final int score;
  final int totalTime;
  final List<Map<String, dynamic>> questions;
  final List<int?> userAnswers;

  const ResultsPage({
    Key? key,
    required this.score,
    required this.totalTime,
    required this.questions,
    required this.userAnswers,
  }) : super(key: key);

  @override
  State<ResultsPage> createState() => _ResultsPageState();
}

class _ResultsPageState extends State<ResultsPage> {
  late ConfettiController _confettiController;

  @override
  void initState() {
    super.initState();
    // Initialize the confetti controller
    _confettiController =
        ConfettiController(duration: const Duration(seconds: 5));

    // Calculate percentage score
    final double percentage =
        (widget.score / (widget.questions.length * 10)) * 100;

    // Start confetti if score is 90% or higher
    if (percentage >= 90) {
      _confettiController.play();
    }
  }

  @override
  void dispose() {
    _confettiController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Calculate percentage score
    final double percentage =
        (widget.score / (widget.questions.length * 10)) * 100;

    // Determine performance message
    String performanceMessage;
    if (percentage >= 90) {
      performanceMessage = "Outstanding! You're a PFT expert!";
    } else if (percentage >= 70) {
      performanceMessage = "Great job! You know PFT well!";
    } else if (percentage >= 50) {
      performanceMessage = "Good effort! You're getting familiar with PFT.";
    } else {
      performanceMessage = "Keep exploring PFT to learn more!";
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Quiz Results'),
        backgroundColor: const Color(0xFF461D7C),
        foregroundColor: Colors.white,
      ),
      body: Stack(
        children: [
          Container(
            color: const Color(0xFFFDD023),
            child: Column(
              children: [
                // Score summary card
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          const Text(
                            'Quiz Complete!',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF461D7C),
                            ),
                          ),
                          const SizedBox(height: 16),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              _buildSummaryItem(
                                icon: Icons.score,
                                label: 'Final Score',
                                value: '${widget.score} pts',
                              ),
                              _buildSummaryItem(
                                icon: Icons.percent,
                                label: 'Percentage',
                                value: '${percentage.toStringAsFixed(0)}%',
                              ),
                              _buildSummaryItem(
                                icon: Icons.timer,
                                label: 'Total Time',
                                value: '${widget.totalTime}s',
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          Text(
                            performanceMessage,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              fontStyle: FontStyle.italic,
                              color: Color(0xFF461D7C),
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                // Question breakdown section
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Card(
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Question Breakdown',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF461D7C),
                              ),
                            ),
                            const SizedBox(height: 8),
                            Expanded(
                              child: ListView.builder(
                                itemCount: widget.questions.length,
                                itemBuilder: (context, index) {
                                  final question = widget.questions[index];
                                  final correctIndex =
                                      question['answerIndex'] as int;
                                  final userAnswerIndex =
                                      widget.userAnswers[index];
                                  final bool isCorrect =
                                      userAnswerIndex == correctIndex;

                                  return Card(
                                    margin: const EdgeInsets.symmetric(
                                        vertical: 8.0),
                                    color: isCorrect
                                        ? const Color.fromARGB(
                                                255, 255, 252, 252)
                                            .withValues()
                                        : const Color.fromARGB(
                                                255, 203, 134, 129)
                                            .withValues(),
                                    child: Padding(
                                      padding: const EdgeInsets.all(12.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Icon(
                                                isCorrect
                                                    ? Icons.check_circle
                                                    : Icons.cancel,
                                                color: isCorrect
                                                    ? Colors.green
                                                    : Colors.red,
                                              ),
                                              const SizedBox(width: 8),
                                              Expanded(
                                                child: Text(
                                                  'Q${index + 1}: ${question['question']}',
                                                  style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 8),
                                          Text(
                                            userAnswerIndex != null
                                                ? 'Your answer: ${question['options'][userAnswerIndex]}'
                                                : 'Time expired - No answer given',
                                            style: TextStyle(
                                              color: isCorrect
                                                  ? Colors.green
                                                  : Colors.red,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          if (!isCorrect) ...[
                                            const SizedBox(height: 4),
                                            Text(
                                              'Correct answer: ${question['options'][correctIndex]}',
                                              style: const TextStyle(
                                                color: Colors.green,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ],
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),

                // Action buttons
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildActionButton(
                        context,
                        'Play Again',
                        Icons.replay,
                        () {
                          Navigator.of(context).pop();
                          // Return to QuizScreen and restart
                        },
                      ),
                      _buildActionButton(
                        context,
                        'Home',
                        Icons.home,
                        () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const HomePage(title: ''),
                            ),
                          );
                        },
                      ),
                      _buildActionButton(
                        context,
                        'Share',
                        Icons.share,
                        () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Sharing results...'),
                              duration: Duration(seconds: 2),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // Confetti overlay
          Align(
            alignment: Alignment.topCenter,
            child: ConfettiWidget(
              confettiController: _confettiController,
              blastDirectionality: BlastDirectionality.explosive,
              particleDrag: 0.05,
              emissionFrequency: 0.05,
              numberOfParticles: 20,
              gravity: 0.2,
              shouldLoop: false,
              colors: const [
                Colors.purple,
                Colors.yellow,
                Colors.green,
                Colors.blue,
                Colors.red,
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryItem({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Column(
      children: [
        Icon(
          icon,
          color: const Color(0xFF461D7C),
          size: 32,
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            color: Colors.grey,
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Color(0xFF461D7C),
          ),
        ),
      ],
    );
  }

  Widget _buildActionButton(
    BuildContext context,
    String label,
    IconData icon,
    VoidCallback onPressed,
  ) {
    return ElevatedButton.icon(
      icon: Icon(icon),
      label: Text(label),
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF461D7C),
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 12,
        ),
      ),
    );
  }
}
