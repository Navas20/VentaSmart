import 'dart:async';
import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

import '../models/cliente.dart';
import '../models/producto.dart';
import '../models/usuario.dart';
import '../models/venta.dart';

import '../dao/cliente_dao.dart';
import '../dao/producto_dao.dart';
import '../dao/usuario_dao.dart';
import '../dao/ventas_dao.dart';

part 'app_database.g.dart';

@Database(
  version: 3,
  entities: [
    Cliente,
    Producto,
    Venta,
    Usuario, // 👈 YA ESTÁ BIEN
  ],
)
abstract class AppDatabase extends FloorDatabase {
  ClienteDao get clienteDao;
  ProductoDao get productoDao;
  VentasDao get ventasDao;
  UsuarioDao get usuarioDao; // 👈 YA ESTÁ LISTO
}
