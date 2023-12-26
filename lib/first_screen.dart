import 'package:flutter/material.dart';
import 'package:projecttest/second_screen.dart';

class FirstScreen extends StatefulWidget {
  const FirstScreen({Key? key}) : super(key: key);

  @override
  _FirstScreenState createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController sentenceController = TextEditingController();
  final FocusNode sentenceFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/img/background.png'),
                fit: BoxFit.cover,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 116,
                    height: 116,
                    margin: EdgeInsets.only(
                      bottom: 56.0,
                    ),
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/img/profile.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: 39.88,
                      padding: EdgeInsets.fromLTRB(16, 0, 16, 20),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Color(0xFFFFFFFF),
                            Color(0xFFFFFFFF),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(width: 0.5),
                      ),
                      child: TextField(
                        controller: nameController,
                        decoration: InputDecoration(
                          contentPadding:
                              EdgeInsets.zero, // Set contentPadding to zero
                          hintText: 'Name',
                          hintStyle: TextStyle(
                            color: Colors.grey,
                          ),
                          border: InputBorder.none,
                          alignLabelWithHint: true,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: 39.88,
                      margin: EdgeInsets.only(top: 7.12),
                      padding: EdgeInsets.fromLTRB(16, 0, 16, 20),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Color(0xFFFFFFFF),
                            Color(0xFFFFFFFF),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(width: 0.5),
                      ),
                      child: Align(
                        alignment: Alignment.center,
                        child: TextField(
                          controller: sentenceController,
                          focusNode: sentenceFocusNode,
                          onTap: () {
                            sentenceFocusNode.requestFocus();
                          },
                          decoration: InputDecoration(
                            hintText: 'Sentence',
                            hintStyle: TextStyle(
                              color: Colors.grey,
                            ),
                            border: InputBorder.none,
                            contentPadding:
                                EdgeInsets.zero, // Set contentPadding to zero
                            alignLabelWithHint: true,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 40),
                  ElevatedButton(
                    onPressed: () {
                      bool isPalindrome =
                          checkPalindrome(sentenceController.text);
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('Palindrome Checker'),
                            content: Text(
                                isPalindrome ? 'Palindrome' : 'Not Palindrome'),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text('OK'),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Color(0xFF2B637B),
                      minimumSize: Size(
                        MediaQuery.of(context).size.width - 32,
                        41,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      'Check',
                      style: TextStyle(
                        color: Color(0xFFFFFFFF),
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              SecondScreen(name: nameController.text),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Color(0xFF2B637B),
                      minimumSize: Size(
                        MediaQuery.of(context).size.width - 32,
                        41,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      'Next',
                      style: TextStyle(
                        color: Color(0xFFFFFFFF),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  bool checkPalindrome(String text) {
    String cleanText = text.replaceAll(' ', '').toLowerCase();
    String reversedText = cleanText.split('').reversed.join('');
    return cleanText == reversedText;
  }

  @override
  void dispose() {
    sentenceFocusNode.dispose();
    super.dispose();
  }
}
