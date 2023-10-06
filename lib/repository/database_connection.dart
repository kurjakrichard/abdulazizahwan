import 'package:path_provider/path_provider.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart';
import 'dart:io';

class DatabaseConnection {
  static DatabaseConnection? _databaseConnection;
  DatabaseConnection._createInstance();
  Map table = {
    'tableName': 'categories',
    'colId': 'id',
    'colName': 'name',
    'colDescription': 'description'
  };

  factory DatabaseConnection() {
    _databaseConnection ??= DatabaseConnection._createInstance();
    return _databaseConnection!;
  }

  Future<Database> initializeDB() async {
    var directory = await getApplicationDocumentsDirectory();
    var path = join(directory.path, 'todolist.db');

    if (Platform.isWindows || Platform.isLinux) {
      sqfliteFfiInit();
      DatabaseFactory databaseFactory = databaseFactoryFfi;
      Database database = await databaseFactory.openDatabase(path,
          options: OpenDatabaseOptions(
            onCreate: (database, version) async {
              _createDb(database, version);
            },
            version: 1,
          ));
      return database;
    } else {
      return openDatabase(
        path,
        onCreate: (database, version) async {
          _createDb(database, version);
        },
        version: 1,
      );
    }
  }

  void _createDb(Database database, int newVersion) async {
    //await db.execute('DROP TABLE IF EXIST ${table['tableName']}');
    await database.execute(
        'CREATE TABLE ${table['tableName']} (${table['colId']} INTEGER PRIMARY KEY AUTOINCREMENT,'
        '${table['colName']} TEXT, ${table['colDescription']} TEXT)');
  }
}
