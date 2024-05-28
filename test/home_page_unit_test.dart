import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tour_guide_app/pages/home_page.dart'; // Ensure this import is correct
import 'package:mockito/mockito.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:mockito/annotations.dart';

class MockGeolocator extends Mock implements GeolocatorPlatform {}
class MockGoogleMapsPlaces extends Mock implements GoogleMapsPlaces {}

@GenerateMocks([GeolocatorPlatform, GoogleMapsPlaces])
void main() {
  group('HomeScreen Tests', () {
    testWidgets('HomeScreen initializes and shows CircularProgressIndicator', (WidgetTester tester) async {
      // Create the widget by pumping it into the tester
      await tester.pumpWidget(MaterialApp(home: HomeScreen()));

      // Initially, the CircularProgressIndicator should be found
      expect(find.byType(CircularProgressIndicator), findsOneWidget);

      // Check that no other widgets like Text or images are displayed yet
      expect(find.text('Experiences in spotlight'), findsNothing);
    });

    group('HomeScreen Displays Location', () {
      testWidgets('HomeScreen shows the current location after it is fetched', (WidgetTester tester) async {
        // Create mock
        final mockGeolocator = MockGeolocator();
        GeolocatorPlatform.instance = mockGeolocator;

        // Setup mock responses
        when(mockGeolocator.isLocationServiceEnabled()).thenAnswer((_) async => true);
        when(mockGeolocator.checkPermission()).thenAnswer((_) async => LocationPermission.always);
        when(mockGeolocator.getCurrentPosition()).thenAnswer((_) async =>
            Position(
                latitude: 37.7749,
                longitude: -122.4194,
                timestamp: DateTime.now(),
                altitude: 0,
                heading: 0,
                speed: 0,
                accuracy: 0,
                speedAccuracy: 0,
                altitudeAccuracy: 0,
                headingAccuracy: 0
            ));

        // Set up the test widget
        await tester.pumpWidget(MaterialApp(home: HomeScreen()));

        // Initially, verify that a CircularProgressIndicator is shown
        expect(find.byType(CircularProgressIndicator), findsOneWidget);

        // Trigger a frame
        await tester.pumpAndSettle();

        // Check if the fetched location is displayed
        expect(find.text('San Francisco, USA'), findsOneWidget); // Assuming the location is processed to show this string
      });
    });
  });
}
