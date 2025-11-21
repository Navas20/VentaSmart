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

  @override
  void initState() {
    super.initState();
    _loadClients();
  }

  void _loadClients() async {
    final data = await widget.database.clienteDao.findAllClientes();
    setState(() {
      _clients = data;
    });
  }

  void _addClient() async {
    final name = _nameCtrl.text.trim();
    final phone = _phoneCtrl.text.trim();
    final email = _emailCtrl.text.trim();

    if (name.isEmpty || phone.isEmpty) return;

    final newClient = Cliente(
      id: null,
      nombre: name,
      telefono: phone,
      correo: email,
    );

    await widget.database.clienteDao.insertCliente(newClient);
    Navigator.pop(context);
    _nameCtrl.clear();
    _phoneCtrl.clear();
    _emailCtrl.clear();
    _loadClients();
  }

  void _deleteClient(int id) async {
    final cliente = await widget.database.clienteDao.findClienteById(id);

    if (cliente == null) return;

    await widget.database.clienteDao.deleteCliente(cliente);
    _loadClients();
  }

  void _openAddDialog() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (ctx) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(ctx).viewInsets.bottom + 16,
          left: 16,
          right: 16,
          top: 16,
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Nuevo Cliente',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: _nameCtrl,
                decoration: const InputDecoration(
                  labelText: 'Nombre completo',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: _phoneCtrl,
                decoration: const InputDecoration(
                  labelText: 'Teléfono',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.phone,
              ),
              const SizedBox(height: 12),
              TextField(
                controller: _emailCtrl,
                decoration: const InputDecoration(
                  labelText: 'Correo electrónico',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: _addClient,
                      icon: const Icon(Icons.save),
                      label: const Text('Guardar'),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.close),
                      label: const Text('Cancelar'),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _phoneCtrl.dispose();
    _emailCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _openAddDialog,
        icon: const Icon(Icons.add),
        label: const Text('Cliente'),
      ),
      body: _clients.isEmpty
          ? const Center(child: Text('No hay clientes registrados'))
          : ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: _clients.length,
              itemBuilder: (context, index) {
                final c = _clients[index];
                return Card(
                  margin:
                      const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
                  child: ListTile(
                    leading: const Icon(Icons.person),
                    title: Text(c.nombre),
                    subtitle: Text('${c.telefono} · ${c.correo}'),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete_outline),
                      onPressed: () => _deleteClient(c.id!),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
