import 'package:flutter/material.dart';
import '../../database/app_database.dart';
import '../../models/usuario.dart';
import 'home_shell.dart';
import 'register_screen.dart';

class LoginScreen extends StatefulWidget {
  final AppDatabase database;

  const LoginScreen({super.key, required this.database});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailCtrl = TextEditingController();
  final _passwordCtrl = TextEditingController();
  String? errorMsg;

  Future<void> _login() async {
    final email = _emailCtrl.text.trim();
    final pass = _passwordCtrl.text.trim();

    final user = await widget.database.usuarioDao.findByEmail(email);

    if (user == null || user.password != pass) {
      setState(() => errorMsg = "Usuario o contraseña incorrectos");
      return;
    }

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => HomeShell(
          database: widget.database,
          usuario: user,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FA),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 60),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),

            // --- Título VentaSmart ---
            const Text(
              "VentaSmart",
              style: TextStyle(
                fontSize: 34,
                fontWeight: FontWeight.bold,
                color: Color(0xFF4C1C57),
              ),
            ),
            const SizedBox(height: 6),

            const Text(
              "Bienvenido, inicia sesión para continuar",
              style: TextStyle(
                color: Colors.black54,
                fontSize: 15,
              ),
            ),

            const SizedBox(height: 40),

            // --- Input Email ---
            const Text(
              "Correo electrónico",
              style: TextStyle(
                color: Color(0xFF4C1C57),
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _emailCtrl,
              decoration: InputDecoration(
                hintText: "example@email.com",
                filled: true,
                fillColor: Colors.white,
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: const BorderSide(color: Color(0xFF4C1C57)),
                ),
              ),
            ),
            const SizedBox(height: 20),

            // --- Input Password ---
            const Text(
              "Contraseña",
              style: TextStyle(
                color: Color(0xFF4C1C57),
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _passwordCtrl,
              obscureText: true,
              decoration: InputDecoration(
                hintText: "••••••••",
                filled: true,
                fillColor: Colors.white,
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: const BorderSide(color: Color(0xFF4C1C57)),
                ),
              ),
            ),

            if (errorMsg != null) ...[
              const SizedBox(height: 12),
              Text(
                errorMsg!,
                style: const TextStyle(color: Colors.red, fontSize: 14),
              ),
            ],

            const SizedBox(height: 30),

            // --- Botón Login ---
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _login,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF6A4CFF),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                child: const Text(
                  "Iniciar sesión",
                  style: TextStyle(fontSize: 17, color: Colors.white),
                ),
              ),
            ),

            const SizedBox(height: 35),

            // --- OR Divider ---
            Row(
              children: const [
                Expanded(child: Divider()),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Text("o ingresa con",
                      style: TextStyle(color: Colors.black45)),
                ),
                Expanded(child: Divider()),
              ],
            ),

            const SizedBox(height: 22),

            // --- Botones sociales ---
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _socialButton(Icons.facebook, Colors.blue),
                _socialButton(Icons.g_mobiledata, Colors.red),
                _socialButton(Icons.apple, Colors.black),
              ],
            ),

            const SizedBox(height: 30),

            // --- Crear cuenta ---
            Center(
              child: TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => RegisterScreen(database: widget.database),
                    ),
                  );
                },
                child: const Text(
                  "Crear cuenta",
                  style: TextStyle(color: Color(0xFF4C1C57), fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _socialButton(IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black12),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Icon(icon, size: 28, color: color),
    );
  }
}
