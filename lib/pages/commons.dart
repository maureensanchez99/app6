import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class commons extends StatefulWidget {
  const commons ({super.key});
   @override
  State<commons> createState() => _commons();
}

class _commons extends State<commons>{
  bool isCorrect = false;
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadState();
  }

  // Load the stored state from shared preferences
  void _loadState() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      isCorrect = prefs.getBool('isCorrect') ?? false;
    });
  }

  // Save the state in shared preferences
  void _saveState(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('isCorrect', value);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 101, 112, 0),
        title: const Text(
          "The Commons",
          style: TextStyle(
            color: Color.fromARGB(255, 228, 228, 228),
            fontSize: 30,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            const Text(
              "There is an unknown part of PFT that people are not aware of.",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 24,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              "Someone had put around pft a signature animal that one might find around",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 24,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              "One of these animals can be found in the commons. Find it and write down the animal below",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 24,
              ),
            ),
            const SizedBox(height: 20),
            Image.asset('assets/commons.PNG'),  // Make sure the image exists in the correct folder
            const SizedBox(height: 20),
            if (!isCorrect) ...[
              const Text(
                "What animal can be found in the commons?",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _controller,  // Controller to manage input
                keyboardType: TextInputType.number,  // Show numeric keyboard
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'One Word',
                ),
              ),
              const SizedBox(height: 20),

              // Button to check the entered number
              ElevatedButton(
                onPressed: () {
                  // Get the entered number
                  String enteredValue = _controller.text;
                  
                  if (enteredValue.isNotEmpty) {
                    // Check if the entered number matches the correct number (1344)
                    if (enteredValue == "Duck" || enteredValue == "duck" || enteredValue == "Duckie" || enteredValue == "duckie")  {
                      // Correct answer
                      setState(() {
                        isCorrect = true;  // Update the state to show "Correct" message
                      });
                      _saveState(true); // Save the state to SharedPreferences
                    } else {
                      // Incorrect answer
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Incorrect. Try again.')),
                      );
                    }
                  } else {
                    // No input provided
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Please enter an answer')),
                    );
                  }
                },
                child: const Text('Submit'),
              ),
            ],
            // If the answer is correct, show the success message
            if (isCorrect) ...[
              const SizedBox(height: 20),
              const Icon(
                Icons.check_circle_outline,  // Check mark icon
                color: Colors.green,
                size: 50,
              ),
              const SizedBox(height: 10),
              const Text(
                'Correct!',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

