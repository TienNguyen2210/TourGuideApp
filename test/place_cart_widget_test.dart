import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tour_guide_app/widgets/place_card.dart';
import 'package:tour_guide_app/models/place.dart';

void main() {
  group('PlaceCard Widget Tests', () {
    testWidgets('PlaceCard displays place information correctly', (WidgetTester tester) async {

      final samplePlace = Place(
        id: '001',
        name: 'Golden Gate Bridge',
        type: 'Bridge',
        rating: '4.8',
        image: 'http://example.com/image.jpg',
      );

      await tester.pumpWidget(MaterialApp(home: Scaffold(body: PlaceCard(place: samplePlace))));

      expect(find.byType(Image), findsOneWidget);
      final Image imageWidget = tester.widget(find.byType(Image)) as Image;
      expect((imageWidget.image as NetworkImage).url, equals('http://example.com/image.jpg'));

      expect(find.text('Bridge'), findsOneWidget);
      expect(find.text('Golden Gate Bridge'), findsOneWidget);
      expect(find.text('4.8'), findsOneWidget);

      final ratingFinder = find.text('4.8');
      expect(ratingFinder, findsOneWidget);

      final TextStyle ratingStyle = (tester.widget<Text>(ratingFinder)).style!;
      expect(ratingStyle.color, equals(Colors.white));
      expect(ratingStyle.fontSize, 14.0);
      expect(ratingStyle.fontWeight, FontWeight.bold);
    });
  });
}
