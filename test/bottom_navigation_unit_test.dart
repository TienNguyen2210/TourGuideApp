import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tour_guide_app/pages/home_page.dart';
import 'package:tour_guide_app/pages/user_post_page.dart';
import 'package:tour_guide_app/pages/profile_page.dart';
import 'package:tour_guide_app/pages/search_page.dart';
import 'package:tour_guide_app/bottom_navigation.dart';

void main() {
  group('BottomNavigation Widget Tests', () {
    testWidgets('Initial state has HomeScreen selected', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: BottomNavigation()));

      expect(find.byType(HomeScreen), findsOneWidget);
      expect(find.byType(SearchScreen), findsNothing);
      expect(find.byType(UserPostScreen), findsNothing);
      expect(find.byType(ProfileScreen), findsNothing);
    });

    testWidgets('Tapping Search icon shows SearchScreen', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: BottomNavigation()));
      await tester.tap(find.byIcon(Icons.search));
      await tester.pumpAndSettle();

      expect(find.byType(HomeScreen), findsNothing);
      expect(find.byType(SearchScreen), findsOneWidget);
      expect(find.byType(UserPostScreen), findsNothing);
      expect(find.byType(ProfileScreen), findsNothing);
    });

    testWidgets('Tapping Post icon shows UserPostScreen', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: BottomNavigation()));
      await tester.tap(find.byIcon(Icons.podcasts));
      await tester.pumpAndSettle();

      expect(find.byType(HomeScreen), findsNothing);
      expect(find.byType(SearchScreen), findsNothing);
      expect(find.byType(UserPostScreen), findsOneWidget);
      expect(find.byType(ProfileScreen), findsNothing);
    });

  });
}