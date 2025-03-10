import 'package:flutter/material.dart';
import 'dart:math'; // Required for generating random numbers

class ThirdFloor extends StatefulWidget {
  const ThirdFloor({super.key});

  @override
  _ThirdFloorState createState() => _ThirdFloorState();
}

class _ThirdFloorState extends State<ThirdFloor> with SingleTickerProviderStateMixin {
  // Define LSU colors
  static const Color lsuPurple = Color(0xFF461D7C);
  static const Color lsuGold = Color(0xFFFDD023);

  late AnimationController _animationController;

  // List of facts
  final List<String> facts = [
    'The third floor is primarily used as the office space for faculty and staff',
    'You can get a wonderful view of the commons area from the third floor staircase, so take lots of pictures!',
    'Not only can you find labs on the first and second floor, but on the third floor as well!',
    'The third floor is the quietest place for studying 🤓',
    'The department suites for each engineering major are found here',
    'Only the Commons stairs and elevators can get you to the third floor, so try not to get lost!',
    'There is a robot somewhere on the third floor, but you did not hear it from me 🤫',
    ''
  ];

  String currentFact = ''; // To store the current random fact

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  // Function to get a random fact
  void getRandomFact() {
    final random = Random();
    setState(() {
      currentFact = facts[random.nextInt(facts.length)];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Third Floor Facts",
          style: TextStyle(
            color: lsuPurple,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: lsuGold,
        centerTitle: true,
      ),
      body: AnimatedBuilder(
        animation: _animationController,
        builder: (context, child) {
          return Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color.lerp(lsuGold, lsuPurple, _animationController.value) ?? lsuGold,
                  Color.lerp(lsuPurple, lsuGold, _animationController.value) ?? lsuPurple,
                ],
              ),
            ),
            child: child,
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                // Displaying the current fact
                Text(
                  currentFact.isEmpty
                      ? 'Press the button to uncover a fact!'
                      : currentFact,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: lsuGold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 30),
                ElevatedButton(
                  onPressed: getRandomFact,
                  child: const Text('Generate Fact'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
