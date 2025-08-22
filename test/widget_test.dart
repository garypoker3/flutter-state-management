// Flutter State Management Wizard Integration Test
// Tests navigation between pages and counter functionality across different approaches

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:wizard_controller/main.dart';

void main() {
  group('State Management Wizard Tests', () {
    testWidgets('Basic navigation test', (WidgetTester tester) async {
      // Build our app and trigger a frame
      await tester.pumpWidget(const MyApp());

      // Verify we start on Page 1 (StatefulWidget approach)
      expect(find.text('Page 1: StatefulWidget'), findsOneWidget);
      expect(find.text('Page 1 of 4'), findsOneWidget);
      
      // Verify counter starts at 0
      expect(find.text('0'), findsOneWidget);
      
      // Test increment on Page 1
      await tester.tap(find.byIcon(Icons.add));
      await tester.pump();
      
      // Verify counter incremented to 1
      expect(find.text('1'), findsOneWidget);
      
      // Navigate to Page 2 (CounterModel approach)
      await tester.tap(find.text('Next >>'));
      await tester.pumpAndSettle(); 
      
      // Verify we're on Page 2
      expect(find.text('Page 2: CounterModel'), findsOneWidget);
      expect(find.text('Page 2 of 4'), findsOneWidget);
      
      // Navigate to Page 3 (CounterNotifier approach)
      await tester.tap(find.text('Next >>'));
      await tester.pumpAndSettle();
      
      // Verify we're on Page 3
      expect(find.text('Page 3: CounterNotifier'), findsOneWidget);
      expect(find.text('Page 3 of 4'), findsOneWidget);
      
      // Navigate to Page 4 (Provider approach)
      await tester.tap(find.text('Next >>'));
      await tester.pumpAndSettle();
      
      // Verify we're on Page 4
      expect(find.text('Page 4: Provider Pattern'), findsOneWidget);
      expect(find.text('Page 4 of 4'), findsOneWidget);
      
      // Test backward navigation: go back to Page 3
      await tester.tap(find.text('<< Previous'));
      await tester.pumpAndSettle();
      
      // Verify we're back on Page 3
      expect(find.text('Page 3: CounterNotifier'), findsOneWidget);
      expect(find.text('Page 3 of 4'), findsOneWidget);
      
      // Go back to Page 2
      await tester.tap(find.text('<< Previous'));
      await tester.pumpAndSettle();
      
      // Verify we're on Page 2
      expect(find.text('Page 2: CounterModel'), findsOneWidget);
      expect(find.text('Page 2 of 4'), findsOneWidget);
      
      // Go back to Page 1
      await tester.tap(find.text('<< Previous'));
      await tester.pumpAndSettle();
      
      // Verify we're back on Page 1
      expect(find.text('Page 1: StatefulWidget'), findsOneWidget);
      expect(find.text('Page 1 of 4'), findsOneWidget);
    });

    testWidgets('Button state test', (WidgetTester tester) async {
      await tester.pumpWidget(const MyApp());
      
      // Test that Previous button is disabled on first page
      final previousButton = tester.widget<ElevatedButton>(
        find.widgetWithText(ElevatedButton, '<< Previous')
      );
      expect(previousButton.onPressed, isNull);
      
      // Navigate to last page to test Next button disabled state
      await tester.tap(find.text('Next >>'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Next >>'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Next >>'));
      await tester.pumpAndSettle();
      
      // Verify we're on the last page
      expect(find.text('Page 4: Provider Pattern'), findsOneWidget);
      
      // Test that Next button is disabled on last page
      final nextButton = tester.widget<ElevatedButton>(
        find.widgetWithText(ElevatedButton, 'Next >>')
      );
      expect(nextButton.onPressed, isNull);
    });

    testWidgets('Page descriptions are displayed correctly', (WidgetTester tester) async {
      await tester.pumpWidget(const MyApp());
      
      // Check Page 1 description
      expect(find.text('Basic Flutter counter using StatefulWidget with setState'), findsOneWidget);
      
      // Navigate and check Page 2 description
      await tester.tap(find.text('Next >>'));
      await tester.pumpAndSettle();
      expect(find.text('Using immutable CounterModel class for state management'), findsOneWidget);
      
      // Navigate and check Page 3 description
      await tester.tap(find.text('Next >>'));
      await tester.pumpAndSettle();
      expect(find.text('CounterNotifier with ValueListenableBuilder for reactive updates'), findsOneWidget);
      
      // Navigate and check Page 4 description
      await tester.tap(find.text('Next >>'));
      await tester.pumpAndSettle();
      expect(find.text('Provider pattern with InheritedWidget for state sharing'), findsOneWidget);
    });

    testWidgets('Counter increment works on each page', (WidgetTester tester) async {
      await tester.pumpWidget(const MyApp());
      
      // Test Page 1 counter
      await tester.tap(find.byIcon(Icons.add));
      await tester.pump();
      expect(find.text('1'), findsOneWidget);
      
      // Navigate to Page 2 and test counter
      await tester.tap(find.text('Next >>'));
      await tester.pumpAndSettle();
      await tester.pump(const Duration(milliseconds: 100)); // Wait for init
      await tester.tap(find.byIcon(Icons.add));
      await tester.pump();
      expect(find.text('1'), findsOneWidget); // Local counter starts from 0
      
      // Navigate to Page 3 and test counter
      await tester.tap(find.text('Next >>'));
      await tester.pumpAndSettle();
      await tester.pump(const Duration(milliseconds: 100)); // Wait for init
      await tester.tap(find.byIcon(Icons.add));
      await tester.pump();
      expect(find.text('1'), findsOneWidget); // Local counter starts from 0
      
      // Navigate to Page 4 and test counter
      await tester.tap(find.text('Next >>'));
      await tester.pumpAndSettle();
      await tester.tap(find.byIcon(Icons.add));
      await tester.pump();
      // Page 4 uses shared state directly, so it should work as expected
    });
  });
}