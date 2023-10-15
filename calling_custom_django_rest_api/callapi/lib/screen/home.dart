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
  List<User> users = [];

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: const Text('Rest API call'),
      ),
      body: ListView.builder(
        itemCount: users.length,
        itemBuilder: (context, index) {
        final user = users[index];
        final email = user.name;
        final name = user.email;
        return ListTile(
          title: Text(name),
          subtitle: Text(email),
        );
      },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: fetchUsers,
        ),
    );
  }


void fetchUsers()  async {
  print('fetchUser called');
  const url = 'http://127.0.0.1:8000/passengers/';
  final uri = Uri.parse(url);
  final response = await http.get(uri);
  final body = response.body;
  final json = jsonDecode(body);
  final results = json['results'] as List<dynamic>;
  final transformed = results.map((e) {
    return User(
        name: e['name'],
        email: e['email'],
        location: e['location'],
    );
  }).toList();
  setState(() {
    users = transformed;
  });
  print('fetchUser completed');

}
}