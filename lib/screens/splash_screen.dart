import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pushReplacementNamed(context, '/onboarding');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Logo halne
            Image.asset('assets/images/Trekly_logo_with_text.png', height: 500),

            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}

// Updated splash screen timing and UI layout

// Splash screen UI updated for Sprint 1 demo
// Splash screen UI updated for Sprint 1 demo
