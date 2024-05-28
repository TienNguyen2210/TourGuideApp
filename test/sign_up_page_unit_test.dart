import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tour_guide_app/pages/signup_page.dart';
import 'package:tour_guide_app/service/auth.dart';

class MockAuth extends Mock implements Auth {}

void main() {
  group('SignUpScreen Tests', () {
    late MockAuth mockAuth;
    setUp(() {
      mockAuth = MockAuth();
      // Inject the mock into your app, assuming the Auth class is used as a provider or injected some other way.
    });

    Widget createWidgetUnderTest() {
      return MaterialApp(
        home: SignUpScreen(),
      );
    }
    testWidgets('renders correctly', (WidgetTester tester) async {
      await tester.pumpWidget(createWidgetUnderTest());
      expect(find.text('Welcome to Tourmate!'), findsOneWidget);
      expect(find.byType(TextField), findsNWidgets(3));
      expect(find.byType(ElevatedButton), findsOneWidget);
    });

    testWidgets('shows error message when passwords do not match', (WidgetTester tester) async {
      await tester.pumpWidget(createWidgetUnderTest());
      await tester.enterText(find.byType(TextField).at(1), 'password123');
      await tester.enterText(find.byType(TextField).at(2), 'password321');

      await tester.ensureVisible(find.text('Sign Up'));

      await tester.tap(find.text('Sign Up'));
      await tester.pump();
      expect(find.text('*** Passwords do not match'), findsOneWidget);
    });
  });
}