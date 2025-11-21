import 'package:flutter/material.dart';
import '../database/app_database.dart';

// Importaciones de pantallas
import 'products_screen.dart';
import 'clients_screen.dart';
import 'sales_screen.dart';
import 'profile_screen.dart';

class HomeShell extends StatefulWidget {
  final AppDatabase database;

  const HomeShell({super.key, required this.database});

  @override
  State<HomeShell> createState() => _HomeShellState();
}

class _HomeShellState extends State<HomeShell> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    // Lista de pantallas que reciben la base de datos
    final List<Widget> _pages = [
      ProductsScreen(database: widget.database),
      ClientsScreen(database: widget.database),
      SalesScreen(database: widget.database),
      const ProfileScreen(),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('VentaSmart'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: _pages[_currentIndex],
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentIndex,
        onDestinationSelected: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.inventory_2_outlined),
            selectedIcon: Icon(Icons.inventory_2),
            label: 'Productos',
          ),
          NavigationDestination(
            icon: Icon(Icons.people_alt_outlined),
            selectedIcon: Icon(Icons.people_alt),
            label: 'Clientes',
          ),
          NavigationDestination(
            icon: Icon(Icons.receipt_long_outlined),
            selectedIcon: Icon(Icons.receipt_long),
            label: 'Ventas',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline),
            selectedIcon: Icon(Icons.person),
            label: 'Perfil',
          ),
        ],
      ),
    );
  }
}
