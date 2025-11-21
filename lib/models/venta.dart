import 'package:floor/floor.dart';

@entity
class Venta {
  @primaryKey
  final int? id;

  final int productoId;
  final int clienteId;
  final String fecha;
  final double total;

  Venta({
    this.id,
    required this.productoId,
    required this.clienteId,
    required this.fecha,
    required this.total,
  });
}
