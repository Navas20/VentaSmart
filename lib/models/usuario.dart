import 'package:floor/floor.dart';

@entity
class Usuario {
  @PrimaryKey(autoGenerate: true)
  final int? id;

  final String nombre;
  final String correo;
  final String password;

  Usuario({
    this.id,
    required this.nombre,
    required this.correo,
    required this.password,
  });
}
