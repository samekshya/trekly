import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../core/providers/theme_provider.dart';

import '../screens/splash_screen.dart';
import '../screens/onboarding_screen.dart';
import '../screens/login_screen.dart';
import '../screens/register_screen.dart';
import '../screens/forgot_password_screen.dart';
import '../screens/trek_detail_screen.dart';
import '../screens/bottom_screen/bottomnavigation_screen.dart';
import 'package:trekly/features/upload/presentation/upload_image_screen.dart';
import '../screens/booking_screen.dart';
import '../screens/my_bookings_screen.dart';
import '../screens/settings_screen.dart';
import '../screens/weather_screen.dart';
import '../screens/change_password_screen.dart';
import '../screens/trekking_essentials_screen.dart';

class App extends ConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeModeProvider);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: themeMode,
      initialRoute: '/splash',
      routes: {
        '/splash': (_) => const SplashScreen(),
        '/onboarding': (_) => const OnboardingScreen(),
        '/login': (_) => const LoginScreen(),
        '/register': (_) => const RegisterScreen(),
        '/home': (_) => const BottomNavigationScreen(),
        '/upload': (_) => const UploadImageScreen(),
        '/forgot-password': (_) => const ForgotPasswordScreen(),
        '/booking': (_) => const BookingScreen(),
        '/my-bookings': (_) => const MyBookingsScreen(),
        '/settings': (_) => const SettingsScreen(),
        '/weather': (_) => const WeatherScreen(),
        '/change-password': (_) => const ChangePasswordScreen(),
        '/essentials': (context) => const TrekkingEssentialsScreen(),
      },
      onGenerateRoute: (settings) {
        if (settings.name == '/trek-detail') {
          return MaterialPageRoute(
            builder: (_) => const TrekDetailScreen(),
            settings: settings,
          );
        }
        if (settings.name == '/book') {
          return MaterialPageRoute(
            builder: (_) => const BookingScreen(),
            settings: settings,
          );
        }
        return null;
      },
    );
  }
}
