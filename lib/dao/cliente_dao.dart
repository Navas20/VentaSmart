import 'package:floor/floor.dart';
import '../models/cliente.dart';

@dao
abstract class ClienteDao {
  @Query('SELECT * FROM Cliente')
  Future<List<Cliente>> findAllClientes();

  @Query('SELECT * FROM Cliente WHERE id = :id')
  Future<Cliente?> findClienteById(int id);

  @insert
  Future<int> insertCliente(Cliente cliente);

  @update
  Future<int> updateCliente(Cliente cliente);

  @delete
  Future<int> deleteCliente(Cliente cliente);
}
