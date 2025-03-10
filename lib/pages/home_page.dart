import 'package:flutter/material.dart';
import 'wordsearch_page.dart';
import 'thirdfloor_page.dart';
import 'popquiz_page.dart';
import 'paneraquiz_page.dart';
import 'capstone_stairs.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'chevron_center.dart';

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
  static const Color progressGreen = Color.fromARGB(255, 22, 216, 4); // for progress
  
  // Progress value (0.0 to 1.0)
  double progressValue = 0.0;
  
  // Challenge tracking
  final int totalChallenges = 5;
  Set<String> visitedChallenges = {};
  
  late AnimationController _animationController;
  
  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat(reverse: true);
    
    // Load visited challenges from storage
    _loadVisitedChallenges();
  }
  
  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
  
  // Load visited challenges from SharedPreferences
  Future<void> _loadVisitedChallenges() async {
    final prefs = await SharedPreferences.getInstance();
    final visited = prefs.getStringList('visited_challenges') ?? [];
    
    setState(() {
      visitedChallenges = Set<String>.from(visited);
      _updateProgressValue();
    });
  }
  
  // Save visited challenges to SharedPreferences
  Future<void> _saveVisitedChallenges() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('visited_challenges', visitedChallenges.toList());
  }
  
  // Update progress value based on visited challenges
  void _updateProgressValue() {
    setState(() {
      progressValue = visitedChallenges.length / totalChallenges;
    });
  }
  
  // Mark a challenge as visited and update progress
  void _markChallengeVisited(String challengeId) {
    if (!visitedChallenges.contains(challengeId)) {
      setState(() {
        visitedChallenges.add(challengeId);
        _updateProgressValue();
      });
      _saveVisitedChallenges();
    }
  }
  
  // Navigate to a challenge with slide animation and mark it as visited
  void _navigateToChallenge(BuildContext context, Widget challenge, String challengeId) {
    // mark the challenge as visited after the navigation completes
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => challenge,
        transitionDuration: const Duration(milliseconds: 400),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(1.0, 0.0);
          const end = Offset.zero;
          const curve = Curves.easeInOut;
          
          var tween = Tween(begin: begin, end: end).chain(
            CurveTween(curve: curve),
          );
          
          return SlideTransition(
            position: animation.drive(tween),
            child: child,
          );
        },
      ),
    ).then((_) {
      // Mark the challenge as visited only after returning or page is fully loaded
      _markChallengeVisited(challengeId);
    });
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
            
            // Challenge list 
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                children: [
                  _buildChallengeCard(
                    "Word Search",
                    "Find hidden words in the grid",
                    Icons.search,
                    Colors.amber,
                    () => _navigateToChallenge(context, const WordSearch(), "word_search"),
                    visitedChallenges.contains("word_search"),
                  ),
                  _buildChallengeCard(
                    "Third Floor",
                    "Find out more about the third floor of PFT",
                    Icons.stairs,
                    Colors.amber,
                    () => _navigateToChallenge(context, const ThirdFloor(), "third_floor"),
                    visitedChallenges.contains("third_floor"),
                  ),
                  _buildChallengeCard(
                    "Pop Quiz",
                    "Test your knowledge",
                    Icons.quiz,
                    Colors.amber,
                    () => _navigateToChallenge(context, const PopQuiz(), "pop_quiz"),
                    visitedChallenges.contains("pop_quiz"),
                  ),
                  _buildChallengeCard(
                    "Panera Quiz",
                    "Food-related questions",
                    Icons.restaurant,
                    Colors.amber,
                    () => _navigateToChallenge(context, const PaneraQuiz(), "panera_quiz"),
                    visitedChallenges.contains("panera_quiz"),
                  ),
                  _buildChallengeCard(
                    "Anagram Challenge",
                    "Unscramble the words to reveal a clue",
                    Icons.text_fields,
                    Colors.amber,
                    () => _navigateToChallenge(context, const CapstoneStairs(), "anagram"),
                    visitedChallenges.contains("anagram"),
                  ),
                  _buildChallengeCard(
                    "Chevron Center Challenge",
                    "Discover resources the Chevron Center offers to students",
                    Icons.text_fields,
                    Colors.amber,
                    () => _navigateToChallenge(context, const ChevronCenter(), "chevron_center"),
                    visitedChallenges.contains("chevron_center"),
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
                  Row(
                    children: [
                      const Icon(
                        Icons.emoji_events,
                        color: Colors.amber,
                        size: 24,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        "Your Progress (${(progressValue * 100).toInt()}%)",
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      // Reset progress button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Align(
                alignment: Alignment.bottomRight,
                child: TextButton.icon(
                  onPressed: () {
                    // Show confirmation dialog
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text("Reset Progress"),
                          content: const Text("Are you sure you want to reset your progress? This cannot be undone."),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop(); // Close dialog
                              },
                              child: const Text("Cancel"),
                            ),
                            TextButton(
                              onPressed: () {
                                // Reset progress
                                setState(() {
                                  visitedChallenges.clear();
                                  _updateProgressValue();
                                });
                                _saveVisitedChallenges();
                                Navigator.of(context).pop(); // Close dialog
                              },
                              child: const Text("Reset"),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  icon: const Icon(Icons.refresh, size: 16, color: Colors.white),
                  label: const Text(
                    "Reset Progress",
                    style: TextStyle(color: Colors.white, fontSize: 12),
                  ),
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.red.withOpacity(0.3),
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                ),
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
                      valueColor: const AlwaysStoppedAnimation<Color>(progressGreen),
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
  
  Widget _buildChallengeCard(
    String title, 
    String subtitle, 
    IconData icon, 
    Color iconColor, 
    VoidCallback onTap,
    bool isVisited,
  ) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 0,
      color: isVisited 
          ? Colors.white.withOpacity(0.25) 
          : Colors.white.withOpacity(0.15),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: isVisited ? progressGreen : Colors.amber, 
          width: 0.85
        ),
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
                color: isVisited ? progressGreen : Colors.amber,
                size: 30,
              ),
              const SizedBox(width: 18),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          title,
                          style: const TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        if (isVisited) 
                          const Padding(
                            padding: EdgeInsets.only(left: 8),
                            child: Icon(
                              Icons.check_circle,
                              color: progressGreen,
                              size: 16,
                            ),
                          ),
                      ],
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
              Icon(
                Icons.chevron_right,
                color: isVisited ? progressGreen : Colors.white,
                size: 24,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
