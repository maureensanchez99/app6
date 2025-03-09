import 'package:flutter/material.dart';

class ThirdFloor extends StatelessWidget {
  const ThirdFloor({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Third Floor Mysteries!'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text('Find out more about the mysterious third floor of the PFT'),
      ),
    );
  }
}