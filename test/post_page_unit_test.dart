import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tour_guide_app/pages/post_page.dart';

void main() {
  group('PostScreen Tests', () {
    testWidgets('dropdown, rating, name, description fields update and post is created', (WidgetTester tester) async {
      // Creating a MaterialApp with the PostScreen
      await tester.pumpWidget(MaterialApp(home: PostScreen()));

      // Initial expectations
      expect(find.text('Choose a category'), findsOneWidget);
      expect(find.byIcon(Icons.star), findsNWidgets(5)); // 5 stars for rating
      expect(find.text('Enter description'), findsOneWidget);
      expect(find.text('Enter post name'), findsOneWidget); // Added test for 'Enter post name'

      // Interacting with the category dropdown
      await tester.tap(find.text('Choose a category'));
      await tester.pumpAndSettle(); // Wait for dropdown animation
      await tester.tap(find.text('Restaurant').last);
      await tester.pumpAndSettle(); // Settle the dropdown

      // Setting the rating
      await tester.tap(find.byIcon(Icons.star).at(3)); // Simulate tapping the fourth star
      await tester.pumpAndSettle();

      // Entering text into the name field
      await tester.enterText(find.widgetWithText(TextField, 'Enter post name'), 'Sunset Views');
      await tester.pump();

      // Entering text into the description field
      await tester.enterText(find.widgetWithText(TextField, 'Enter description'), 'Great place to visit');
      await tester.pump();

      // Pressing the create post button
      await tester.tap(find.widgetWithText(ElevatedButton, 'Create Post'));
      await tester.pump(); // Trigger a frame

      // Assertions to verify if the AlertDialog shows the correct post creation details
      expect(find.text('Post Created'), findsOneWidget);
      expect(find.textContaining('Category: Restaurant'), findsOneWidget);
      expect(find.textContaining('Rating: 4.0'), findsOneWidget); // Assuming rating calculation starts from 0 and taps fourth star
      expect(find.textContaining('Name: Sunset Views'), findsOneWidget);
      expect(find.textContaining('Description: Great place to visit'), findsOneWidget);

      // Closing the dialog
      await tester.tap(find.text('OK'));
      await tester.pump(); // Final pump to settle the UI after the dialog is dismissed
    });
  });
  group('PostScreen Error Handling Tests', () {
    testWidgets('error dialog appears when not all fields are filled', (WidgetTester tester) async {
      // Set up the widget
      await tester.pumpWidget(MaterialApp(home: PostScreen()));

      // Fill only some fields (e.g., only the description)
      await tester.enterText(find.byType(TextField).at(0), 'Incomplete information'); // Assuming it finds the first TextField

      // Attempt to create post without filling all required fields
      await tester.tap(find.widgetWithText(ElevatedButton, 'Create Post'));
      await tester.pump();  // Need this pump to trigger the button's onPressed event

      // Check for error dialog
      expect(find.byType(AlertDialog), findsOneWidget);
      expect(find.text('Error'), findsOneWidget);
      expect(find.text('Please fill in all fields.'), findsOneWidget);

      // Close the dialog
      await tester.tap(find.text('OK'));
      await tester.pump();  // Ensure UI is settled after closing the dialog
    });
  });
}
