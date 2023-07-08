import 'dart:io';
import 'package:birdx/models/contact.dart';
import 'package:birdx/models/pending_msg_mod.dart';
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

  //add for pending message
  static const pendingTable = 'pending';
  static const pendingColumnId = '_id';
  static const pendingColumnName = 'name';
  static const pendingColumnNumber = 'number';
  static const pendingColumnMessage = 'message';
  static const pendingColumnDurationInSec = 'duration';
  static const pendingColumnTime = 'time';

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
        version: _databaseVersion, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
          CREATE TABLE $table (
            $columnId INTEGER PRIMARY KEY AUTOINCREMENT,
            $columnName TEXT NOT NULL,
            $columnNumber TEXT NOT NULL
          )
          ''');

    //add for pending table
    await db.execute('''
          CREATE TABLE $pendingTable (
            $pendingColumnId INTEGER PRIMARY KEY AUTOINCREMENT,
            $pendingColumnName TEXT NOT NULL,
            $pendingColumnNumber TEXT NOT NULL,
            $pendingColumnMessage TEXT NOT NULL,
            $pendingColumnDurationInSec TEXT NOT NULL,
            $pendingColumnTime TEXT NOT NULL
          )
          ''');
  }

  //add for contacts
  Future<int> insertContact(Contact contact) async {
    Database db = await instance.database;
    return await db.insert(table, contact.toMap());
  }

  //add for pending msg
  Future<int> insertPendingMsg(PendingMsgModel pendingMsgModel) async {
    Database db = await instance.database;
    return await db.insert(pendingTable, pendingMsgModel.toMap());
  }

  //add for contacts
  Future<int> updateContact(Contact contact) async {
    Database db = await instance.database;
    int id = contact.id!;
    return await db.update(table, contact.toMap(),
        where: '$columnId = ?', whereArgs: [id]);
  }

  //add for pending msg
  Future<int> updatePendingMsg(PendingMsgModel pendingMsgModel) async {
    Database db = await instance.database;
    int id = pendingMsgModel.id!;
    return await db.update(pendingTable, pendingMsgModel.toMap(),
        where: '$pendingColumnId = ?', whereArgs: [id]);
  }

  //add for contacts
  Future<int> deleteContact(int id) async {
    Database db = await instance.database;
    return await db.delete(table, where: '$columnId = ?', whereArgs: [id]);
  }

  //add for pending msg
  Future<int> deletePending(int id) async {
    Database db = await instance.database;
    return await db.delete(pendingTable, where: '$pendingColumnId = ?', whereArgs: [id]);
  }

  //add for contacts
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

  //add for pending msg
  Future<List<PendingMsgModel>> getPendingMsg() async {
    Database db = await instance.database;
    List<Map<String, dynamic>> maps = await db.query(pendingTable);
    return List.generate(maps.length, (i) {
      return PendingMsgModel(
        id: maps[i][pendingColumnId],
        name: maps[i][pendingColumnName],
        number: maps[i][pendingColumnNumber],
        message: maps[i][pendingColumnMessage],
        durationInSec: maps[i][pendingColumnDurationInSec],
        time: maps[i][pendingColumnTime]
      );
    });
  }

}
