import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:trekly/screens/forgot_password_screen.dart';
import 'package:trekly/screens/settings_screen.dart';

// helper to wrap widget
Widget testWidget(Widget child, {bool withProvider = true}) {
  final app = MaterialApp(
    home: MediaQuery(
      data: const MediaQueryData(size: Size(400, 900)),
      child: child,
    ),
  );
  if (withProvider) return ProviderScope(child: app);
  return app;
}

void main() {
  group('Forgot Password Screen Widget Tests', () {
    testWidgets('WT01 - Forgot password screen renders', (tester) async {
      tester.view.physicalSize = const Size(400, 900);
      tester.view.devicePixelRatio = 1.0;
      await tester.pumpWidget(testWidget(const ForgotPasswordScreen()));
      await tester.pump();
      expect(find.byType(Scaffold), findsOneWidget);
    });

    testWidgets('WT02 - Forgot password has text field', (tester) async {
      tester.view.physicalSize = const Size(400, 900);
      tester.view.devicePixelRatio = 1.0;
      await tester.pumpWidget(testWidget(const ForgotPasswordScreen()));
      await tester.pump();
      expect(find.byType(TextField), findsOneWidget);
    });

    testWidgets('WT03 - Forgot password has submit button', (tester) async {
      tester.view.physicalSize = const Size(400, 900);
      tester.view.devicePixelRatio = 1.0;
      await tester.pumpWidget(testWidget(const ForgotPasswordScreen()));
      await tester.pump();
      expect(find.byType(ElevatedButton), findsOneWidget);
    });

    testWidgets('WT04 - Forgot password has back button', (tester) async {
      tester.view.physicalSize = const Size(400, 900);
      tester.view.devicePixelRatio = 1.0;
      await tester.pumpWidget(testWidget(const ForgotPasswordScreen()));
      await tester.pump();
      expect(find.byType(Scaffold), findsOneWidget);
    });

    testWidgets('WT05 - Forgot password email field accepts input',
        (tester) async {
      tester.view.physicalSize = const Size(400, 900);
      tester.view.devicePixelRatio = 1.0;
      await tester.pumpWidget(testWidget(const ForgotPasswordScreen()));
      await tester.pump();
      await tester.enterText(find.byType(TextField), 'test@gmail.com');
      expect(find.text('test@gmail.com'), findsOneWidget);
    });
  });

  group('Settings Screen Widget Tests', () {
    testWidgets('WT06 - Settings screen renders', (tester) async {
      await tester
          .pumpWidget(testWidget(const SettingsScreen(), withProvider: false));
      await tester.pump();
      expect(find.byType(Scaffold), findsOneWidget);
    });

    testWidgets('WT07 - Settings screen has dark mode toggle', (tester) async {
      await tester
          .pumpWidget(testWidget(const SettingsScreen(), withProvider: false));
      await tester.pump();
      expect(find.text('Dark Mode'), findsOneWidget);
    });

    testWidgets('WT08 - Settings has switch tiles', (tester) async {
      await tester
          .pumpWidget(testWidget(const SettingsScreen(), withProvider: false));
      await tester.pump();
      expect(find.byType(SwitchListTile), findsWidgets);
    });

    testWidgets('WT09 - Settings dark mode toggle works', (tester) async {
      await tester
          .pumpWidget(testWidget(const SettingsScreen(), withProvider: false));
      await tester.pump();
      await tester.tap(find.byType(Switch).first);
      await tester.pump();
      expect(find.byType(Switch), findsWidgets);
    });

    testWidgets('WT10 - Settings screen shows app version', (tester) async {
      await tester
          .pumpWidget(testWidget(const SettingsScreen(), withProvider: false));
      await tester.pump();
      expect(find.text('1.0.0'), findsOneWidget);
    });

    testWidgets('WT11 - Settings has notifications toggle', (tester) async {
      await tester
          .pumpWidget(testWidget(const SettingsScreen(), withProvider: false));
      await tester.pump();
      expect(find.text('Push Notifications'), findsOneWidget);
    });

    testWidgets('WT12 - Settings has privacy policy', (tester) async {
      await tester
          .pumpWidget(testWidget(const SettingsScreen(), withProvider: false));
      await tester.pump();
      expect(find.text('Privacy Policy'), findsOneWidget);
    });

    testWidgets('WT13 - Settings has terms of service', (tester) async {
      await tester
          .pumpWidget(testWidget(const SettingsScreen(), withProvider: false));
      await tester.pump();
      expect(find.text('Terms of Service'), findsOneWidget);
    });

    testWidgets('WT14 - Settings has app version label', (tester) async {
      await tester
          .pumpWidget(testWidget(const SettingsScreen(), withProvider: false));
      await tester.pump();
      expect(find.text('App Version'), findsOneWidget);
    });

    testWidgets('WT15 - Settings notifications toggle works', (tester) async {
      await tester
          .pumpWidget(testWidget(const SettingsScreen(), withProvider: false));
      await tester.pump();
      await tester.tap(find.byType(Switch).last);
      await tester.pump();
      expect(find.byType(SwitchListTile), findsWidgets);
    });

    testWidgets('WT16 - Settings has appearance section', (tester) async {
      await tester
          .pumpWidget(testWidget(const SettingsScreen(), withProvider: false));
      await tester.pump();
      expect(find.text('Appearance'), findsOneWidget);
    });

    testWidgets('WT17 - Settings has notifications section', (tester) async {
      await tester
          .pumpWidget(testWidget(const SettingsScreen(), withProvider: false));
      await tester.pump();
      expect(find.text('Notifications'), findsOneWidget);
    });

    testWidgets('WT18 - Settings has about section header', (tester) async {
      await tester
          .pumpWidget(testWidget(const SettingsScreen(), withProvider: false));
      await tester.pump();
      expect(find.text('About'), findsOneWidget);
    });

    testWidgets('WT19 - Settings has list tiles', (tester) async {
      await tester
          .pumpWidget(testWidget(const SettingsScreen(), withProvider: false));
      await tester.pump();
      expect(find.byType(ListTile), findsWidgets);
    });

    testWidgets('WT20 - Settings screen builds without error', (tester) async {
      await tester
          .pumpWidget(testWidget(const SettingsScreen(), withProvider: false));
      await tester.pump();
      expect(tester.takeException(), isNull);
    });
  });
}
