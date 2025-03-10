import 'package:flutter/material.dart';

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

  // Centralized definition of all item areas
  final Map<String, Rect> itemAreas = {
    'Computer': Rect.fromLTWH(100, 200, 300, 300),
    'Whiteboard': Rect.fromLTWH(400, 100, 300, 300),
    'Meeting Room': Rect.fromLTWH(600, 300, 300, 300),
    'TV': Rect.fromLTWH(0, 0, 300, 300),
    '3D Printer': Rect.fromLTWH(300, 400, 300, 300),
  };

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
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            // Navigate back to the previous screen
            Navigator.of(context).pop();
          },
          tooltip: 'Back',
        ),
      ),
      body: GestureDetector(
        onTapDown: (details) {
          final position = details.localPosition;
          print("Tap at: ${position.dx}, ${position.dy}");
          
          // Check if the tap position is within any of the item areas
          itemAreas.forEach((itemName, rect) {
            if (rect.contains(Offset(position.dx, position.dy))) {
              checkItemFound(itemName);
            }
          });
        },
        child: Stack(
          children: [
            Image.network(
              imageUrl,
              width: double.infinity,
              height: double.infinity,
              fit: BoxFit.cover,
            ),
            // Overlay for item highlighting
            CustomPaint(
              size: Size.infinite,
              painter: HighlightPainter(
                foundItems: foundItems,
                itemAreas: itemAreas,
              ),
            ),
          ],
        ),
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
  final Map<String, bool> foundItems;
  final Map<String, Rect> itemAreas;

  HighlightPainter({
    required this.foundItems,
    required this.itemAreas,
  });

  @override
  void paint(Canvas canvas, Size size) {
    // Draw outlines for all items
    final outlinePaint = Paint()
      ..color = Colors.red.withOpacity(0.5)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 5;

    itemAreas.forEach((itemName, rect) {
      canvas.drawRect(rect, outlinePaint);
    });

    // Draw fill for found items
    final fillPaint = Paint()
      ..color = Colors.green.withOpacity(0.5)
      ..style = PaintingStyle.fill;

    foundItems.forEach((itemName, isFound) {
      if (isFound && itemAreas.containsKey(itemName)) {
        canvas.drawRect(itemAreas[itemName]!, fillPaint);
      }
    });
  }

  @override
  bool shouldRepaint(covariant HighlightPainter oldDelegate) {
    return oldDelegate.foundItems != foundItems;
  }
}