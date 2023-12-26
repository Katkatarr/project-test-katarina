import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'second_screen.dart';

class ThirdScreen extends StatefulWidget {
  const ThirdScreen({super.key});

  get _refreshDataCompleter => null;

  get refreshDataCompleter => null;

  set users(List<User> users) {}

  @override
  _ThirdScreenState createState() => _ThirdScreenState();
}

class _ThirdScreenState extends State<ThirdScreen> {
  List<User> users = [];
  int currentPage = 1;
  int perPage = 10;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    if (isLoading) {
      return;
    }

    setState(() {
      isLoading = true;
    });

    try {
      final response = await http.get(Uri.parse(
          'https://reqres.in/api/users?page=$currentPage&per_page=$perPage'));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        List<User> userList =
            (data['data'] as List).map((item) => User.fromJson(item)).toList();

        setState(() {
          users.addAll(userList);
          currentPage++;
          isLoading = false;
        });
      } else {
        // Handle error
        print('Failed to load data. Status code: ${response.statusCode}');
        setState(() {
          isLoading = false;
        });
      }
    } catch (e) {
      // Handle other exceptions
      print('Error fetching data: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> _refreshData() async {
    currentPage = 1;
    users.clear();
    await fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding:
              EdgeInsets.only(right: 20.0), // Set left padding to 16 pixels
          child: Center(
            child: Text(
              'Third Screen',
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
          icon: Image.asset(
              'assets/img/arrow.png'), // Adjust the image path as needed
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => SecondScreen(
                        name: '',
                      )),
            );
          },
        ),
      ),
      body: RefreshIndicator(
        onRefresh: _refreshData,
        child: ListView.builder(
          itemCount: users.length + 1,
          itemBuilder: (context, index) {
            if (index == users.length) {
              return _buildLoadingIndicator();
            } else {
              return ListTile(
                title:
                    Text('${users[index].firstName} ${users[index].lastName}'),
                subtitle: Text('Email: ${users[index].email}'),
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(users[index].avatar),
                ),
                onTap: () {
                  _updateSelectedUserName(users[index].firstName);
                },
              );
            }
          },
        ),
      ),
    );
  }

  Widget _buildLoadingIndicator() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  void _updateSelectedUserName(String selectedUserName) {
    Navigator.pop(context, selectedUserName);
  }
}

class User {
  final String email;
  final String firstName;
  final String lastName;
  final String avatar;

  User({
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.avatar,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      email: json['email'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      avatar: json['avatar'],
    );
  }
}
