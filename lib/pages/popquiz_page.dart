import 'package:flutter/material.dart';

class PopQuiz extends StatelessWidget {
  const PopQuiz({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pop Quiz Challenge'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text('Pop Quiz Challenge Content'),
      ),
    );
  }
}