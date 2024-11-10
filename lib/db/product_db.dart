import 'package:sqflite/sqflite.dart';
import 'package:store_management/services/database_service.dart';
import 'package:store_management/models/product_model.dart';

class ProductDB {
  final String table = 'products';

  Future<void> createTable(Database db) async {
    await db.execute('''
      CREATE TABLE $table (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT,
        price INTEGER,
        stock INTEGER,
        status INTEGER,
        description TEXT,
        image TEXT
      )
    ''');
  }

  Future<int> insert(ProductModel product) async {
    final db = await DatabaseService().database;
    return await db.insert(table, product.toJson());
  }

  Future<List<ProductModel>> getAll(String? search) async {
    final db = await DatabaseService().database;
    List<Map<String, dynamic>> maps = await db.query(table);

    if (search != null) {
      maps = await db.query(
        table,
        where: 'name LIKE ?',
        whereArgs: ['%$search%'],
      );
    }

    return List.generate(maps.length, (i) {
      return ProductModel(
        id: maps[i]['id'],
        name: maps[i]['name'],
        price: maps[i]['price'],
        stock: maps[i]['stock'],
        status: maps[i]['status'],
        description: maps[i]['description'],
        image: maps[i]['image'],
      );
    });
  }

  Future<int> update(ProductModel product) async {
    final db = await DatabaseService().database;
    return await db.update(
      table,
      product.toJson(),
      where: 'id = ?',
      whereArgs: [product.id],
    );
  }

  Future<int> delete(int id) async {
    final db = await DatabaseService().database;
    return await db.delete(
      table,
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
