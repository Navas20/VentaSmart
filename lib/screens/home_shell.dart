import 'package:flutter/material.dart';
import '../database/app_database.dart';
import '../models/usuario.dart';

// Import screens
import 'products_screen.dart';
import 'clients_screen.dart';
import 'sales_screen.dart';
import 'profile_screen.dart';

class HomeShell extends StatefulWidget {
  final AppDatabase database;
  final Usuario usuario; // <-- ahora recibe el usuario logeado

  const HomeShell({
    super.key,
    required this.database,
    required this.usuario,
  });

  @override
  State<HomeShell> createState() => _HomeShellState();
}

class _HomeShellState extends State<HomeShell> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    // Pages del menú inferior
    final List<Widget> _pages = [
      ProductsScreen(database: widget.database),
      ClientsScreen(database: widget.database),
      SalesScreen(database: widget.database),
      ProfileScreen(
        database: widget.database,
        usuario: widget.usuario,
      ),
    ];

    return Scaffold(
      backgroundColor: const Color(0xfff7f4fa),
      appBar: AppBar(
        backgroundColor: const Color(0xff5A0E60),
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'VentaSmart',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
      ),

      // Contenido dinámico
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        child: _pages[_currentIndex],
      ),

      // BOTTOM NAVIGATION
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 10,
              offset: Offset(0, -2),
            )
          ],
        ),
        child: NavigationBar(
          height: 65,
          backgroundColor: Colors.white,
          indicatorColor: const Color(0xffFF6A3D),
          selectedIndex: _currentIndex,
          onDestinationSelected: (index) {
            setState(() => _currentIndex = index);
          },
          labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
          destinations: const [
            NavigationDestination(
              icon: Icon(Icons.inventory_2_outlined, color: Color(0xff5A0E60)),
              selectedIcon: Icon(Icons.inventory_2, color: Colors.white),
              label: 'Productos',
            ),
            NavigationDestination(
              icon: Icon(Icons.people_alt_outlined, color: Color(0xff5A0E60)),
              selectedIcon: Icon(Icons.people_alt, color: Colors.white),
              label: 'Clientes',
            ),
            NavigationDestination(
              icon: Icon(Icons.receipt_long_outlined, color: Color(0xff5A0E60)),
              selectedIcon: Icon(Icons.receipt_long, color: Colors.white),
              label: 'Ventas',
            ),
            NavigationDestination(
              icon: Icon(Icons.person_outline, color: Color(0xff5A0E60)),
              selectedIcon: Icon(Icons.person, color: Colors.white),
              label: 'Perfil',
            ),
          ],
        ),
      ),
    );
  }
}
