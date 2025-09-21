import 'package:flutter/material.dart';

class CameraScreen extends StatelessWidget {
  const CameraScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Camara'),
      ),
      body: const Center(
        child: Text(
          'Aqui va la camara xd 🙃',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}