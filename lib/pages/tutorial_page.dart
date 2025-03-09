import 'package:flutter/material.dart';
import 'home_page.dart';

class TutorialPage extends StatelessWidget {
  const TutorialPage({super.key});

  // LSU colors
  static const Color lsuPurple = Color(0xFF461D7C); // LSU Purple
  static const Color lsuGold = Color(0xFFFDD023);   // LSU Gold
  static const Color lsuLightPurple = Color(0xFF8075A4); // Light purple for gradient

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('How to Play'),
        centerTitle: true,
        backgroundColor: lsuPurple,
        foregroundColor: lsuGold,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [lsuGold, Color.fromARGB(255, 108, 63, 167)],
            stops: [0.0, 0.7],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Tutorial',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: lsuPurple,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                Container(
                  constraints: const BoxConstraints(maxWidth: 300),
                  child: Column(
                    children: [
                      _buildTutorialStep(
                        '1',
                        'Navigate through different challenges in the PFT building.',
                      ),
                      _buildTutorialStep(
                        '2',
                        'Complete the Word Search puzzle to find hidden clues.',
                      ),
                      _buildTutorialStep(
                        '3',
                        'Explore the Third Floor to discover the mysteries.',
                      ),
                      _buildTutorialStep(
                        '4',
                        'Test your knowledge with the Pop Quiz challenge.',
                      ),
                      _buildTutorialStep(
                        '5',
                        'Visit Panera and answer questions to complete challenge.',
                      ),
                      _buildTutorialStep(
                        '6',
                        'Solve the anagram to find the next spot.',
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 40),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const HomePage(
                          title: 'PFT Scavenger Hunt',
                        ),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 40,
                      vertical: 15,
                    ),
                    backgroundColor: lsuGold,
                    foregroundColor: lsuPurple,
                  ),
                  child: const Text(
                    'Start the Hunt',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTutorialStep(String number, String description) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 30,
            height: 30,
            decoration: const BoxDecoration(
              color: lsuPurple,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                number,
                style: const TextStyle(
                  color: lsuGold,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Text(
              description,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
