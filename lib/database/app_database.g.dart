// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

abstract class $AppDatabaseBuilderContract {
  /// Adds migrations to the builder.
  $AppDatabaseBuilderContract addMigrations(List<Migration> migrations);

  /// Adds a database [Callback] to the builder.
  $AppDatabaseBuilderContract addCallback(Callback callback);

  /// Creates the database and initializes it.
  Future<AppDatabase> build();
}

// ignore: avoid_classes_with_only_static_members
class $FloorAppDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static $AppDatabaseBuilderContract databaseBuilder(String name) =>
      _$AppDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static $AppDatabaseBuilderContract inMemoryDatabaseBuilder() =>
      _$AppDatabaseBuilder(null);
}

class _$AppDatabaseBuilder implements $AppDatabaseBuilderContract {
  _$AppDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  @override
  $AppDatabaseBuilderContract addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  @override
  $AppDatabaseBuilderContract addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  @override
  Future<AppDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$AppDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$AppDatabase extends AppDatabase {
  _$AppDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  ClienteDao? _clienteDaoInstance;

  ProductoDao? _productoDaoInstance;

  VentasDao? _ventasDaoInstance;

  UsuarioDao? _usuarioDaoInstance;

  Future<sqflite.Database> open(
    String path,
    List<Migration> migrations, [
    Callback? callback,
  ]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 3,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `clientes` (`id` INTEGER, `nombre` TEXT NOT NULL, `correo` TEXT NOT NULL, `telefono` TEXT NOT NULL, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `productos` (`id` INTEGER, `nombre` TEXT NOT NULL, `precio` REAL NOT NULL, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `ventas` (`id` INTEGER, `idCliente` INTEGER NOT NULL, `idProducto` INTEGER NOT NULL, `cantidad` INTEGER NOT NULL, `total` REAL NOT NULL, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `Usuario` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `nombre` TEXT NOT NULL, `correo` TEXT NOT NULL, `password` TEXT NOT NULL)');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  ClienteDao get clienteDao {
    return _clienteDaoInstance ??= _$ClienteDao(database, changeListener);
  }

  @override
  ProductoDao get productoDao {
    return _productoDaoInstance ??= _$ProductoDao(database, changeListener);
  }

  @override
  VentasDao get ventasDao {
    return _ventasDaoInstance ??= _$VentasDao(database, changeListener);
  }

  @override
  UsuarioDao get usuarioDao {
    return _usuarioDaoInstance ??= _$UsuarioDao(database, changeListener);
  }
}

class _$ClienteDao extends ClienteDao {
  _$ClienteDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _clienteInsertionAdapter = InsertionAdapter(
            database,
            'clientes',
            (Cliente item) => <String, Object?>{
                  'id': item.id,
                  'nombre': item.nombre,
                  'correo': item.correo,
                  'telefono': item.telefono
                }),
        _clienteUpdateAdapter = UpdateAdapter(
            database,
            'clientes',
            ['id'],
            (Cliente item) => <String, Object?>{
                  'id': item.id,
                  'nombre': item.nombre,
                  'correo': item.correo,
                  'telefono': item.telefono
                }),
        _clienteDeletionAdapter = DeletionAdapter(
            database,
            'clientes',
            ['id'],
            (Cliente item) => <String, Object?>{
                  'id': item.id,
                  'nombre': item.nombre,
                  'correo': item.correo,
                  'telefono': item.telefono
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Cliente> _clienteInsertionAdapter;

  final UpdateAdapter<Cliente> _clienteUpdateAdapter;

  final DeletionAdapter<Cliente> _clienteDeletionAdapter;

  @override
  Future<List<Cliente>> findAllClientes() async {
    return _queryAdapter.queryList('SELECT * FROM clientes',
        mapper: (Map<String, Object?> row) => Cliente(
            id: row['id'] as int?,
            nombre: row['nombre'] as String,
            correo: row['correo'] as String,
            telefono: row['telefono'] as String));
  }

  @override
  Future<Cliente?> findClienteById(int id) async {
    return _queryAdapter.query('SELECT * FROM clientes WHERE id = ?1',
        mapper: (Map<String, Object?> row) => Cliente(
            id: row['id'] as int?,
            nombre: row['nombre'] as String,
            correo: row['correo'] as String,
            telefono: row['telefono'] as String),
        arguments: [id]);
  }

  @override
  Future<void> insertCliente(Cliente cliente) async {
    await _clienteInsertionAdapter.insert(cliente, OnConflictStrategy.abort);
  }

  @override
  Future<void> updateCliente(Cliente cliente) async {
    await _clienteUpdateAdapter.update(cliente, OnConflictStrategy.abort);
  }

  @override
  Future<void> deleteCliente(Cliente cliente) async {
    await _clienteDeletionAdapter.delete(cliente);
  }
}

class _$ProductoDao extends ProductoDao {
  _$ProductoDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _productoInsertionAdapter = InsertionAdapter(
            database,
            'productos',
            (Producto item) => <String, Object?>{
                  'id': item.id,
                  'nombre': item.nombre,
                  'precio': item.precio
                }),
        _productoUpdateAdapter = UpdateAdapter(
            database,
            'productos',
            ['id'],
            (Producto item) => <String, Object?>{
                  'id': item.id,
                  'nombre': item.nombre,
                  'precio': item.precio
                }),
        _productoDeletionAdapter = DeletionAdapter(
            database,
            'productos',
            ['id'],
            (Producto item) => <String, Object?>{
                  'id': item.id,
                  'nombre': item.nombre,
                  'precio': item.precio
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Producto> _productoInsertionAdapter;

  final UpdateAdapter<Producto> _productoUpdateAdapter;

  final DeletionAdapter<Producto> _productoDeletionAdapter;

  @override
  Future<List<Producto>> findAllProductos() async {
    return _queryAdapter.queryList('SELECT * FROM productos',
        mapper: (Map<String, Object?> row) => Producto(
            id: row['id'] as int?,
            nombre: row['nombre'] as String,
            precio: row['precio'] as double));
  }

  @override
  Future<Producto?> findProductoById(int id) async {
    return _queryAdapter.query('SELECT * FROM productos WHERE id = ?1',
        mapper: (Map<String, Object?> row) => Producto(
            id: row['id'] as int?,
            nombre: row['nombre'] as String,
            precio: row['precio'] as double),
        arguments: [id]);
  }

  @override
  Future<void> insertProducto(Producto producto) async {
    await _productoInsertionAdapter.insert(producto, OnConflictStrategy.abort);
  }

  @override
  Future<void> updateProducto(Producto producto) async {
    await _productoUpdateAdapter.update(producto, OnConflictStrategy.abort);
  }

  @override
  Future<void> deleteProducto(Producto producto) async {
    await _productoDeletionAdapter.delete(producto);
  }
}

class _$VentasDao extends VentasDao {
  _$VentasDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _ventaInsertionAdapter = InsertionAdapter(
            database,
            'ventas',
            (Venta item) => <String, Object?>{
                  'id': item.id,
                  'idCliente': item.idCliente,
                  'idProducto': item.idProducto,
                  'cantidad': item.cantidad,
                  'total': item.total
                }),
        _ventaUpdateAdapter = UpdateAdapter(
            database,
            'ventas',
            ['id'],
            (Venta item) => <String, Object?>{
                  'id': item.id,
                  'idCliente': item.idCliente,
                  'idProducto': item.idProducto,
                  'cantidad': item.cantidad,
                  'total': item.total
                }),
        _ventaDeletionAdapter = DeletionAdapter(
            database,
            'ventas',
            ['id'],
            (Venta item) => <String, Object?>{
                  'id': item.id,
                  'idCliente': item.idCliente,
                  'idProducto': item.idProducto,
                  'cantidad': item.cantidad,
                  'total': item.total
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Venta> _ventaInsertionAdapter;

  final UpdateAdapter<Venta> _ventaUpdateAdapter;

  final DeletionAdapter<Venta> _ventaDeletionAdapter;

  @override
  Future<List<Venta>> findAllVentas() async {
    return _queryAdapter.queryList('SELECT * FROM ventas',
        mapper: (Map<String, Object?> row) => Venta(
            id: row['id'] as int?,
            idCliente: row['idCliente'] as int,
            idProducto: row['idProducto'] as int,
            cantidad: row['cantidad'] as int,
            total: row['total'] as double));
  }

  @override
  Future<Venta?> findVentaById(int id) async {
    return _queryAdapter.query('SELECT * FROM ventas WHERE id = ?1',
        mapper: (Map<String, Object?> row) => Venta(
            id: row['id'] as int?,
            idCliente: row['idCliente'] as int,
            idProducto: row['idProducto'] as int,
            cantidad: row['cantidad'] as int,
            total: row['total'] as double),
        arguments: [id]);
  }

  @override
  Future<void> insertVenta(Venta venta) async {
    await _ventaInsertionAdapter.insert(venta, OnConflictStrategy.abort);
  }

  @override
  Future<void> updateVenta(Venta venta) async {
    await _ventaUpdateAdapter.update(venta, OnConflictStrategy.abort);
  }

  @override
  Future<void> deleteVenta(Venta venta) async {
    await _ventaDeletionAdapter.delete(venta);
  }
}

class _$UsuarioDao extends UsuarioDao {
  _$UsuarioDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _usuarioInsertionAdapter = InsertionAdapter(
            database,
            'Usuario',
            (Usuario item) => <String, Object?>{
                  'id': item.id,
                  'nombre': item.nombre,
                  'correo': item.correo,
                  'password': item.password
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Usuario> _usuarioInsertionAdapter;

  @override
  Future<Usuario?> findByEmail(String correo) async {
    return _queryAdapter.query('SELECT * FROM Usuario WHERE correo = ?1',
        mapper: (Map<String, Object?> row) => Usuario(
            id: row['id'] as int?,
            nombre: row['nombre'] as String,
            correo: row['correo'] as String,
            password: row['password'] as String),
        arguments: [correo]);
  }

  @override
  Future<Usuario?> findById(int id) async {
    return _queryAdapter.query('SELECT * FROM Usuario WHERE id = ?1',
        mapper: (Map<String, Object?> row) => Usuario(
            id: row['id'] as int?,
            nombre: row['nombre'] as String,
            correo: row['correo'] as String,
            password: row['password'] as String),
        arguments: [id]);
  }

  @override
  Future<void> insertUsuario(Usuario usuario) async {
    await _usuarioInsertionAdapter.insert(usuario, OnConflictStrategy.abort);
  }
}
