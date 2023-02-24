import 'package:sqflite/sqflite.dart';
import 'dart:async';
import '/models/category.dart';
import 'database_connection.dart';

class DatabaseHandler {
  DatabaseConnection? _databaseConnection;

  Map table = {
    'tableName': 'categories',
    'colId': 'id',
    'colName': 'name',
    'colDescription': 'description'
  };

  DatabaseHandler() {
    _databaseConnection = DatabaseConnection();
  }

  static Database? _database;

  Future<Database>? get database async {
    if (_database == null) {
      _database = await _databaseConnection!.initializeDB();
      return _database!;
    }
    return _database!;
  }

  // Fetch Operation: Get all data from database
  Future<List<Map<String, dynamic>>> getData(String table, String order) async {
    Database? db = await database;
    //var result = await db.rawQuery('SELECT * FROM ${table['tablename']} order by ${table['colPriority']} ASC');
    var result = await db!.query(table, orderBy: order);
    return result;
  }

  // Insert Operation: Insert new record to database
  Future<int> insert(String table, Map<String, dynamic> category) async {
    Database? db = await database;
    return await db!.insert(table, category);
  }

  // Update Operation: Update record in the database
  Future<int> update(String tableName, Category category) async {
    Database? db = await database;
    int result = await db!.update(tableName, category.toMap(),
        where: '${table['colId']} = ?', whereArgs: [category.id]);
    return result;
  }

  // Delete Operation: Delete record from database
  Future<int> delete(int id) async {
    Database? db = await database;
    int result =
        await db!.delete(table['tableName'], where: 'id = ?', whereArgs: [id]);
    return result;
  }

  // Get the numbers of the records in database
  Future<int> getCount() async {
    Database? db = await database;
    List<Map<String, dynamic>> records =
        await db!.rawQuery('SELECT COUNT (*) FROM ${table['tablename']}');
    int result = Sqflite.firstIntValue(records) ?? 0;
    return result;
  }

  // Get the MapList and convert it to NoteList
  Future<List<Category>> getCategoryList(String table, String order) async {
    List<Map<String, dynamic>> categoryMapList = await getData(table, order);
    int count = categoryMapList.length;
    List<Category> categoryList = <Category>[];
    for (int i = 0; i < count; i++) {
      categoryList.add(Category.fromMapObject(categoryMapList[i]));
    }
    return categoryList;
  }
}
