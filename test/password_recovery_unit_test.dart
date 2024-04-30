import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tour_guide_app/pages/login_page.dart';
import 'package:tour_guide_app/service/auth.dart';

class MockAuth extends Mock implements Auth {}
class MockUserCredential extends Mock implements UserCredential {}
class MockNavigatorObserver extends Mock implements NavigatorObserver {}

void main() {
  group('LoginScreen Tests', () {
    late MockAuth mockAuth;
    late MockNavigatorObserver mockNavigatorObserver;

    setUp(() {
      mockAuth = MockAuth();
      mockNavigatorObserver = MockNavigatorObserver();
    });

    testWidgets('Sign in using email and password', (WidgetTester tester) async {
      when(mockAuth.signInWithEmailAndPassword(
          email: 'account@gmail.com', password: 'password123'))
          .thenAnswer((_) async => MockUserCredential());

      await tester.pumpWidget(MaterialApp(
        home: LoginScreen(),
        navigatorObservers: [mockNavigatorObserver],
      ));

      await tester.enterText(find.byType(TextField).at(0), 'account@gmail.com');
      await tester.enterText(find.byType(TextField).at(1), 'password123');

      await tester.tap(find.widgetWithText(ElevatedButton, 'Sign In'));
      await tester.pumpAndSettle();

      verify(mockAuth.signInWithEmailAndPassword(email: 'account@gmail.com', password: 'password123')).called(1);
    });
  });
}
