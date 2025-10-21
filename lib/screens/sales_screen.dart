import 'package:flutter/material.dart';

class SalesScreen extends StatefulWidget {
  const SalesScreen({super.key});

  @override
  State<SalesScreen> createState() => _SalesScreenState();
}

class _SalesScreenState extends State<SalesScreen> {
  // Productos disponibles (simulados)
  final List<Map<String, dynamic>> _products = [
    {"name": "Camiseta", "price": 45000},
    {"name": "Pantalón", "price": 80000},
    {"name": "Zapatos", "price": 120000},
  ];

  // Clientes disponibles (simulados)
  final List<Map<String, String>> _clients = [
    {"name": "Juan Pérez", "phone": "3001234567"},
    {"name": "María Gómez", "phone": "3119876543"},
  ];

  // Lista de ventas registradas
  final List<Map<String, dynamic>> _sales = [];

  // Variables temporales para el formulario
  Map<String, dynamic>? _selectedProduct;
  Map<String, String>? _selectedClient;
  int _quantity = 1;

  // Función para registrar la venta
  void _registerSale() {
    if (_selectedProduct == null || _selectedClient == null || _quantity <= 0) {
      return;
    }

    final total = _selectedProduct!["price"] * _quantity;

    setState(() {
      _sales.insert(0, {
        "product": _selectedProduct!["name"],
        "client": _selectedClient!["name"],
        "quantity": _quantity,
        "total": total,
        "date": DateTime.now(),
      });
    });

    Navigator.pop(context);
  }

  // Muestra el formulario en un modal
  void _openSaleDialog() {
    _selectedProduct = _products.first;
    _selectedClient = _clients.first;
    _quantity = 1;

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
        child: StatefulBuilder(
          builder: (context, setStateModal) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Registrar venta',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 12),
                DropdownButtonFormField<Map<String, dynamic>>(
                  value: _selectedProduct,
                  items: _products
                      .map((p) => DropdownMenuItem(
                            value: p,
                            child: Text('${p["name"]} - \$${p["price"]}'),
                          ))
                      .toList(),
                  onChanged: (v) {
                    setStateModal(() {
                      _selectedProduct = v;
                    });
                  },
                  decoration: const InputDecoration(
                    labelText: 'Producto',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 12),
                DropdownButtonFormField<Map<String, String>>(
                  value: _selectedClient,
                  items: _clients
                      .map((c) => DropdownMenuItem(
                            value: c,
                            child: Text(c["name"]!),
                          ))
                      .toList(),
                  onChanged: (v) {
                    setStateModal(() {
                      _selectedClient = v;
                    });
                  },
                  decoration: const InputDecoration(
                    labelText: 'Cliente',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    const Text('Cantidad:'),
                    Expanded(
                      child: Slider(
                        value: _quantity.toDouble(),
                        min: 1,
                        max: 10,
                        divisions: 9,
                        label: '$_quantity',
                        onChanged: (v) {
                          setStateModal(() {
                            _quantity = v.toInt();
                          });
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: _registerSale,
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
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _openSaleDialog,
        icon: const Icon(Icons.add_shopping_cart),
        label: const Text('Venta'),
      ),
      body: _sales.isEmpty
          ? const Center(
              child: Text('No hay ventas registradas.'),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: _sales.length,
              itemBuilder: (context, index) {
                final sale = _sales[index];
                return Card(
                  margin:
                      const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
                  child: ListTile(
                    leading: const Icon(Icons.receipt_long),
                    title: Text(
                        '${sale["product"]} x${sale["quantity"]} — \$${sale["total"]}'),
                    subtitle: Text(
                        '${sale["client"]} · ${sale["date"].toString().substring(0, 16)}'),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete_outline),
                      onPressed: () {
                        setState(() {
                          _sales.removeAt(index);
                        });
                      },
                    ),
                  ),
                );
              },
            ),
    );
  }
}
