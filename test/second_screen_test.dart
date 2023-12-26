import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:projecttest/second_screen.dart';

void main() {
  testWidgets('SecondScreen UI Test', (WidgetTester tester) async {
    // Build our app and trigger a frame with the SecondScreen widget.
    await tester.pumpWidget(MaterialApp(
      home: SecondScreen(name: 'John Doe'),
    ));

    // Verify that the initial UI is correct.
    expect(find.text('Second Screen'), findsOneWidget);
    expect(find.text('Welcome'), findsOneWidget);
    expect(find.text('John Doe'), findsOneWidget);
    expect(find.text('Selected User Name: '), findsOneWidget);
    expect(find.byType(ElevatedButton), findsOneWidget);

    // Tap the 'Choose a User' button.
    await tester.tap(find.text('Choose a User'));
    await tester.pumpAndSettle();

    // Verify that we navigate to the ThirdScreen.
    expect(find.text('Third Screen'), findsOneWidget);

    // Navigate back from ThirdScreen with a selected user name.
    Navigator.pop(tester.element(find.text('Third Screen')), 'SelectedUser');
    await tester.pumpAndSettle();

    // Verify that the selected user name is displayed.
    expect(find.text('Selected User Name: SelectedUser'), findsOneWidget);
  });
}
