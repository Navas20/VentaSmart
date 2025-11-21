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

  VentaDao? _ventaDaoInstance;

  Future<sqflite.Database> open(
    String path,
    List<Migration> migrations, [
    Callback? callback,
  ]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
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
            'CREATE TABLE IF NOT EXISTS `Cliente` (`id` INTEGER, `nombre` TEXT NOT NULL, `telefono` TEXT NOT NULL, `correo` TEXT NOT NULL, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `Producto` (`id` INTEGER, `nombre` TEXT NOT NULL, `precio` REAL NOT NULL, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `Venta` (`id` INTEGER, `productoId` INTEGER NOT NULL, `clienteId` INTEGER NOT NULL, `fecha` TEXT NOT NULL, `total` REAL NOT NULL, PRIMARY KEY (`id`))');

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
  VentaDao get ventaDao {
    return _ventaDaoInstance ??= _$VentaDao(database, changeListener);
  }
}

class _$ClienteDao extends ClienteDao {
  _$ClienteDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _clienteInsertionAdapter = InsertionAdapter(
            database,
            'Cliente',
            (Cliente item) => <String, Object?>{
                  'id': item.id,
                  'nombre': item.nombre,
                  'telefono': item.telefono,
                  'correo': item.correo
                }),
        _clienteUpdateAdapter = UpdateAdapter(
            database,
            'Cliente',
            ['id'],
            (Cliente item) => <String, Object?>{
                  'id': item.id,
                  'nombre': item.nombre,
                  'telefono': item.telefono,
                  'correo': item.correo
                }),
        _clienteDeletionAdapter = DeletionAdapter(
            database,
            'Cliente',
            ['id'],
            (Cliente item) => <String, Object?>{
                  'id': item.id,
                  'nombre': item.nombre,
                  'telefono': item.telefono,
                  'correo': item.correo
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Cliente> _clienteInsertionAdapter;

  final UpdateAdapter<Cliente> _clienteUpdateAdapter;

  final DeletionAdapter<Cliente> _clienteDeletionAdapter;

  @override
  Future<List<Cliente>> findAllClientes() async {
    return _queryAdapter.queryList('SELECT * FROM Cliente',
        mapper: (Map<String, Object?> row) => Cliente(
            id: row['id'] as int?,
            nombre: row['nombre'] as String,
            telefono: row['telefono'] as String,
            correo: row['correo'] as String));
  }

  @override
  Future<Cliente?> findClienteById(int id) async {
    return _queryAdapter.query('SELECT * FROM Cliente WHERE id = ?1',
        mapper: (Map<String, Object?> row) => Cliente(
            id: row['id'] as int?,
            nombre: row['nombre'] as String,
            telefono: row['telefono'] as String,
            correo: row['correo'] as String),
        arguments: [id]);
  }

  @override
  Future<int> insertCliente(Cliente cliente) {
    return _clienteInsertionAdapter.insertAndReturnId(
        cliente, OnConflictStrategy.abort);
  }

  @override
  Future<int> updateCliente(Cliente cliente) {
    return _clienteUpdateAdapter.updateAndReturnChangedRows(
        cliente, OnConflictStrategy.abort);
  }

  @override
  Future<int> deleteCliente(Cliente cliente) {
    return _clienteDeletionAdapter.deleteAndReturnChangedRows(cliente);
  }
}

class _$ProductoDao extends ProductoDao {
  _$ProductoDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _productoInsertionAdapter = InsertionAdapter(
            database,
            'Producto',
            (Producto item) => <String, Object?>{
                  'id': item.id,
                  'nombre': item.nombre,
                  'precio': item.precio
                }),
        _productoUpdateAdapter = UpdateAdapter(
            database,
            'Producto',
            ['id'],
            (Producto item) => <String, Object?>{
                  'id': item.id,
                  'nombre': item.nombre,
                  'precio': item.precio
                }),
        _productoDeletionAdapter = DeletionAdapter(
            database,
            'Producto',
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
    return _queryAdapter.queryList('SELECT * FROM Producto',
        mapper: (Map<String, Object?> row) => Producto(
            id: row['id'] as int?,
            nombre: row['nombre'] as String,
            precio: row['precio'] as double));
  }

  @override
  Future<Producto?> findProductoById(int id) async {
    return _queryAdapter.query('SELECT * FROM Producto WHERE id = ?1',
        mapper: (Map<String, Object?> row) => Producto(
            id: row['id'] as int?,
            nombre: row['nombre'] as String,
            precio: row['precio'] as double),
        arguments: [id]);
  }

  @override
  Future<int> insertProducto(Producto producto) {
    return _productoInsertionAdapter.insertAndReturnId(
        producto, OnConflictStrategy.abort);
  }

  @override
  Future<int> updateProducto(Producto producto) {
    return _productoUpdateAdapter.updateAndReturnChangedRows(
        producto, OnConflictStrategy.abort);
  }

  @override
  Future<int> deleteProducto(Producto producto) {
    return _productoDeletionAdapter.deleteAndReturnChangedRows(producto);
  }
}

class _$VentaDao extends VentaDao {
  _$VentaDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _ventaInsertionAdapter = InsertionAdapter(
            database,
            'Venta',
            (Venta item) => <String, Object?>{
                  'id': item.id,
                  'productoId': item.productoId,
                  'clienteId': item.clienteId,
                  'fecha': item.fecha,
                  'total': item.total
                }),
        _ventaUpdateAdapter = UpdateAdapter(
            database,
            'Venta',
            ['id'],
            (Venta item) => <String, Object?>{
                  'id': item.id,
                  'productoId': item.productoId,
                  'clienteId': item.clienteId,
                  'fecha': item.fecha,
                  'total': item.total
                }),
        _ventaDeletionAdapter = DeletionAdapter(
            database,
            'Venta',
            ['id'],
            (Venta item) => <String, Object?>{
                  'id': item.id,
                  'productoId': item.productoId,
                  'clienteId': item.clienteId,
                  'fecha': item.fecha,
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
    return _queryAdapter.queryList('SELECT * FROM Venta',
        mapper: (Map<String, Object?> row) => Venta(
            id: row['id'] as int?,
            productoId: row['productoId'] as int,
            clienteId: row['clienteId'] as int,
            fecha: row['fecha'] as String,
            total: row['total'] as double));
  }

  @override
  Future<Venta?> findVentaById(int id) async {
    return _queryAdapter.query('SELECT * FROM Venta WHERE id = ?1',
        mapper: (Map<String, Object?> row) => Venta(
            id: row['id'] as int?,
            productoId: row['productoId'] as int,
            clienteId: row['clienteId'] as int,
            fecha: row['fecha'] as String,
            total: row['total'] as double),
        arguments: [id]);
  }

  @override
  Future<int> insertVenta(Venta venta) {
    return _ventaInsertionAdapter.insertAndReturnId(
        venta, OnConflictStrategy.abort);
  }

  @override
  Future<int> updateVenta(Venta venta) {
    return _ventaUpdateAdapter.updateAndReturnChangedRows(
        venta, OnConflictStrategy.abort);
  }

  @override
  Future<int> deleteVenta(Venta venta) {
    return _ventaDeletionAdapter.deleteAndReturnChangedRows(venta);
  }
}
