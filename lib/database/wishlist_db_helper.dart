import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../models/product.dart';

class WishlistDB {
  static Database? _database;

  static Future<Database> get _db async {
    if (_database != null) return _database!;
    //  print("[WishlistDB] Opening database...");
    _database = await _initDB();
    return _database!;
  }

  static Future<Database> _initDB() async {
    final path = join(await getDatabasesPath(), 'wishlist.db');
    // print("[WishlistDB] DB Path: $path");
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        // print("[WishlistDB] Creating wishlist table");
        await db.execute('''
          CREATE TABLE wishlist(
            id INTEGER PRIMARY KEY,
            title TEXT,
            description TEXT,
            price REAL,
            image TEXT
          )
        ''');
      },
    );
  }

  static Future<void> insert(Product product) async {
    final db = await _db;
    //  print("[WishlistDB] Inserting product ${product.id}");
    await db.insert(
      'wishlist',
      product.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<void> delete(int id) async {
    final db = await _db;
    // print("[WishlistDB] Deleting product $id");

    await db.delete('wishlist', where: 'id = ?', whereArgs: [id]);
  }

  static Future<List<Product>> getAll() async {
    final db = await _db;

    final List<Map<String, dynamic>> maps = await db.query('wishlist');
    // print("[WishlistDB] Retrieved ${maps.length} products from DB");
    return maps.map((map) => Product.fromMap(map)).toList();
  }
}
