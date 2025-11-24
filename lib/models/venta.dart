import 'package:floor/floor.dart';

@Entity(tableName: 'ventas')
class Venta {
  @primaryKey
  final int? id;

  final int idCliente;
  final int idProducto;
  final int cantidad;
  final double total;

  Venta({
    this.id,
    required this.idCliente,
    required this.idProducto,
    required this.cantidad,
    required this.total,
  });
}
