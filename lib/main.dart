import 'package:flutter/material.dart';
import 'package:tarea_6/Home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Simple Bottom Navigation',
      home: Home(),
    );
  }
}
