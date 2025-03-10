import 'package:flutter/material.dart';
import 'tutorial_page.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> with SingleTickerProviderStateMixin {
  // LSU colors
  static const Color lsuPurple = Color(0xFF461D7C); // LSU Purple
  static const Color lsuGold = Color(0xFFFDD023);   // LSU Gold
  
  late AnimationController _animationController;
  bool _isZooming = false;
  double _zoomScale = 1.0;
  
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

  // Start zoom animation and navigate to tutorial page
  void _startZoomAndNavigate(BuildContext context) {
    setState(() {
      _isZooming = true;
    });
    
    // Animate the zoom effect
    Future.delayed(const Duration(milliseconds: 100), () {
      setState(() {
        _zoomScale = 8.0; // zzzoooooom speeeedd
      });
    });
    
    // Navigate after zoom animation completes
    Future.delayed(const Duration(milliseconds: 800), () {
      Navigator.of(context).push(
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => const TutorialPage(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(
              opacity: animation,
              child: child,
            );
          },
          transitionDuration: const Duration(milliseconds: 300),
        ),
      ).then((_) {
        // Reset the welcome screen when returning
        setState(() {
          _isZooming = false;
          _zoomScale = 1.0;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Tiger image zoom animation CHATGPT cooked this one chat
              AnimatedContainer(
                duration: const Duration(milliseconds: 700),
                curve: Curves.easeInOut,
                transform: Matrix4.identity()
                  ..scale(_zoomScale),
                transformAlignment: Alignment.center,
                child: Image.asset(
                  'assets/tiger.png',
                  width: 150,
                  height: 150,
                ),
              ),
              if (!_isZooming) ...[
                const Text( 
                  'Welcome to the PFT Scavenger Hunt',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 25),
                ElevatedButton(
                  onPressed: () {
                    _startZoomAndNavigate(context);
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
                    'Continue',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
