import 'package:flutter/material.dart';

class jpRiddle extends StatefulWidget {
  const jpRiddle({super.key});

  @override
  State<jpRiddle> createState() => _jpRiddle();
}

class _jpRiddle extends State<jpRiddle>
{
   @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 101, 112, 0),
        title: const Text(
          "Jp's Riddle",
          style: TextStyle(
            color: Color.fromARGB(255, 228, 228, 228),
            fontSize: 30,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: 
      Text("Hello")
    );
  }
}

