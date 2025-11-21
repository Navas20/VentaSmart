import 'package:flutter/material.dart';
import 'database/app_database.dart';
import 'screens/home_shell.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Inicializar la Base de Datos
  final database = await $FloorAppDatabase.databaseBuilder('ventas.db').build();

  runApp(VentaSmartApp(database: database));
}

class VentaSmartApp extends StatelessWidget {
  final AppDatabase database;

  VentaSmartApp({super.key, required this.database});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'VentaSmart',
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.teal,
      ),
      home: HomeShell(database: database),
    );
  }
}
