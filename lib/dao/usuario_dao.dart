import 'package:floor/floor.dart';
import '../models/usuario.dart';

@dao
abstract class UsuarioDao {
  @Query('SELECT * FROM Usuario WHERE correo = :correo')
  Future<Usuario?> findByEmail(String correo);

  @Query('SELECT * FROM Usuario WHERE id = :id')
  Future<Usuario?> findById(int id);

  @insert
  Future<void> insertUsuario(Usuario usuario);
}
