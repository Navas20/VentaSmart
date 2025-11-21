import 'package:floor/floor.dart';
import '../models/venta.dart';

@dao
abstract class VentaDao {
  @Query('SELECT * FROM Venta')
  Future<List<Venta>> findAllVentas();

  @Query('SELECT * FROM Venta WHERE id = :id')
  Future<Venta?> findVentaById(int id);

  @insert
  Future<int> insertVenta(Venta venta);

  @update
  Future<int> updateVenta(Venta venta);

  @delete
  Future<int> deleteVenta(Venta venta);
}
