import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../features/auth/presentation/viewmodels/auth_viewmodel.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // 2 second pachhi navigate garxa
    Future.delayed(const Duration(seconds: 2), () {
      if (!mounted) return;
      final isLoggedIn = ref.read(authViewModelProvider).isLoggedIn;
      if (isLoggedIn) {
        Navigator.pushReplacementNamed(context, '/home');
      } else {
        Navigator.pushReplacementNamed(context, '/onboarding');
      }
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
            Image.asset(
              'assets/images/Trekly_logo_with_text.png',
              height: 300,
              errorBuilder: (_, __, ___) => const Icon(
                Icons.terrain,
                size: 100,
                color: Color(0xFF00695C),
              ),
            ),
            const SizedBox(height: 24),
            const CircularProgressIndicator(
              color: Color(0xFF00695C),
            ),
          ],
        ),
      ),
    );
  }
}
