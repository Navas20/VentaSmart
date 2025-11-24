import 'package:flutter/material.dart';

class ConfiguracionScreen extends StatelessWidget {
  const ConfiguracionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Configuración"),
        backgroundColor: const Color(0xff5A0E60),
      ),
      body: const Center(
        child: Text(
          "Opciones de configuración",
          style: TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}
