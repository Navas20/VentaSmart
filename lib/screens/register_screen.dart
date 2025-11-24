import 'package:flutter/material.dart';
import '../../database/app_database.dart';
import '../../models/usuario.dart';

class RegisterScreen extends StatefulWidget {
  final AppDatabase database;

  const RegisterScreen({super.key, required this.database});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _nameCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _passCtrl = TextEditingController();

  Future<void> _register() async {
    final u = Usuario(
      nombre: _nameCtrl.text.trim(),
      correo: _emailCtrl.text.trim(),
      password: _passCtrl.text.trim(),
    );

    await widget.database.usuarioDao.insertUsuario(u);

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Crear cuenta")),
      body: Padding(
        padding: const EdgeInsets.all(26),
        child: Column(
          children: [
            TextField(
                controller: _nameCtrl,
                decoration: const InputDecoration(labelText: "Nombre")),
            TextField(
                controller: _emailCtrl,
                decoration: const InputDecoration(labelText: "Correo")),
            TextField(
                controller: _passCtrl,
                obscureText: true,
                decoration: const InputDecoration(labelText: "Contraseña")),
            const SizedBox(height: 20),
            ElevatedButton(
                onPressed: _register, child: const Text("Registrarse")),
          ],
        ),
      ),
    );
  }
}
