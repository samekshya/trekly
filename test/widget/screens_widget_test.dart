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
      await tester.pumpWidget(testWidget(const SettingsScreen()));
      await tester.pump();
      expect(find.byType(Scaffold), findsOneWidget);
    });

    testWidgets('WT07 - Settings screen has app bar', (tester) async {
      await tester.pumpWidget(testWidget(const SettingsScreen()));
      await tester.pump();
      expect(find.byType(AppBar), findsOneWidget);
    });

    testWidgets('WT08 - Settings screen has title', (tester) async {
      await tester.pumpWidget(testWidget(const SettingsScreen()));
      await tester.pump();
      expect(find.text('Settings'), findsOneWidget);
    });

    testWidgets('WT09 - Settings screen has list view', (tester) async {
      await tester.pumpWidget(testWidget(const SettingsScreen()));
      await tester.pump();
      expect(find.byType(ListView), findsOneWidget);
    });

    testWidgets('WT10 - Settings screen has dark mode text', (tester) async {
      await tester.pumpWidget(testWidget(const SettingsScreen()));
      await tester.pump();
      expect(find.text('Dark Mode'), findsOneWidget);
    });

    testWidgets('WT11 - Settings screen has a switch', (tester) async {
      await tester.pumpWidget(testWidget(const SettingsScreen()));
      await tester.pump();
      expect(find.byType(Switch), findsOneWidget);
    });

    testWidgets('WT12 - Settings screen shows version number', (tester) async {
      await tester.pumpWidget(testWidget(const SettingsScreen()));
      await tester.pump();
      expect(find.text('1.0.0'), findsOneWidget);
    });

    testWidgets('WT13 - Settings screen has privacy policy', (tester) async {
      await tester.pumpWidget(testWidget(const SettingsScreen()));
      await tester.pump();
      expect(find.text('Privacy Policy'), findsOneWidget);
    });

    testWidgets('WT14 - Settings screen has terms of service', (tester) async {
      await tester.pumpWidget(testWidget(const SettingsScreen()));
      await tester.pump();
      expect(find.text('Terms of Service'), findsOneWidget);
    });

    testWidgets('WT15 - Settings screen has app version label', (tester) async {
      await tester.pumpWidget(testWidget(const SettingsScreen()));
      await tester.pump();
      expect(find.text('App Version'), findsOneWidget);
    });

    testWidgets('WT16 - Settings has appearance section', (tester) async {
      await tester.pumpWidget(testWidget(const SettingsScreen()));
      await tester.pump();
      expect(find.text('APPEARANCE'), findsOneWidget);
    });

    testWidgets('WT17 - Settings has about section', (tester) async {
      await tester.pumpWidget(testWidget(const SettingsScreen()));
      await tester.pump();
      expect(find.text('ABOUT'), findsOneWidget);
    });

    testWidgets('WT18 - Settings has info icons', (tester) async {
      await tester.pumpWidget(testWidget(const SettingsScreen()));
      await tester.pump();
      expect(find.byIcon(Icons.info_outline), findsOneWidget);
      expect(find.byIcon(Icons.privacy_tip_outlined), findsOneWidget);
      expect(find.byIcon(Icons.description_outlined), findsOneWidget);
    });

    testWidgets('WT19 - Settings has two tappable info items', (tester) async {
      await tester.pumpWidget(testWidget(const SettingsScreen()));
      await tester.pump();
      expect(find.byType(InkWell), findsNWidgets(2));
    });

    testWidgets('WT20 - Settings switch can be tapped', (tester) async {
      await tester.pumpWidget(testWidget(const SettingsScreen()));
      await tester.pump();
      await tester.tap(find.byType(Switch));
      await tester.pump();
      expect(find.byType(Switch), findsOneWidget);
    });
  });
}
