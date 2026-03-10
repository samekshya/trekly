import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:trekly/features/upload/presentation/upload_image_screen.dart';

Widget buildTestApp(Widget child) {
  return MaterialApp(home: child);
}

void main() {
  testWidgets('1) screen loads without crashing', (tester) async {
    await tester.pumpWidget(buildTestApp(const UploadImageScreen()));

    expect(find.byType(UploadImageScreen), findsOneWidget);
  });

  testWidgets('2) Pick Image button is visible', (tester) async {
    await tester.pumpWidget(buildTestApp(const UploadImageScreen()));

    expect(find.text('Pick Image'), findsOneWidget);
  });

  testWidgets('3) Upload button is visible', (tester) async {
    await tester.pumpWidget(buildTestApp(const UploadImageScreen()));

    expect(find.text('Upload to Server'), findsOneWidget);
  });

  testWidgets('4) AppBar title is correct', (tester) async {
    await tester.pumpWidget(buildTestApp(const UploadImageScreen()));

    expect(find.text('Sprint 5: Upload Image'), findsOneWidget);
  });

  testWidgets('5) Upload without image shows error text', (tester) async {
    await tester.pumpWidget(buildTestApp(const UploadImageScreen()));

    await tester.tap(find.text('Upload to Server'));
    await tester.pump();

    expect(find.text('Please pick an image first.'), findsOneWidget);
  });
}
