import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/product.dart';

class CartDB {
  static Database? _database;

  static Future<Database> get _db async {
    if (_database != null) return _database!;
    final path = join(await getDatabasesPath(), 'cart.db');
    return _database = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        return db.execute('''
          CREATE TABLE cart(
            id INTEGER PRIMARY KEY,
            title TEXT,
            description TEXT,
            price REAL,
            image TEXT,
            quantity INTEGER
          )
        ''');
      },
    );
  }

  static Future<void> insert(Product product) async {
    final db = await _db;
    await db.insert('cart', product.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<void> delete(int id) async {
    final db = await _db;
    await db.delete('cart', where: 'id = ?', whereArgs: [id]);
  }

  static Future<List<Product>> getAll() async {
    final db = await _db;
    final maps = await db.query('cart');
    return maps.map((map) => Product.fromMap(map)).toList();
  }

  static Future<void> clear() async {
    final db = await _db;
    await db.delete('cart');
  }
}
