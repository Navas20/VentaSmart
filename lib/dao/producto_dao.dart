import 'package:floor/floor.dart';
import '../models/producto.dart';

@dao
abstract class ProductoDao {
  @Query('SELECT * FROM Producto')
  Future<List<Producto>> findAllProductos();

  @Query('SELECT * FROM Producto WHERE id = :id')
  Future<Producto?> findProductoById(int id);

  @insert
  Future<int> insertProducto(Producto producto);

  @update
  Future<int> updateProducto(Producto producto);

  @delete
  Future<int> deleteProducto(Producto producto);
}
