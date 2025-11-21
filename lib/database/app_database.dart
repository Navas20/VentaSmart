import 'dart:async';
import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

import '../models/cliente.dart';
import '../models/producto.dart';
import '../models/venta.dart';

import '../dao/cliente_dao.dart';
import '../dao/producto_dao.dart';
import '../dao/venta_dao.dart';

part 'app_database.g.dart';

@Database(
  version: 1,
  entities: [
    Cliente,
    Producto,
    Venta,
  ],
)
abstract class AppDatabase extends FloorDatabase {
  ClienteDao get clienteDao;
  ProductoDao get productoDao;
  VentaDao get ventaDao;
}
