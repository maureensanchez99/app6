import 'package:flutter/material.dart';

class ThirdFloor extends StatelessWidget {
  const ThirdFloor({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Third Floor Challenge'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text('Third Floor Challenge Content'),
      ),
    );
  }
}