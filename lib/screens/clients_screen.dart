import 'package:flutter/material.dart';
import '../database/app_database.dart';
import '../models/cliente.dart';

class ClientsScreen extends StatefulWidget {
  final AppDatabase database;

  const ClientsScreen({super.key, required this.database});

  @override
  State<ClientsScreen> createState() => _ClientsScreenState();
}

class _ClientsScreenState extends State<ClientsScreen> {
  List<Cliente> _clients = [];

  final _nameCtrl = TextEditingController();
  final _phoneCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();

  Cliente? _editingClient; // << NUEVO

  @override
  void initState() {
    super.initState();
    _loadClients();
  }

  void _loadClients() async {
    final data = await widget.database.clienteDao.findAllClientes();
    setState(() => _clients = data);
  }

  // ============================================================
  //              AGREGAR O ACTUALIZAR CLIENTE
  // ============================================================
  void _saveClient() async {
    final name = _nameCtrl.text.trim();
    final phone = _phoneCtrl.text.trim();
    final email = _emailCtrl.text.trim();

    if (name.isEmpty || phone.isEmpty) return;

    if (_editingClient == null) {
      // INSERTAR
      final newClient = Cliente(
        id: null,
        nombre: name,
        correo: email,
        telefono: phone,
      );
      await widget.database.clienteDao.insertCliente(newClient);
    } else {
      // ACTUALIZAR
      final updatedClient = Cliente(
        id: _editingClient!.id,
        nombre: name,
        correo: email,
        telefono: phone,
      );
      await widget.database.clienteDao.updateCliente(updatedClient);
    }

    Navigator.pop(context);
    _clearForm();
    _loadClients();
  }

  void _deleteClient(int id) async {
    final cliente = await widget.database.clienteDao.findClienteById(id);
    if (cliente == null) return;
    await widget.database.clienteDao.deleteCliente(cliente);
    _loadClients();
  }

  // ============================================================
  //                     FORMULARIO
  // ============================================================
  void _openForm({Cliente? client}) {
    if (client == null) {
      _editingClient = null;
      _nameCtrl.clear();
      _phoneCtrl.clear();
      _emailCtrl.clear();
    } else {
      _editingClient = client;
      _nameCtrl.text = client.nombre;
      _phoneCtrl.text = client.telefono;
      _emailCtrl.text = client.correo;
    }

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(ctx).viewInsets.bottom + 16,
          left: 18,
          right: 18,
          top: 22,
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                _editingClient == null ? 'Nuevo Cliente' : 'Editar Cliente',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xff5A0E60),
                ),
              ),
              const SizedBox(height: 14),
              _buildInput("Nombre completo", _nameCtrl),
              const SizedBox(height: 14),
              _buildInput("Teléfono", _phoneCtrl,
                  keyboard: TextInputType.phone),
              const SizedBox(height: 14),
              _buildInput("Correo electrónico", _emailCtrl),
              const SizedBox(height: 22),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: _saveClient,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xffFF6A3D),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                      child: Text(
                        _editingClient == null ? 'Guardar' : 'Actualizar',
                        style:
                            const TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Navigator.pop(context),
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(
                            color: Color(0xff5A0E60), width: 1.4),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                      child: const Text(
                        'Cancelar',
                        style:
                            TextStyle(color: Color(0xff5A0E60), fontSize: 16),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInput(String label, TextEditingController ctrl,
      {TextInputType keyboard = TextInputType.text}) {
    return TextField(
      controller: ctrl,
      keyboardType: keyboard,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Color(0xff5A0E60)),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Color(0xff5A0E60), width: 2),
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }

  void _clearForm() {
    _nameCtrl.clear();
    _phoneCtrl.clear();
    _emailCtrl.clear();
    _editingClient = null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff7f4fa),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _openForm(),
        backgroundColor: const Color(0xffFF6A3D),
        icon: const Icon(Icons.add, color: Colors.white),
        label: const Text('Cliente', style: TextStyle(color: Colors.white)),
      ),
      body: _clients.isEmpty
          ? const Center(
              child: Text(
                'No hay clientes registrados',
                style: TextStyle(
                  color: Color(0xff5A0E60),
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: _clients.length,
              itemBuilder: (context, index) {
                final c = _clients[index];
                return Card(
                  elevation: 4,
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: ListTile(
                    leading: const CircleAvatar(
                      backgroundColor: Color(0xff5A0E60),
                      child: Icon(Icons.person, color: Colors.white),
                    ),
                    title: Text(
                      c.nombre,
                      style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff5A0E60),
                      ),
                    ),
                    subtitle: Text(
                      "${c.correo}\n${c.telefono}",
                      style: const TextStyle(height: 1.4),
                    ),
                    isThreeLine: true,
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon:
                              const Icon(Icons.edit, color: Color(0xff5A0E60)),
                          onPressed: () => _openForm(client: c),
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () => _deleteClient(c.id!),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
