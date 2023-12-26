import 'package:flutter/material.dart';
import 'package:projecttest/first_screen.dart';
import 'third_screen.dart';

class SecondScreen extends StatefulWidget {
  final String name;

  // Define the named parameter in the constructor
  SecondScreen({required this.name});

  @override
  _SecondScreenState createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
  String selectedUserName = '';

  get name => null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: EdgeInsets.only(right: 20.0),
          child: Center(
            child: Text(
              'Second Screen',
              style: TextStyle(
                color: Color.fromRGBO(4, 2, 29, 1),
                fontFamily: 'Poppins',
                fontSize: 18,
                fontWeight: FontWeight.w600,
                letterSpacing: 0,
              ),
            ),
          ),
        ),
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Image.asset('assets/img/arrow.png'),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    FirstScreen(), // Pass the default value for 'name'
              ),
            );
          },
        ),
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Welcome',
                      style: TextStyle(
                        color: Color.fromRGBO(4, 2, 29, 1),
                        fontFamily: 'Poppins',
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        letterSpacing: 0,
                      ),
                    ),
                    SizedBox(height: 16),
                    Text(
                      '${widget.name}',
                      style: TextStyle(
                        color: Color.fromRGBO(4, 2, 29, 1),
                        fontFamily: 'Poppins',
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 0,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '$selectedUserName',
                    style: TextStyle(
                      color: Color.fromRGBO(4, 2, 29, 1),
                      fontFamily: 'Poppins',
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 0,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 20.0),
              child: ElevatedButton(
                onPressed: () async {
                  final result = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ThirdScreen(),
                    ),
                  );

                  if (result != null && result is String) {
                    setState(() {
                      selectedUserName = result;
                    });
                  }
                },
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.all(0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  primary: Color.fromRGBO(43, 99, 123, 1),
                ),
                child: Container(
                  height: 41,
                  padding: EdgeInsets.symmetric(
                    vertical: 12.35,
                    horizontal: 85.08,
                  ),
                  child: Center(
                    child: Text(
                      'Choose a User',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
