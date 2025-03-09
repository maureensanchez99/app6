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

class IspyGame extends StatefulWidget {
  const IspyGame({super.key});

  @override
  State<IspyGame> createState() => _IspyGameState();
}

class _IspyGameState extends State<IspyGame> {
  final String imageUrl =
      'https://www.lsu.edu/eng/images/selfguidedtourmp3sandimages/9.chevron-center-for-engineering-education.jpg';

  final List<String> itemsToFind = [
    'Computer',
    'Whiteboard',
    'Meeting Room',
    'TV',
    '3D Printer',
  ];

  final Map<String, bool> foundItems = {};

  @override
  void initState() {
    super.initState();
    // Initialize foundItems map
    for (var item in itemsToFind) {
      foundItems[item] = false;
    }
  }

  void checkItemFound(String itemName) {
    setState(() {
      foundItems[itemName] = true;
    });

    // Check if all items are found
    if (foundItems.values.every((found) => found)) {
      // All items found, show a dialog or navigate to a new screen
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Congratulations!'),
          content: const Text('You found all the items!'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                // Reset the game or navigate to another screen
                resetGame();
              },
              child: const Text('Play Again'),
            ),
          ],
        ),
      );
    }
  }

  void resetGame() {
    setState(() {
      for (var item in foundItems.keys) {
        foundItems[item] = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('I Spy'),
      ),
      body: Stack(
        children: [
          Image.network(
            imageUrl,
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.cover,
          ),
          // Overlay for item highlighting
          ...itemsToFind.map((item) {
            return Positioned.fill(
              child: GestureDetector(
                onTapDown: (details) {
                  // Define the tap areas for each item (LARGER BOXES)
                  switch (item) {
                    case 'Computer':
                      if (details.localPosition.dx >= 100 && // Increased tap area
                          details.localPosition.dx <= 400 && // Increased tap area
                          details.localPosition.dy >= 200 && // Increased tap area
                          details.localPosition.dy <= 500) { // Increased tap area
                        checkItemFound(item);
                      }
                      break;
                    case 'Whiteboard':
                      if (details.localPosition.dx >= 400 && // Increased tap area
                          details.localPosition.dx <= 700 && // Increased tap area
                          details.localPosition.dy >= 100 && // Increased tap area
                          details.localPosition.dy <= 400) { // Increased tap area
                        checkItemFound(item);
                      }
                      break;
                    case 'Meeting Room':
                      if (details.localPosition.dx >= 600 && // Increased tap area
                          details.localPosition.dx <= 900 && // Increased tap area
                          details.localPosition.dy >= 300 && // Increased tap area
                          details.localPosition.dy <= 600) { // Increased tap area
                        checkItemFound(item);
                      }
                      break;
                    case 'TV':
                      if (details.localPosition.dx >= 0 && // Increased tap area
                          details.localPosition.dx <= 300 && // Increased tap area
                          details.localPosition.dy >= 0 && // Increased tap area
                          details.localPosition.dy <= 300) { // Increased tap area
                        checkItemFound(item);
                      }
                      break;
                    case '3D Printer':
                      if (details.localPosition.dx >= 300 && // Increased tap area
                          details.localPosition.dx <= 600 && // Increased tap area
                          details.localPosition.dy >= 400 && // Increased tap area
                          details.localPosition.dy <= 700) { // Increased tap area
                        checkItemFound(item);
                      }
                      break;
                  }
                },
                child: CustomPaint(
                  painter: HighlightPainter(
                    itemName: item,
                    isFound: foundItems[item]!,
                    imageSize: Size(MediaQuery.of(context).size.width,
                        MediaQuery.of(context).size.height),
                  ),
                ),
              ),
            );
          }).toList(),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: itemsToFind.map((item) {
            return Chip(
              label: Text(item),
              backgroundColor: foundItems[item]! ? Colors.green : Colors.grey,
            );
          }).toList(),
        ),
      ),
    );
  }
}

class HighlightPainter extends CustomPainter {
  final String itemName;
  final bool isFound;
  final Size imageSize;

  HighlightPainter({
    required this.itemName,
    required this.isFound,
    required this.imageSize,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (!isFound) return;

    final paint = Paint()
      ..color = Colors.red.withOpacity(0.5)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 5;

    // Highlight the clickable areas even if the item is not found
    switch (itemName) {
      case 'Computer':
        canvas.drawRect(Rect.fromLTWH(100, 200, 300, 300), paint);
        break;
      case 'Whiteboard':
        canvas.drawRect(Rect.fromLTWH(400, 100, 300, 300), paint);
        break;
      case 'Meeting Room':
        canvas.drawRect(Rect.fromLTWH(600, 300, 300, 300), paint);
        break;
      case 'TV':
        canvas.drawRect(Rect.fromLTWH(0, 0, 300, 300), paint);
        break;
      case '3D Printer':
        canvas.drawRect(Rect.fromLTWH(300, 400, 300, 300), paint);
        break;
    }
    
    // If the item is found, draw a filled rectangle on top
    if (isFound) {
      final fillPaint = Paint()
        ..color = Colors.green.withOpacity(0.5)
        ..style = PaintingStyle.fill;

      switch (itemName) {
        case 'Computer':
          canvas.drawRect(Rect.fromLTWH(100, 200, 300, 300), fillPaint);
          break;
        case 'Whiteboard':
          canvas.drawRect(Rect.fromLTWH(400, 100, 300, 300), fillPaint);
          break;
        case 'Meeting Room':
          canvas.drawRect(Rect.fromLTWH(600, 300, 300, 300), fillPaint);
          break;
        case 'TV':
          canvas.drawRect(Rect.fromLTWH(0, 0, 300, 300), fillPaint);
          break;
        case '3D Printer':
          canvas.drawRect(Rect.fromLTWH(300, 400, 300, 300), fillPaint);
          break;
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
