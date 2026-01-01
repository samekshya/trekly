import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'app/app.dart';
import 'core/services/hive_services.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await HiveService.init();
  runApp(const ProviderScope(child: App()));
}

// import 'package:flutter/material.dart';
// import 'screens/splash_screen.dart';
// import 'screens/onboarding_screen.dart';
// import 'screens/login_screen.dart';
// import 'screens/register_screen.dart';
// import 'screens/home_screen.dart';
// import 'screens/bottom_screen/bottomnavigation_screen.dart';
// import 'app/app.dart';
// import 'core/services/hive_services.dart';

// void main() {
//   runApp(const MyApp());
// }

// Future<void> main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await HiveService.init();
//   runApp(const App());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       initialRoute: '/splash',
//       routes: {
//         '/splash': (_) => const SplashScreen(),
//         '/onboarding': (_) => const OnboardingScreen(),
//         '/login': (_) => const LoginScreen(),
//         '/register': (_) => const RegisterScreen(),
//         '/home': (_) => const BottomNavigationScreen(),
//       },
//     );
//   }
// }
