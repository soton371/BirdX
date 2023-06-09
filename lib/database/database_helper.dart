import 'dart:io';
import 'package:birdx/models/contact.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static const _databaseName = "contacts.db";
  static const _databaseVersion = 1;
  static const table = 'contacts';

  static const columnId = '_id';
  static const columnName = 'name';
  static const columnNumber = 'number';

  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database? _database;
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    return await openDatabase(path,
        version: _databaseVersion,
        onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
          CREATE TABLE $table (
            $columnId INTEGER PRIMARY KEY AUTOINCREMENT,
            $columnName TEXT NOT NULL,
            $columnNumber TEXT NOT NULL
          )
          ''');
  }

  Future<int> insertContact(Contact contact) async {
    Database db = await instance.database;
    return await db.insert(table, contact.toMap());
  }

  Future<int> updateContact(Contact contact) async {
    Database db = await instance.database;
    int id = contact.id!;
    return await db.update(table, contact.toMap(),
        where: '$columnId = ?', whereArgs: [id]);
  }

  Future<int> deleteContact(int id) async {
    Database db = await instance.database;
    return await db.delete(table, where: '$columnId = ?', whereArgs: [id]);
  }

  Future<List<Contact>> getContacts() async {
    Database db = await instance.database;
    List<Map<String, dynamic>> maps = await db.query(table);
    return List.generate(maps.length, (i) {
      return Contact(
        id: maps[i][columnId],
        name: maps[i][columnName],
        number: maps[i][columnNumber],
      );
    });
  }
}