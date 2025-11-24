import 'package:flutter/material.dart';

class MetodosPagoScreen extends StatelessWidget {
  const MetodosPagoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Métodos de Pago"),
        backgroundColor: const Color(0xff5A0E60),
      ),
      body: const Center(
        child: Text(
          "Aquí podrás gestionar tus métodos de pago.",
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
