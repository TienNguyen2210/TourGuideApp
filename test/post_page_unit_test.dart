import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tour_guide_app/pages/post_page.dart';

void main() {
  group('PostScreen Tests', () {
    testWidgets('dropdown, rating, and text field widgets update and post is created', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: PostScreen()));

      expect(find.text('Choose a category'), findsOneWidget);
      expect(find.byIcon(Icons.star), findsNWidgets(5));
      expect(find.text('Enter description'), findsOneWidget);

      await tester.tap(find.text('Choose a category'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Restaurant').last);
      await tester.pumpAndSettle();

      await tester.tap(find.byIcon(Icons.star).at(3));
      await tester.pumpAndSettle();

      await tester.enterText(find.byType(TextField), 'Great place to visit');
      await tester.pump();

      await tester.tap(find.byType(ElevatedButton));
      await tester.pump();

      expect(find.text('Post Created'), findsOneWidget);
      expect(find.textContaining('Category: Restaurant'), findsOneWidget);
      expect(find.textContaining('Rating: 4.0'), findsOneWidget);
      expect(find.textContaining('Description: Great place to visit'), findsOneWidget);

      await tester.tap(find.text('OK'));
      await tester.pump();
    });

  });
}
