import 'package:flutter/material.dart';
import '../database/app_database.dart';
import '../models/usuario.dart';

// PANTALLAS DESTINO
import 'mis_compras_screen.dart';
import 'metodos_pago_screen.dart';
import 'configuracion_screen.dart';
import 'privacidad_screen.dart';
import 'login_screen.dart';

class ProfileScreen extends StatelessWidget {
  final AppDatabase database;
  final Usuario usuario;

  const ProfileScreen({
    super.key,
    required this.database,
    required this.usuario,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff7f4fa),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const SizedBox(height: 20),

            // --- Card principal del perfil ---
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color(0xff5A0E60),
                borderRadius: BorderRadius.circular(20),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 8,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Row(
                children: [
                  const CircleAvatar(
                    radius: 40,
                    backgroundColor: Colors.white,
                    child:
                        Icon(Icons.person, size: 45, color: Color(0xff5A0E60)),
                  ),
                  const SizedBox(width: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        usuario.nombre,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        usuario.correo,
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),

            // --- Opciones ---
            _buildOption(
              icon: Icons.shopping_bag,
              text: 'Mis compras',
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => MisComprasScreen(database: database),
                ),
              ),
            ),

            _buildOption(
              icon: Icons.credit_card,
              text: 'Métodos de pago',
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => MetodosPagoScreen(),
                ),
              ),
            ),

            _buildOption(
              icon: Icons.settings,
              text: 'Configuración',
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => ConfiguracionScreen(),
                ),
              ),
            ),

            _buildOption(
              icon: Icons.privacy_tip,
              text: 'Privacidad',
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => PrivacidadScreen(),
                ),
              ),
            ),

            const SizedBox(height: 30),

            // --- Botón cerrar sesión ---
            SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (_) => LoginScreen(database: database),
                      ),
                      (route) => false,
                    );
                  },
                  icon: const Icon(Icons.logout, color: Colors.white),
                  label: const Text(
                    'Cerrar Sesión',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xffFF6A3D),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                )),
          ],
        ),
      ),
    );
  }

  // --- Widget de opción de perfil ---
  Widget _buildOption({
    required IconData icon,
    required String text,
    required VoidCallback onTap,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 6,
            offset: Offset(0, 3),
          )
        ],
      ),
      child: ListTile(
        onTap: onTap,
        leading: Icon(icon, color: Color(0xff5A0E60), size: 28),
        title: Text(
          text,
          style: const TextStyle(
            color: Color(0xff5A0E60),
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        trailing:
            const Icon(Icons.arrow_forward_ios, size: 18, color: Colors.grey),
      ),
    );
  }
}
