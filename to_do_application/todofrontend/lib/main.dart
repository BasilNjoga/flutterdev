import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:todofrontend/create.dart';
import 'package:todofrontend/note.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});



  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Client client = http.Client();
  List<Note> notes = [];

  @override
  void initState() {
    _retrieveNotes();
    super.initState();
  }
  
  _retrieveNotes() async {
    notes = [];

    List response = json.decode((await client.get(uri)).body);// come with the correct url here
    response.forEach((element) {
      notes.add(Note.fromMap(element));
    });

    setState(() {
      
    });
  }

  void _deleteNote(int id) {
    client.delete(deleteUrl(id));
    _retrieveNotes();
  }
  

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: RefreshIndicator(
        onRefresh: () async { 
          _retrieveNotes();
         },
        child: ListView.builder(
          itemCount: notes.length,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              title: Text(notes[index].note),
              onTap: (){

              },
              trailing: IconButton(
                icon: Icon(Icons.delete),
                onPressed: () => _deleteNote(notes[index].id),
                ),
            );
          }
          ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => MaterialPageRoute(builder: (context) => CreatePage()),
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
