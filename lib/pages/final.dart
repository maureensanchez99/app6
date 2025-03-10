import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FinalPuzzle extends StatefulWidget {
  const FinalPuzzle({super.key});

  @override
  State<FinalPuzzle> createState() => _FinalPuzzleState();
}

class _FinalPuzzleState extends State<FinalPuzzle> {
  final TextEditingController _controller = TextEditingController();
  bool isCorrect1 = false;

  @override
  void initState() {
    super.initState();
    _loadState();
  }

  // Load the stored state from shared preferences
  void _loadState() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      isCorrect1 = prefs.getBool('isCorrect') ?? false;
    });
  }

  // Save the state in shared preferences
  void _saveState(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('isCorrect', value);
  }

  // Show dialog with Yes or No choices
  void _showFinalChoiceDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Final Choice"),
          content: const Text("Do you want to continue to the next step?"),
          actions: [
            TextButton(
              onPressed: () {
                // User chose "Yes"
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("You chose Yes!")),
                );
              },
              child: const Text("Yes"),
            ),
            TextButton(
              onPressed: () {
                // User chose "No"
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("You chose No!")),
                );
              },
              child: const Text("No"),
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
          "Final Puzzle",
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
              "Good Job making it to the end! Now do me a favor and go sit on top of the capstone stair to look down and look around. You did a good job and I want you to become aware of how amazing this building is.",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 24,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              "Now let's answer the final puzzle",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 24,
              ),
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: _showFinalChoiceDialog,
              child: const Text(
                "Make Final Choice",
                style: TextStyle(fontSize: 20),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
