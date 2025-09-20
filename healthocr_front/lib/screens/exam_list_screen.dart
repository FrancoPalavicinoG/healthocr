import 'package:flutter/material.dart';

class ExamListScreen extends StatelessWidget {
  const ExamListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Exam List'),
      ),
      body: const Center(
        child: Text('Hello World'),
      ),
    );
  }
}