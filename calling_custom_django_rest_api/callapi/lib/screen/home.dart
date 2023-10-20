import 'dart:convert';

import 'package:callapi/models/user.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<User> futureUser;

  @override
  void initState()  {
    super.initState();
    futureUser = fetchUser();
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: const Text('Fetching data from my API'),
      ),
      body: Center(
        child: FutureBuilder<User>(
          
          future: futureUser,
          builder: (context, snapshot) {
            if(snapshot.hasData) {
              return Text(snapshot.data!.name);
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }

            return const CircularProgressIndicator();
          },
        ),
      ),
      
    );
  }
}

Future<User> fetchUser() async {
  const uri = 'http://127.0.0.1:8000/passengers/4/';
  final response = await http.get(Uri.parse(uri));

  if (response.statusCode == 200) {
    // if the response in a 200 OK4
    return User.fromJson(jsonDecode(response.body));
  }
  else {
    throw Exception('Failed to load users');
  }
}