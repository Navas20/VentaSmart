import 'package:floor/floor.dart';
import '../models/cliente.dart';

@dao
abstract class ClienteDao {
  @Query('SELECT * FROM clientes')
  Future<List<Cliente>> findAllClientes();

  @Query('SELECT * FROM clientes WHERE id = :id')
  Future<Cliente?> findClienteById(int id);

  @insert
  Future<void> insertCliente(Cliente cliente);

  @update
  Future<void> updateCliente(Cliente cliente);

  @delete
  Future<void> deleteCliente(Cliente cliente);
}
