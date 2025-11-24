import 'package:floor/floor.dart';
import '../models/venta.dart';

@dao
abstract class VentasDao {
  @Query('SELECT * FROM ventas')
  Future<List<Venta>> findAllVentas();

  @Query('SELECT * FROM ventas WHERE id = :id')
  Future<Venta?> findVentaById(int id); // 👈 ESTE MÉTODO FALTABA

  @insert
  Future<void> insertVenta(Venta venta);

  @update
  Future<void> updateVenta(Venta venta);

  @delete
  Future<void> deleteVenta(Venta venta);
}
