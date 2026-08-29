import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:watch_app/main.dart';
import 'package:watch_app/pages/splash_page.dart';

void main() {
  testWidgets('Watch Store App renders SplashPage smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Verify that SplashPage is displayed.
    expect(find.byType(SplashPage), findsOneWidget);
    expect(find.byType(Image), findsOneWidget);
  });
}
