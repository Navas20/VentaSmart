import 'package:floor/floor.dart';

@entity
class Producto {
  @primaryKey
  final int? id;

  final String nombre;
  final double precio;

  Producto({
    this.id,
    required this.nombre,
    required this.precio,
  });
}
