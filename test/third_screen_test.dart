import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:projecttest/third_screen.dart';

void main() {
  testWidgets('ThirdScreen UI Test', (WidgetTester tester) async {
    // Mock data for testing
    final List<User> mockUsers = [
      User(
          email: 'test1@example.com',
          firstName: 'John',
          lastName: 'Doe',
          avatar: 'url1'),
      User(
          email: 'test2@example.com',
          firstName: 'Jane',
          lastName: 'Doe',
          avatar: 'url2'),
    ];

    // Build our app and trigger a frame with the ThirdScreen widget.
    await tester.pumpWidget(MaterialApp(
      home: ThirdScreen(),
    ));

    // Verify that the initial UI is correct.
    expect(find.text('Third Screen'), findsOneWidget);
    expect(find.byType(ListTile), findsNothing);

    // Simulate fetching data
    ThirdScreen thirdScreen = tester.firstWidget(find.byType(ThirdScreen));
    thirdScreen.users = mockUsers;

    // Rebuild the widget with updated data
    await tester.pump();

    // Verify that the data is displayed correctly
    expect(find.byType(ListTile), findsNWidgets(mockUsers.length));
    expect(find.text('John Doe'), findsOneWidget);
    expect(find.text('Jane Doe'), findsOneWidget);

    // Simulate pull-to-refresh
    await tester.drag(find.byType(RefreshIndicator), const Offset(0.0, -100.0));
    await tester.pumpAndSettle();

    // Verify that the loading indicator is displayed
    expect(find.byType(CircularProgressIndicator), findsOneWidget);

    // Simulate the refresh completed
    thirdScreen.refreshDataCompleter.complete();
    await tester.pumpAndSettle();

    // Verify that the data is displayed correctly after refreshing
    expect(find.byType(ListTile), findsNWidgets(mockUsers.length));
    expect(find.text('John Doe'), findsOneWidget);
    expect(find.text('Jane Doe'), findsOneWidget);
  });
}
