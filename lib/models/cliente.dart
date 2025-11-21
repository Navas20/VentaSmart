import 'package:floor/floor.dart';

@entity
class Cliente {
  @primaryKey
  final int? id;

  final String nombre;
  final String telefono;
  final String correo;

  Cliente({
    this.id,
    required this.nombre,
    required this.telefono,
    required this.correo,
  });
}
