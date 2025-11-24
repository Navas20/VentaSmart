import 'package:floor/floor.dart';
import '../models/producto.dart';

@dao
abstract class ProductoDao {
  @Query('SELECT * FROM productos')
  Future<List<Producto>> findAllProductos();

  @Query('SELECT * FROM productos WHERE id = :id')
  Future<Producto?> findProductoById(int id); // 👈 FALTABA ESTE MÉTODO

  @insert
  Future<void> insertProducto(Producto producto);

  @update
  Future<void> updateProducto(Producto producto);

  @delete
  Future<void> deleteProducto(Producto producto);
}
