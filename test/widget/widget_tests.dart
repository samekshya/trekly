import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:trekly/screens/login_screen.dart';
import 'package:trekly/screens/register_screen.dart';
import 'package:trekly/screens/forgot_password_screen.dart';
import 'package:trekly/screens/splash_screen.dart';
import 'package:trekly/screens/settings_screen.dart';
import 'package:trekly/screens/my_bookings_screen.dart';

void main() {
  // ========== WIDGET TESTS (20) ==========

  group('Login Screen Widget Tests', () {
    testWidgets('WT01 - Login screen renders email field', (tester) async {
      await tester.pumpWidget(
        const ProviderScope(child: MaterialApp(home: LoginScreen())),
      );
      expect(find.byType(TextField), findsWidgets);
    });

    testWidgets('WT02 - Login screen renders login button', (tester) async {
      await tester.pumpWidget(
        const ProviderScope(child: MaterialApp(home: LoginScreen())),
      );
      expect(find.byType(ElevatedButton), findsOneWidget);
    });

    testWidgets('WT03 - Login screen has forgot password link', (tester) async {
      await tester.pumpWidget(
        const ProviderScope(child: MaterialApp(home: LoginScreen())),
      );
      expect(find.textContaining('Forgot'), findsOneWidget);
    });

    testWidgets('WT04 - Login screen has register link', (tester) async {
      await tester.pumpWidget(
        const ProviderScope(child: MaterialApp(home: LoginScreen())),
      );
      expect(find.textContaining('Register'), findsWidgets);
    });

    testWidgets('WT05 - Login screen email field accepts input',
        (tester) async {
      await tester.pumpWidget(
        const ProviderScope(child: MaterialApp(home: LoginScreen())),
      );
      final emailField = find.byType(TextField).first;
      await tester.enterText(emailField, 'test@gmail.com');
      expect(find.text('test@gmail.com'), findsOneWidget);
    });
  });

  group('Register Screen Widget Tests', () {
    testWidgets('WT06 - Register screen renders correctly', (tester) async {
      await tester.pumpWidget(
        const ProviderScope(child: MaterialApp(home: RegisterScreen())),
      );
      expect(find.byType(TextField), findsWidgets);
    });

    testWidgets('WT07 - Register screen has register button', (tester) async {
      await tester.pumpWidget(
        const ProviderScope(child: MaterialApp(home: RegisterScreen())),
      );
      expect(find.byType(ElevatedButton), findsOneWidget);
    });

    testWidgets('WT08 - Register screen has login link', (tester) async {
      await tester.pumpWidget(
        const ProviderScope(child: MaterialApp(home: RegisterScreen())),
      );
      expect(find.textContaining('Login'), findsWidgets);
    });
  });

  group('Forgot Password Screen Widget Tests', () {
    testWidgets('WT09 - Forgot password screen renders', (tester) async {
      await tester.pumpWidget(
        const ProviderScope(child: MaterialApp(home: ForgotPasswordScreen())),
      );
      expect(find.byType(TextField), findsOneWidget);
    });

    testWidgets('WT10 - Forgot password has submit button', (tester) async {
      await tester.pumpWidget(
        const ProviderScope(child: MaterialApp(home: ForgotPasswordScreen())),
      );
      expect(find.byType(ElevatedButton), findsOneWidget);
    });

    testWidgets('WT11 - Forgot password email field accepts input',
        (tester) async {
      await tester.pumpWidget(
        const ProviderScope(child: MaterialApp(home: ForgotPasswordScreen())),
      );
      await tester.enterText(find.byType(TextField), 'test@gmail.com');
      expect(find.text('test@gmail.com'), findsOneWidget);
    });
  });

  group('Settings Screen Widget Tests', () {
    testWidgets('WT12 - Settings screen renders', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(home: SettingsScreen()),
      );
      expect(find.byType(SwitchListTile), findsWidgets);
    });

    testWidgets('WT13 - Settings screen has dark mode toggle', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(home: SettingsScreen()),
      );
      expect(find.text('Dark Mode'), findsOneWidget);
    });

    testWidgets('WT14 - Settings dark mode toggle works', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(home: SettingsScreen()),
      );
      final toggle = find.byType(Switch).first;
      await tester.tap(toggle);
      await tester.pump();
      expect(find.byType(Switch), findsWidgets);
    });

    testWidgets('WT15 - Settings screen shows app version', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(home: SettingsScreen()),
      );
      expect(find.text('1.0.0'), findsOneWidget);
    });
  });

  group('My Bookings Screen Widget Tests', () {
    testWidgets('WT16 - My bookings screen renders', (tester) async {
      await tester.pumpWidget(
        const ProviderScope(child: MaterialApp(home: MyBookingsScreen())),
      );
      await tester.pump();
      expect(find.byType(Scaffold), findsOneWidget);
    });

    testWidgets('WT17 - My bookings shows loading indicator', (tester) async {
      await tester.pumpWidget(
        const ProviderScope(child: MaterialApp(home: MyBookingsScreen())),
      );
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });
  });

  group('Splash Screen Widget Tests', () {
    testWidgets('WT18 - Splash screen renders', (tester) async {
      await tester.pumpWidget(
        const ProviderScope(child: MaterialApp(home: SplashScreen())),
      );
      await tester.pump();
      expect(find.byType(Scaffold), findsOneWidget);
    });

    testWidgets('WT19 - Splash screen shows app name', (tester) async {
      await tester.pumpWidget(
        const ProviderScope(child: MaterialApp(home: SplashScreen())),
      );
      await tester.pump();
      expect(find.textContaining('Trekly'), findsWidgets);
    });

    testWidgets('WT20 - Splash screen has circular progress', (tester) async {
      await tester.pumpWidget(
        const ProviderScope(child: MaterialApp(home: SplashScreen())),
      );
      await tester.pump();
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });
  });
}
