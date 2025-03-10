import 'package:app6/pages/commons.dart';
import 'package:flutter/material.dart';
import 'wordsearch_page.dart';
import 'thirdfloor_page.dart';
import 'popquiz_page.dart';
import 'paneraquiz_page.dart';
import 'capstone_stairs.dart';
import 'Jp_riddle.dart';

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
        backgroundColor: lsuGold,
        title: const Text("PFT Scavenger Hunt"),
        foregroundColor: lsuPurple,
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
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const WordSearch()),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: lsuGold,
                  foregroundColor: lsuPurple,
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  side: const BorderSide(color: Colors.black),
                ),
                child: const Text("Wordsearch", style: TextStyle(fontWeight: FontWeight.bold)),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ThirdFloor()),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: lsuGold,
                  foregroundColor: lsuPurple,
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  side: const BorderSide(color: Colors.black),
                ),
                child: const Text("Third Floor Challenge", style: TextStyle(fontWeight: FontWeight.bold)),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const PopQuiz()),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: lsuGold,
                  foregroundColor: lsuPurple,
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  side: const BorderSide(color: Colors.black),
                ),
                child: const Text("Pop Quiz", style: TextStyle(fontWeight: FontWeight.bold)),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const PaneraQuiz()),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: lsuGold,
                  foregroundColor: lsuPurple,
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  side: const BorderSide(color: Colors.black),
                ),
                child: const Text("Panera Quiz", style: TextStyle(fontWeight: FontWeight.bold)),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const CapstoneStairs()),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: lsuGold,
                  foregroundColor: lsuPurple,
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  side: const BorderSide(color: Colors.black),
                ),
                child: const Text("Anagram", style: TextStyle(fontWeight: FontWeight.bold)),
              ), 
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const jpRiddle()),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: lsuGold,
                  foregroundColor: lsuPurple,
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  side: const BorderSide(color: Colors.black),
                ),
                child: const Text("Jp's Riddle", style: TextStyle(fontWeight: FontWeight.bold)),
              ), const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const commons()),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: lsuGold,
                  foregroundColor: lsuPurple,
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  side: const BorderSide(color: Colors.black),
                ),
                child: const Text("Commons", style: TextStyle(fontWeight: FontWeight.bold)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
