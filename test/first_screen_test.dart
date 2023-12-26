import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:projecttest/first_screen.dart';

void main() {
  testWidgets('FirstScreen UI Test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(
      home: FirstScreen(),
    ));

    // Verify that the initial UI is correct.
    expect(find.text('Name'), findsOneWidget);
    expect(find.text('Sentence'), findsOneWidget);
    expect(find.byType(ElevatedButton), findsNWidgets(2));

    // Enter text into the Name and Sentence text fields.
    await tester.enterText(find.byKey(ValueKey('NameTextField')), 'John Doe');
    await tester.enterText(find.byKey(ValueKey('SentenceTextField')),
        'A man, a plan, a canal, Panama');

    // Tap the 'Check' button.
    await tester.tap(find.text('Check'));
    await tester.pump();

    // Verify that the palindrome checker dialog appears.
    expect(find.text('Palindrome Checker'), findsOneWidget);
    expect(find.text('Palindrome'), findsOneWidget);

    // Tap the 'Next' button.
    await tester.tap(find.text('Next'));
    await tester.pumpAndSettle();

    // Verify that we navigate to the SecondScreen with the correct name.
    expect(find.text('Welcome John Doe'), findsOneWidget);
  });
}
