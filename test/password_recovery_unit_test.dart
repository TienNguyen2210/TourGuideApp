import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tour_guide_app/pages/password_recovery.dart';

class MockNavigatorObserver extends Mock implements NavigatorObserver {}

void main() {
  group('PasswordRecoveryScreen Widget Test', () {
    testWidgets('Widget renders correctly', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        home: PasswordRecoveryScreen(),
      ));

      expect(find.text('Password Recovery'), findsOneWidget);
      expect(find.text('Enter your email'), findsOneWidget);
      expect(find.text('Email'), findsOneWidget);
      expect(find.text('Send Email'), findsOneWidget);
    });

    testWidgets('Invalid email submission', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        home: PasswordRecoveryScreen(),
      ));

      await tester.tap(find.text('Send Email'));
      await tester.pump();

      expect(find.text('             *Please enter Email'), findsOneWidget);
    });
  });
}
