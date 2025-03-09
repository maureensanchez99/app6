import 'package:flutter/material.dart';

class CapstoneStairs extends StatefulWidget {
  const CapstoneStairs({super.key});

  @override
  State<CapstoneStairs> createState() => _CapstoneStairsState();
}

class _CapstoneStairsState extends State<CapstoneStairs> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 101, 112, 0),
        title: const Text(
          'Puzzle Challenge',
          style: TextStyle(
              color: Color.fromARGB(255, 228, 228, 228),
              fontSize: 40,
              fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
      ),
      body: const Center(
        child: Text('Puzzle content here'),  
      ),
    );
  }
}
