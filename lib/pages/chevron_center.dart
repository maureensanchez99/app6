import 'package:flutter/material.dart';
import 'home_page.dart';

class ChevronCenter extends StatelessWidget {
  const ChevronCenter({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'I Spy',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const IspyGame(),
    );
  }
}

class _ChevronCenterState extends State<ChevronCenter> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}
