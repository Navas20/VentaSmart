import 'package:flutter/material.dart';
import '../database/app_database.dart';
import '../models/cliente.dart';
import '../models/producto.dart';
import '../models/venta.dart';

class SalesScreen extends StatefulWidget {
  final AppDatabase database;

  const SalesScreen({super.key, required this.database});

  @override
  State<SalesScreen> createState() => _SalesScreenState();
}

class _SalesScreenState extends State<SalesScreen> {
  List<Cliente> _clients = [];
  List<Producto> _products = [];
  List<Venta> _sales = [];

  Cliente? _selectedClient;
  Producto? _selectedProduct;
  int _quantity = 1;

  Venta? _editingSale; // << NUEVO

  @override
  void initState() {
    super.initState();
    _loadAllData();
  }

  Future<void> _loadAllData() async {
    _clients = await widget.database.clienteDao.findAllClientes();
    _products = await widget.database.productoDao.findAllProductos();
    _sales = await widget.database.ventasDao.findAllVentas();
    setState(() {});
  }

  // =====================================================
  //                 GUARDAR / EDITAR VENTA
  // =====================================================
  Future<void> _saveSale() async {
    if (_selectedClient == null || _selectedProduct == null) return;

    final total = _selectedProduct!.precio * _quantity;

    if (_editingSale == null) {
      // INSERTAR
      final newSale = Venta(
        id: null,
        idCliente: _selectedClient!.id!,
        idProducto: _selectedProduct!.id!,
        cantidad: _quantity,
        total: total,
      );

      await widget.database.ventasDao.insertVenta(newSale);
    } else {
      // ACTUALIZAR
      final updatedSale = Venta(
        id: _editingSale!.id,
        idCliente: _selectedClient!.id!,
        idProducto: _selectedProduct!.id!,
        cantidad: _quantity,
        total: total,
      );

      await widget.database.ventasDao.updateVenta(updatedSale);
    }

    Navigator.pop(context);
    await _loadAllData();
  }

  // =====================================================
  //                   ELIMINAR VENTA
  // =====================================================
  Future<void> _deleteSale(int id) async {
    final sale = await widget.database.ventasDao.findVentaById(id);
    if (sale == null) return;

    await widget.database.ventasDao.deleteVenta(sale);
    _loadAllData();
  }

  // =====================================================
  //                   MODAL DE FORMULARIO
  // =====================================================
  void _openSaleDialog({Venta? sale}) {
    if (_clients.isEmpty || _products.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content:
              Text("Debes registrar clientes y productos antes de vender."),
        ),
      );
      return;
    }

    if (sale == null) {
      // NUEVA VENTA
      _editingSale = null;
      _selectedClient = _clients.first;
      _selectedProduct = _products.first;
      _quantity = 1;
    } else {
      // EDITAR
      _editingSale = sale;
      _selectedClient = _clients.firstWhere((c) => c.id == sale.idCliente);
      _selectedProduct = _products.firstWhere((p) => p.id == sale.idProducto);
      _quantity = sale.cantidad;
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
          bottom: MediaQuery.of(ctx).viewInsets.bottom + 18,
          left: 18,
          right: 18,
          top: 20,
        ),
        child: StatefulBuilder(
          builder: (context, setStateModal) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _editingSale == null ? "Registrar Venta" : "Editar Venta",
                  style: const TextStyle(
                    color: Color(0xff5A0E60),
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),

                // PRODUCTO
                _buildDropdown<Producto>(
                  label: "Producto",
                  value: _selectedProduct,
                  items: _products,
                  display: (p) => "${p.nombre} - \$${p.precio}",
                  onChanged: (v) => setStateModal(() => _selectedProduct = v),
                ),
                const SizedBox(height: 14),

                // CLIENTE
                _buildDropdown<Cliente>(
                  label: "Cliente",
                  value: _selectedClient,
                  items: _clients,
                  display: (c) => c.nombre,
                  onChanged: (v) => setStateModal(() => _selectedClient = v),
                ),
                const SizedBox(height: 14),

                // CANTIDAD
                Row(
                  children: [
                    const Text(
                      "Cantidad:",
                      style: TextStyle(
                        color: Color(0xff5A0E60),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Expanded(
                      child: Slider(
                        value: _quantity.toDouble(),
                        min: 1,
                        max: 20,
                        divisions: 19,
                        activeColor: const Color(0xffFF6A3D),
                        label: "$_quantity",
                        onChanged: (v) {
                          setStateModal(() => _quantity = v.toInt());
                        },
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                // BOTONES
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: _saveSale,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xffFF6A3D),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 14),
                        ),
                        child: Text(
                          _editingSale == null ? "Guardar" : "Actualizar",
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () => Navigator.pop(context),
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(
                            color: Color(0xff5A0E60),
                            width: 1.4,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 14),
                        ),
                        child: const Text(
                          "Cancelar",
                          style: TextStyle(
                            color: Color(0xff5A0E60),
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            );
          },
        ),
      ),
    );
  }

  // =====================================================
  //                 DROPDOWN REUSABLE
  // =====================================================
  Widget _buildDropdown<T>({
    required String label,
    required T? value,
    required List<T> items,
    required String Function(T) display,
    required Function(T?) onChanged,
  }) {
    return DropdownButtonFormField<T>(
      value: value,
      items: items
          .map((e) => DropdownMenuItem(
                value: e,
                child: Text(display(e)),
              ))
          .toList(),
      onChanged: onChanged,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Color(0xff5A0E60)),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Color(0xff5A0E60),
            width: 2,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }

  // =====================================================
  //                       UI
  // =====================================================
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff7f4fa),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _openSaleDialog(),
        backgroundColor: const Color(0xffFF6A3D),
        icon: const Icon(Icons.add_shopping_cart, color: Colors.white),
        label: const Text("Venta", style: TextStyle(color: Colors.white)),
      ),
      body: _sales.isEmpty
          ? const Center(
              child: Text(
                "No hay ventas registradas.",
                style: TextStyle(
                  color: Color(0xff5A0E60),
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: _sales.length,
              itemBuilder: (context, index) {
                final sale = _sales[index];

                final product =
                    _products.firstWhere((p) => p.id == sale.idProducto);
                final client =
                    _clients.firstWhere((c) => c.id == sale.idCliente);

                return Card(
                  elevation: 4,
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: ListTile(
                    leading: const CircleAvatar(
                      backgroundColor: Color(0xff5A0E60),
                      child: Icon(Icons.receipt, color: Colors.white),
                    ),
                    title: Text(
                      "${product.nombre} x${sale.cantidad} — \$${sale.total.toStringAsFixed(0)}",
                      style: const TextStyle(
                        color: Color(0xff5A0E60),
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                      client.nombre,
                      style: const TextStyle(height: 1.3),
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon:
                              const Icon(Icons.edit, color: Color(0xff5A0E60)),
                          onPressed: () => _openSaleDialog(sale: sale),
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () => _deleteSale(sale.id!),
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
