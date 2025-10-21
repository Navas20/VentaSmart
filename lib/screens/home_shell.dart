import 'package:flutter/material.dart';

// Importaciones de pantallas
import 'products_screen.dart'; // 🟩 Productos
import 'clients_screen.dart'; // 🟦 Clientes
import 'sales_screen.dart'; // 🟨 Ventas
import 'profile_screen.dart'; // ⚙️ Perfil

class HomeShell extends StatefulWidget {
  const HomeShell({super.key});

  @override
  State<HomeShell> createState() => _HomeShellState();
}

class _HomeShellState extends State<HomeShell> {
  // Índice actual del menú inferior
  int _currentIndex = 0;

  // Lista de pantallas reales en orden de navegación
  final List<Widget> _pages = const [
    ProductsScreen(),
    ClientsScreen(),
    SalesScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('VentaSmart'),
        centerTitle: true,
      ),

      // Cuerpo dinámico
      body: SafeArea(
        child: _pages[_currentIndex],
      ),

      // Menú inferior (Bottom Navigation Bar)
      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentIndex,
        onDestinationSelected: (int index) {
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
