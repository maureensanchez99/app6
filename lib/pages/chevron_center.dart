import 'package:flutter/material.dart';
import 'home_page.dart';

class ChevronCenter extends StatelessWidget {
  const ChevronCenter({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chevron Center',
      theme: ThemeData(
        primaryColor: const Color(0xFF461D7C), // LSU Purple
        scaffoldBackgroundColor: const Color(0xFFFDD023),
      ),
      routes: {
        '/home': (context) => HomePage(title: 'home_page',),
      },
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

  // Updated coordinates for item areas
  final Map<String, Rect> itemAreas = {
    'Computer': Rect.fromLTWH(575, 230, 150, 125),
    'Whiteboard': Rect.fromLTWH(625, 95, 85, 120),
    'Meeting Room': Rect.fromLTWH(1100, 25, 300, 240),
    'TV': Rect.fromLTWH(900, 10, 100, 125),
    '3D Printer': Rect.fromLTWH(720, 120, 100, 100),
  };

  // Descriptions for each item - easy to edit
  final Map<String, String> itemDescriptions = {
    'Computer': 'A powerful workstation used for engineering design, simulations, and programming. Students use these computers to work on various projects and assignments.',
    'Whiteboard': 'A collaborative tool where students and Chevron Center turors sketch designs, work through problems, and share ideas. Essential for group discussions and brainstorming.',
    'Meeting Room': 'A space where students, faculty, and industry partners gather to discuss projects, conduct meetings, and collaborate on research initiatives. This is the only meeting room in PFT that allows only students to book it.',
    'TV': 'A display screen used for presentations, showing educational content, and sharing digital information with groups of students and visitors.',
    '3D Printer': 'An advanced manufacturing device that creates three-dimensional objects layer by layer. Students use it to prototype designs and create engineering models. Bring your own 3D Printing Material!',
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
    // Only show popup and mark as found if not already found
    if (!foundItems[itemName]!) {
      // Show popup with description
      showItemPopup(itemName);
      
      setState(() {
        foundItems[itemName] = true;
      });

      // Check if all items are found
      if (foundItems.values.every((found) => found)) {
        // All items found, show a dialog or navigate to a new screen
        // Delay slightly to allow the last item popup to be seen first
        Future.delayed(const Duration(seconds: 2), () {
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
        });
      }
    }
  }

  void showItemPopup(String itemName) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('You found the $itemName!'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(itemDescriptions[itemName] ?? 'No description available.'),
            const SizedBox(height: 16),
            Text(
              '${foundItems.values.where((found) => found).length} of ${itemsToFind.length} items found!',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Continue Exploring'),
          ),
        ],
      ),
    );
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
        title: const Text('Find the Items Below in the Picture'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            // Navigate back to the previous screen
            Navigator.pushReplacementNamed(context, '/home');
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
              print("$itemName tapped");
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
              backgroundColor: foundItems[item]! ? const Color(0xFF461D7C) : const Color(0xFFFDD023),
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
    // final outlinePaint = Paint()
    //   ..color = Colors.red.withOpacity(0.5)
    //   ..style = PaintingStyle.stroke
    //   ..strokeWidth = 5;

    // itemAreas.forEach((itemName, rect) {
    //   canvas.drawRect(rect, outlinePaint);
    // });

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