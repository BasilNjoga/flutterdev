import 'package:flutter/material.dart';
import 'package:transportclone/fluttermap.dart';


void main() {
  runApp ( const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
        title: 'Live Transport App',
        theme: ThemeData(
            primarySwatch: Colors.blue,
            ),
        home: const MapView(),
      );
  }
}


// ...

