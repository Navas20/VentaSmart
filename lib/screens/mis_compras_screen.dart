import 'package:flutter/material.dart';
import '../database/app_database.dart';
import '../models/venta.dart';
import '../models/producto.dart';
import '../models/cliente.dart';

class MisComprasScreen extends StatefulWidget {
  final AppDatabase database;

  const MisComprasScreen({super.key, required this.database});

  @override
  State<MisComprasScreen> createState() => _MisComprasScreenState();
}

class _MisComprasScreenState extends State<MisComprasScreen> {
  List<Venta> _ventas = [];
  List<Producto> _productos = [];
  List<Cliente> _clientes = [];

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    _ventas = await widget.database.ventasDao.findAllVentas();
    _productos = await widget.database.productoDao.findAllProductos();
    _clientes = await widget.database.clienteDao.findAllClientes();

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff7f4fa),
      appBar: AppBar(
        title: const Text("Mis Compras"),
        backgroundColor: const Color(0xff5A0E60),
      ),
      body: _ventas.isEmpty
          ? const Center(
              child: Text(
                "No tienes compras registradas",
                style: TextStyle(color: Color(0xff5A0E60), fontSize: 18),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(14),
              itemCount: _ventas.length,
              itemBuilder: (context, index) {
                final venta = _ventas[index];
                final producto =
                    _productos.firstWhere((p) => p.id == venta.idProducto);
                final cliente =
                    _clientes.firstWhere((c) => c.id == venta.idCliente);

                return Card(
                  elevation: 4,
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: ListTile(
                    leading: const CircleAvatar(
                      backgroundColor: Color(0xff5A0E60),
                      child: Icon(Icons.shopping_cart, color: Colors.white),
                    ),
                    title: Text(
                      "${producto.nombre} x${venta.cantidad}",
                      style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff5A0E60),
                      ),
                    ),
                    subtitle: Text(
                      "Cliente: ${cliente.nombre}\nTotal: \$${venta.total.toStringAsFixed(0)}",
                      style: const TextStyle(height: 1.4),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
