import 'package:flutter/material.dart';

class CapstoneStairs extends StatefulWidget {
  const CapstoneStairs({super.key});

  @override
  State<CapstoneStairs> createState() => _CapstoneStairsState();
}

class _CapstoneStairsState extends State<CapstoneStairs> {
  final List<String> scrambledWords = [
    "MOCE",
    "MAGH",
    "TUO",
    "NO",
    "EHT",
    "OOWDEN",
    "TUCRTSURE",
    "DAN",
    "KET",
    "LOOC",
    "PUCRITES",
  ];

  final List<String> correctWords = [
    "COME",
    "HANG",
    "OUT",
    "ON",
    "THE",
    "WOODEN",
    "STRUCTURE",
    "AND",
    "TAKE",
    "COOL",
    "PICTURES",
  ];

  final List<TextEditingController> _controllers = [];
  final List<bool> _isCorrect = [];

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < scrambledWords.length; i++) {
      _controllers.add(TextEditingController());
      _isCorrect.add(false);
    }
  }

  void _checkAnswers() {
    bool allCorrect = true;
    for (int i = 0; i < scrambledWords.length; i++) {
      if (_controllers[i].text.toUpperCase() == correctWords[i]) {
        setState(() {
          _isCorrect[i] = true;
        });
      } else {
        setState(() {
          _isCorrect[i] = false;
        });
        allCorrect = false;
      }
    }

    if (allCorrect) {
      _showClueDialog();
    } else {
      _showTryAgainDialog();
    }
  }

  void _showClueDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Clue Revealed!'),
          content: const Text(
            'Come hang out on the wooden structure and take cool pictures.',
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _showTryAgainDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Try Again!'),
          content: const Text('Some of the words are incorrect.'),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 101, 112, 0),
        title: const Text(
          'Anagram Challenge',
          style: TextStyle(
            color: Color.fromARGB(255, 228, 228, 228),
            fontSize: 30,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            const Text(
              'Unscramble the words to reveal the clue:',
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: scrambledWords.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Row(
                      children: <Widget>[
                        Text('${index + 1}. ${scrambledWords[index]}'),
                        const SizedBox(width: 10),
                        Expanded(
                          child: TextField(
                            controller: _controllers[index],
                            decoration: InputDecoration(
                              labelText: 'Enter word',
                              border: const OutlineInputBorder(),
                              errorText: _isCorrect[index]
                                  ? null
                                  : (_controllers[index].text.isNotEmpty
                                      ? 'Incorrect'
                                      : null),
                              errorStyle: const TextStyle(color: Colors.red),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            ElevatedButton(
              onPressed: _checkAnswers,
              child: const Text('Check Answers'),
            ),
          ],
        ),
      ),
    );
  }
}