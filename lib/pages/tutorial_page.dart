import 'package:flutter/material.dart';
import 'home_page.dart';

class TutorialPage extends StatefulWidget {
  const TutorialPage({super.key});

  @override
  State<TutorialPage> createState() => _TutorialPageState();
}

class _TutorialPageState extends State<TutorialPage> with SingleTickerProviderStateMixin {
  // LSU colors
  static const Color lsuPurple = Color(0xFF461D7C); // LSU Purple
  static const Color lsuGold = Color(0xFFFDD023);   // LSU Gold
  
  late AnimationController _animationController;
  
  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat(reverse: true);
  }
  
  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  // Navigate to homepage with circle reveal animation
  void _navigateToHomeWithCircleAnimation(BuildContext context, Offset center) {
    final RenderBox buttonBox = context.findRenderObject() as RenderBox;
    final buttonPosition = buttonBox.localToGlobal(Offset.zero);
    final buttonSize = buttonBox.size;
    
    // Calculate the center of the button
    final buttonCenter = Offset(
      buttonPosition.dx + buttonSize.width / 2,
      buttonPosition.dy + buttonSize.height / 2,
    );
    
    // Calculate the maximum radius needed to cover the screen
    final screenSize = MediaQuery.of(context).size;
    final maxRadius = screenSize.height > screenSize.width 
        ? screenSize.height * 1.5 
        : screenSize.width * 1.5;
    
    Navigator.of(context).push(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => const HomePage(
          title: 'PFT Scavenger Hunt',
        ),
        transitionDuration: const Duration(milliseconds: 780),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return ClipPath(
            clipper: CircleRevealClipper(
              center: buttonCenter,
              radius: animation.value * maxRadius,
            ),
            child: child,
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('How to Play'),
        centerTitle: true,
        backgroundColor: lsuPurple,
        foregroundColor: lsuGold,
      ),
      body: AnimatedBuilder(
        animation: _animationController,
        builder: (context, child) {
          return Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color.lerp(lsuGold, lsuPurple, _animationController.value) ?? lsuGold,
                  Color.lerp(lsuPurple, lsuGold, _animationController.value) ?? lsuPurple,
                ],
              ),
            ),
            child: child,
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Tutorial',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: lsuPurple,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                Container(
                  constraints: const BoxConstraints(maxWidth: 300),
                  child: Column(
                    children: [
                      _buildTutorialStep(
                        '1',
                        'Navigate through different challenges in the PFT building.',
                      ),
                      _buildTutorialStep(
                        '2',
                        'Complete the Word Search puzzle to find hidden clues.',
                      ),
                      _buildTutorialStep(
                        '3',
                        'Explore the Third Floor to discover the mysteries.',
                      ),
                      _buildTutorialStep(
                        '4',
                        'Test your knowledge with the Pop Quiz challenge.',
                      ),
                      _buildTutorialStep(
                        '5',
                        'Visit Panera and answer questions to complete challenge.',
                      ),
                      _buildTutorialStep(
                        '6',
                        'Solve the anagram to find the next spot.',
                      ),
                      _buildTutorialStep(
                        '7',
                        'Find all the cool items in the Chevron Center and learn what they do',
                      ),
                      _buildTutorialStep(
                        '8',
                        'Figure out what the binary means to find the best professors in PFT!',
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 40),
                Builder(
                  builder: (context) => ElevatedButton(
                    onPressed: () {
                      _navigateToHomeWithCircleAnimation(context, Offset.zero);
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 40,
                        vertical: 15,
                      ),
                      backgroundColor: lsuGold,
                      foregroundColor: lsuPurple,
                    ),
                    child: const Text(
                      'Start the Hunt',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTutorialStep(String number, String description) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 30,
            height: 30,
            decoration: const BoxDecoration(
              color: lsuPurple,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                number,
                style: const TextStyle(
                  color: lsuGold,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Text(
              description,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Custom clipper for circle reveal animation
class CircleRevealClipper extends CustomClipper<Path> {
  final Offset center;
  final double radius;

  CircleRevealClipper({
    required this.center,
    required this.radius,
  });

  @override
  Path getClip(Size size) {
    return Path()
      ..addOval(
        Rect.fromCircle(
          center: center,
          radius: radius,
        ),
      );
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
