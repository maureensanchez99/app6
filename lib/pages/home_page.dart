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
  static const Color lsuGold = Color(0xFFFDD023);   // LSU Gold
  
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
        backgroundColor:
            Color(0xFFFDD023), //Theme.of(context).colorScheme.inversePrimary,
        title: Text("PFT Scavenger Hunt"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const WordSearch()),
              ),
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: Colors.black),
              ),
              child: const Text("Wordsearch"),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ThirdFloor()),
              ),
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: Colors.black),
              ),
              child: const Text("Third Floor Mysteries"),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const PopQuiz()),
              ),
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: Colors.black),
              ),
              child: const Text("Pop Quiz"),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const PaneraQuiz()),
              ),
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: Colors.black),
              ),
              child: const Text("Panera Quiz"),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const CapstoneStairs()),
              ),
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: Colors.black),
              ),
              child: const Text('Anagram'),
            ],
          ),
        ),
      ),
    );
  }
}
