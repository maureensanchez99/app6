import 'package:flutter/material.dart';

class BestProfessorQuiz extends StatefulWidget {
  const BestProfessorQuiz({super.key});

  @override
  State<BestProfessorQuiz> createState() => _BestProfessorQuizState();
}

class _BestProfessorQuizState extends State<BestProfessorQuiz> {
  final TextEditingController _textController = TextEditingController();
  bool _isAnswerCorrect = false;

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  void _checkAnswer() {
    setState(() {
      _isAnswerCorrect = _textController.text.toLowerCase() == 'dr. shepherd';
    });

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(_isAnswerCorrect ? 'Correct!' : 'Incorrect'),
        content: Text(_isAnswerCorrect
            ? 'You got it right!'
            : 'Try again. Who is the best professor in Patrick F. Taylor Hall?'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              if (_isAnswerCorrect) {
                _textController.clear(); // Clear the text field if correct
              }
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Best Professor Quiz'),
        backgroundColor: const Color(0xFF461D7C), // LSU Purple
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
          tooltip: 'Back',
        ),
      ),
      backgroundColor: const Color(0xFFFDD023), // LSU Gold
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Who is the best professor in Patrick F. Taylor Hall?',
                style: TextStyle(fontSize: 20),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              const Text(
                '01000100 01110010 00101110 00100000 01010011 01101000 01100101 01110000 01101000 01100101 01110010 01100100',
                style: TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),
              TextField(
                controller: _textController,
                decoration: const InputDecoration(
                  hintText: 'Enter your answer',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: _checkAnswer,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF461D7C), // LSU Purple
                ),
                child: const Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}