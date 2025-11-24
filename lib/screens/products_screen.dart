import 'package:flutter/material.dart';
import '../database/app_database.dart';
import '../models/producto.dart';

class ProductsScreen extends StatefulWidget {
  final AppDatabase database;

  const ProductsScreen({super.key, required this.database});

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  List<Producto> _products = [];

  final _nameCtrl = TextEditingController();
  final _priceCtrl = TextEditingController();

  Producto? _editingProduct; // << NUEVO

  @override
  void initState() {
    super.initState();
    _loadProducts();
  }

  Future<void> _loadProducts() async {
    final data = await widget.database.productoDao.findAllProductos();
    setState(() => _products = data);
  }

  // ============================================================
  //             GUARDAR (AGREGAR O EDITAR)
  // ============================================================
  Future<void> _saveProduct() async {
    final name = _nameCtrl.text.trim();
    final price = double.tryParse(_priceCtrl.text.trim());

    if (name.isEmpty || price == null || price <= 0) return;

    if (_editingProduct == null) {
      // INSERTAR
      final newProduct = Producto(id: null, nombre: name, precio: price);
      await widget.database.productoDao.insertProducto(newProduct);
    } else {
      // ACTUALIZAR
      final updatedProduct = Producto(
        id: _editingProduct!.id,
        nombre: name,
        precio: price,
      );
      await widget.database.productoDao.updateProducto(updatedProduct);
    }

    Navigator.pop(context);
    _clearForm();
    _loadProducts();
  }

  Future<void> _deleteProduct(int id) async {
    final product = await widget.database.productoDao.findProductoById(id);
    if (product == null) return;

    await widget.database.productoDao.deleteProducto(product);
    _loadProducts();
  }

  // ============================================================
  //                     FORMULARIO
  // ============================================================
  void _openForm({Producto? product}) {
    if (product == null) {
      _editingProduct = null;
      _nameCtrl.clear();
      _priceCtrl.clear();
    } else {
      _editingProduct = product;
      _nameCtrl.text = product.nombre;
      _priceCtrl.text = product.precio.toString();
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
                _editingProduct == null ? 'Nuevo Producto' : 'Editar Producto',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xff5A0E60),
                ),
              ),
              const SizedBox(height: 14),
              _buildInput("Nombre del producto", _nameCtrl),
              const SizedBox(height: 14),
              _buildInput(
                "Precio",
                _priceCtrl,
                keyboard: TextInputType.number,
                prefix: "\$ ",
              ),
              const SizedBox(height: 22),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: _saveProduct,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xffFF6A3D),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                      child: Text(
                        _editingProduct == null ? "Guardar" : "Actualizar",
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
                            color: Color(0xff5A0E60), width: 1.4),
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
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInput(String label, TextEditingController ctrl,
      {TextInputType keyboard = TextInputType.text, String? prefix}) {
    return TextField(
      controller: ctrl,
      keyboardType: keyboard,
      decoration: InputDecoration(
        labelText: label,
        prefixText: prefix,
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
    _priceCtrl.clear();
    _editingProduct = null;
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _priceCtrl.dispose();
    super.dispose();
  }

  // ============================================================
  //                      PANTALLA
  // ============================================================
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff7f4fa),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _openForm(),
        backgroundColor: const Color(0xffFF6A3D),
        icon: const Icon(Icons.add, color: Colors.white),
        label: const Text('Producto', style: TextStyle(color: Colors.white)),
      ),
      body: _products.isEmpty
          ? const Center(
              child: Text(
                'No hay productos registrados',
                style: TextStyle(
                  color: Color(0xff5A0E60),
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: _products.length,
              itemBuilder: (context, index) {
                final p = _products[index];
                return Card(
                  elevation: 4,
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: ListTile(
                    leading: const CircleAvatar(
                      backgroundColor: Color(0xff5A0E60),
                      child: Icon(Icons.inventory_2, color: Colors.white),
                    ),
                    title: Text(
                      p.nombre,
                      style: const TextStyle(
                        color: Color(0xff5A0E60),
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                      "Precio: \$${p.precio.toStringAsFixed(0)}",
                      style: const TextStyle(height: 1.4),
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon:
                              const Icon(Icons.edit, color: Color(0xff5A0E60)),
                          onPressed: () => _openForm(product: p),
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () => _deleteProduct(p.id!),
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
