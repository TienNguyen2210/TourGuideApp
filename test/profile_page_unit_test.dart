import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tour_guide_app/service/auth.dart';
import 'package:provider/provider.dart';
import 'package:tour_guide_app/pages/profile_page.dart';
import 'package:tour_guide_app/pages/login_page.dart';

class MockAuth extends Mock implements Auth {}
class MockNavigatorObserver extends Mock implements NavigatorObserver {}


void main() {
  group('profileScreen Tests', () {
    group('LoginScreen Tests', () {
      late MockAuth mockAuth;
      late MockNavigatorObserver mockNavigatorObserver;

      setUp(() {
        mockAuth = MockAuth();
        mockNavigatorObserver = MockNavigatorObserver();
      });

      Widget makeTestableWidget({required Widget child}) {
        return MaterialApp(
          home: Provider<Auth>(
            create: (_) => mockAuth,
            child: child,
          ),
          navigatorObservers: [mockNavigatorObserver],
        );
      }

      testWidgets('LoginScreen loads and shows expected widgets', (WidgetTester tester) async {
        await tester.pumpWidget(makeTestableWidget(child: const LoginScreen()));

        expect(find.text('Welcome to Tourmate!'), findsOneWidget);
        expect(find.image(AssetImage('assets/cover.jpg')), findsOneWidget);
        expect(find.text('Discover personalized recommendations, save your favorite locations, and share your experiences with others.'), findsOneWidget);
        expect(find.byType(TextField), findsNWidgets(2));
      });
    });

  });
}