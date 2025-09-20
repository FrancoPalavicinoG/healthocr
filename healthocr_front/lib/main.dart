import 'package:flutter/material.dart';
import 'screens/exam_list_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HealthOCR Front',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const ExamListScreen(), // Pantalla inicial
    );
  }
}