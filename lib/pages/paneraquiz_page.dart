import 'package:flutter/material.dart';

class PaneraQuiz extends StatelessWidget {
  const PaneraQuiz({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Panera Quiz Challenge'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text('Panera Quiz Challenge Content'),
      ),
    );
  }
}