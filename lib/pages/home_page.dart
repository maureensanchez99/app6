import 'package:flutter/material.dart';
import 'wordsearch_page.dart';
import 'thirdfloor_page.dart';
import 'popquiz_page.dart';
import 'paneraquiz_page.dart';
import 'capstone_stairs.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  // LSU colors
  static const Color lsuPurple = Color(0xFF461D7C); // LSU Purple
  static const Color lsuGold = Color(0xFFE6C423);   // Slightly less bright LSU Gold
  
  // Progress value (0.0 to 1.0)
  double progressValue = 0.0;
  
  late AnimationController _animationController;
  
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
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: lsuGold,
        title: Text(
          "PFT Scavenger Hunt",
          style: const TextStyle(
            color: Colors.purple,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.purple),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Welcome section
            Container(
              margin: const EdgeInsets.all(16),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.15),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  // Compass icon
                  Container(
                    width: 60,
                    height: 60,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.explore,
                      color: Color(0xFF461D7C), // Use LSU purple for the icon
                      size: 36,
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    "Welcome to the PFT Scavenger Hunt!",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    "Complete the challenges to discover all the clues",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            
            // Challenges header
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Text(
                "CHALLENGES",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            
            // Challenge list (scrollable)
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                children: [
                  _buildChallengeCard(
                    "Word Search",
                    "Find hidden words in the grid",
                    Icons.search,
                    Colors.amber,
                    () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const WordSearch()),
                    ),
                  ),
                  _buildChallengeCard(
                    "Third Floor",
                    "Explore the third floor challenge",
                    Icons.stairs,
                    Colors.amber,
                    () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const ThirdFloor()),
                    ),
                  ),
                  _buildChallengeCard(
                    "Pop Quiz",
                    "Test your knowledge",
                    Icons.quiz,
                    Colors.amber,
                    () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const PopQuiz()),
                    ),
                  ),
                  _buildChallengeCard(
                    "Panera Quiz",
                    "Food-related questions",
                    Icons.restaurant,
                    Colors.amber,
                    () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const PaneraQuiz()),
                    ),
                  ),
                  _buildChallengeCard(
                    "Anagram Challenge",
                    "Unscramble the words to reveal a clue",
                    Icons.text_fields,
                    Colors.amber,
                    () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const CapstoneStairs()),
                    ),
                  ),
                ],
              ),
            ),
            
            // Progress section
            Container(
              padding: const EdgeInsets.all(16),
              color: Colors.black.withOpacity(0.2),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(
                    children: [
                      Icon(
                        Icons.emoji_events,
                        color: Colors.amber,
                        size: 24,
                      ),
                      SizedBox(width: 8),
                      Text(
                        "Your Progress",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: LinearProgressIndicator(
                      value: progressValue,
                      minHeight: 12,
                      backgroundColor: Colors.white.withOpacity(0.3),
                      valueColor: const AlwaysStoppedAnimation<Color>(Colors.amber),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildChallengeCard(String title, String subtitle, IconData icon, Color iconColor, VoidCallback onTap) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 0,
      color: Colors.white.withOpacity(0.15),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: const BorderSide(color: Colors.amber, width: 0.85),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 16),
          child: Row(
            children: [
              Icon(
                icon,
                color: Colors.amber,
                size: 30,
              ),
              const SizedBox(width: 18),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      subtitle,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white.withOpacity(0.7),
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(
                Icons.chevron_right,
                color: Colors.white,
                size: 24,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
