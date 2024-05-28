import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tour_guide_app/pages/user_profile_page.dart';
import 'package:tour_guide_app/service/auth.dart';

class MockAuth extends Mock implements Auth {}
class MockUser extends Mock implements User {}

void main() {
  group('UserProfile Widget Tests', () {
    MockAuth mockAuth;
    MockUser mockUser;

    setUp(() {
      mockAuth = MockAuth();
      mockUser = MockUser();

      // Assuming `currentUser` returns a `User` object
      when(mockAuth.currentUser).thenReturn(mockUser);
      // Mocking the `email` property of the User object
      when(mockUser.email).thenReturn('test@example.com');
    });

    testWidgets('UserProfile displays user information and sign out button', (WidgetTester tester) async {
      // Wrap UserProfile in a MaterialApp for proper context
      await tester.pumpWidget(MaterialApp(home: UserProfile()));

      // Verify all the elements are present as expected
      expect(find.byType(CircleAvatar), findsOneWidget);
      expect(find.text('test@example.com'), findsOneWidget);
      expect(find.text('Sign Out'), findsOneWidget);
    });

    testWidgets('Sign out button works correctly', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: UserProfile()));

      // Tap the sign out button
      await tester.tap(find.text('Sign Out'));
      await tester.pumpAndSettle();

    });
  });
}
