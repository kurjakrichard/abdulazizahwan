import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import '/models/category.dart';

class DatabaseHelper {
  static DatabaseHelper? _databaseHelper;
  static Database? _database;
  final String _databaseName = 'todos';
  Map table = {
    'tableName': 'categories',
    'colId': 'id',
    'colName': 'name',
    'colDescription': 'description'
  };

  DatabaseHelper._createInstance();

  Future<Database> get database async {
    _database ??= await initialDatabase();
    return _database!;
  }

  factory DatabaseHelper() {
    _databaseHelper ??= DatabaseHelper._createInstance();
    return _databaseHelper!;
  }

  Future<Database> initialDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = '${directory.path}$_databaseName.db';
    var database = openDatabase(path, version: 1, onCreate: _createDb);
    return database;
  }

  void _createDb(Database db, int newVersion) async {
    //await db.execute('DROP TABLE IF EXIST ${table['tableName']}');
    await db.execute(
        'CREATE TABLE IF NOT EXISTS ${table['tableName']} (${table['colId']} INTEGER PRIMARY KEY AUTOINCREMENT,'
        '${table['colName']} TEXT, ${table['colDescription']} TEXT)');
  }

  // Fetch Operation: Get all data from database
  Future<List<Map<String, dynamic>>> getCategoryMapList() async {
    Database db = await database;
    //var result = await db.rawQuery('SELECT * FROM ${table['tablename']} order by ${table['colPriority']} ASC');
    var result =
        await db.query(table['tableName'], orderBy: table['colDescription']);
    return result;
  }

  // Insert Operation: Insert new record to database
  Future<int> insertCategory(Category category) async {
    Database db = await database;
    var result = await db.insert(table['tableName'], category.toMap());
    return result;
  }

  // Update Operation: Update record in the database
  Future<int> updateCategory(Category category) async {
    var db = await database;
    var result = await db.update(table['tableName'], category.toMap(),
        where: '${table['colId']} = ?', whereArgs: [category.id]);
    return result;
  }

  // Delete Operation: Delete record from database
  Future<int> deleteCategory(int id) async {
    var db = await database;
    int result =
        await db.delete(table['tableName'], where: 'id = ?', whereArgs: [id]);
    return result;
  }

  // Get the numbers of the records in database
  Future<int> getCount() async {
    Database db = await database;
    List<Map<String, dynamic>> records =
        await db.rawQuery('SELECT COUNT (*) FROM ${table['tablename']}');
    int result = Sqflite.firstIntValue(records) ?? 0;
    return result;
  }

  // Get the MapList and convert it to NoteList
  Future<List<Category>> getCategoryList() async {
    List<Map<String, dynamic>> categoryMapList = await getCategoryMapList();
    int count = categoryMapList.length;
    List<Category> categoryList = <Category>[];
    for (int i = 0; i < count; i++) {
      categoryList.add(Category.fromMapObject(categoryMapList[i]));
    }
    return categoryList;
  }
}
