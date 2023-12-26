import 'package:flutter/material.dart';
import 'first_screen.dart';
import 'second_screen.dart';
import 'third_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Your App Title',
      initialRoute: '/',
      routes: {
        '/': (context) => FirstScreen(),
        '/second_screen': (context) {
          var nameController =
              TextEditingController(); // Initialize the controller
          return SecondScreen(name: nameController.text);
        },
        '/third_screen': (context) => ThirdScreen(),
      },
    );
  }
}
