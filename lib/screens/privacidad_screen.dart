import 'package:flutter/material.dart';

class PrivacidadScreen extends StatelessWidget {
  const PrivacidadScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Privacidad"),
        backgroundColor: const Color(0xff5A0E60),
      ),
      body: const Center(
        child: Text(
          "Políticas de privacidad",
          style: TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}
