import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class BestProfessorQuiz extends StatefulWidget {
  const BestProfessorQuiz({super.key});

  @override
  State<BestProfessorQuiz> createState() => _BestProfessorQuizState();
}

class _BestProfessorQuizState extends State<BestProfessorQuiz> {
  final TextEditingController _textController = TextEditingController();
  bool _isAnswerCorrect = false;
  String _selectedProfessor = '';
  String _selectedBinary = '';

  final Map<String, String> _professorBinaries = {
    'Dave Shepherd':
        '01000100 01100001 01110110 01100101 00100000 01010011 01101000 01100101 01110000 01101000 01100101 01110010 01100100',
    'Daniel Donze':
        '01000100 01100001 01101110 01101001 01100101 01101100 00100000 01000100 01101111 01101110 01111010 01100101',
    'John Luke Denny':
        '01001010 01101111 01101000 01101110 00100000 01001100 01110101 01101011 01100101 00100000 01000100 01100101 01101110 01101110 01111001',
    'Nash':
        '01001110 01100001 01110011 01101000',
    'Golden':
        '01000111 01101111 01101100 01100100 01100101 01101110',
    'Aisha':
        '01000001 01101001 01110011 01101000 01100001',
    'Daniel Shepherd':
        '01000100 01100001 01101110 01101001 01100101 01101100 00100000 01010011 01101000 01100101 01110000 01101000 01100101 01110010 01100100',
  };

  @override
  void initState() {
    super.initState();
    _selectRandomProfessor();
  }

  void _selectRandomProfessor() {
    final random = Random();
    final professors = _professorBinaries.keys.toList();
    _selectedProfessor = professors[random.nextInt(professors.length)];
    _selectedBinary = _professorBinaries[_selectedProfessor]!;
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  void _checkAnswer() {
    setState(() {
      _isAnswerCorrect = _textController.text.toLowerCase() ==
          _selectedProfessor.toLowerCase();
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
                _textController.clear();
                _selectRandomProfessor(); // Select a new professor
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
        title: const Text(
          'Best Professor Quiz',
          style: TextStyle(color: Color(0xFFFDD023)),
        ),
        backgroundColor: const Color(0xFF461D7C),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
          tooltip: 'Back',
        ),
      ),
      backgroundColor: const Color(0xFFFDD023),
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
              SelectableText(
                _selectedBinary,
                style: const TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
                toolbarOptions: const ToolbarOptions(
                  copy: true,
                  selectAll: true,
                ),
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
                  backgroundColor: const Color(0xFF461D7C),
                ),
                child: const Text(
                  'Submit',
                  style: TextStyle(color: Color(0xFFFDD023)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}