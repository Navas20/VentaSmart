import 'package:flutter/material.dart';
import 'screens/home_shell.dart';

void main() {
  runApp(const VentaSmartApp());
}

class VentaSmartApp extends StatelessWidget {
  const VentaSmartApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'VentaSmart',
      theme: ThemeData(
        colorSchemeSeed: Colors.teal,
        useMaterial3: true,
      ),
      home: const HomeShell(),
    );
  }
}
