import 'package:flutter/material.dart';
import 'database/app_database.dart';
import 'screens/login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final database =
      await $FloorAppDatabase.databaseBuilder('app_database.db').build();

  runApp(MyApp(database: database));
}

class MyApp extends StatelessWidget {
  final AppDatabase database;

  const MyApp({super.key, required this.database});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Ventas App',

      // 🔥 ESTA ES LA PARTE QUE FALTABA
      home: LoginScreen(database: database),

      theme: ThemeData(
        brightness: Brightness.light,
        scaffoldBackgroundColor: const Color(0xFFF8F5FA),
        colorScheme: const ColorScheme.light(
          primary: Color(0xFF4C1C57),
          secondary: Color(0xFFFF6F3C),
          tertiary: Color(0xFFFFD66B),
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF4C1C57),
          foregroundColor: Colors.white,
          elevation: 0,
        ),
      ),
    );
  }
}
