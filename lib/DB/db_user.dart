import 'dart:developer';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:fgh/user.dart';

class DB_user {
  static final DB_user instance = DB_user._instance();
  static Database? _database;

  DB_user._instance();

  Future<Database> get db async {
    _database ??= await initDb();
    return _database!;
  }

  Future<Database> initDb() async {
    String databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'client1.db');
    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE user (
        id INTEGER PRIMARY KEY,
        token TEXT,
        email TEXT,
        username TEXT
      )
    ''');
    await db.insert('user', {"id": 0, "token": '0', "email": '0', "username": '0'});
  }

  Future<List<Map<String, dynamic>>> getUser() async {
    Database db = await instance.db;
    return await db.query('user');
  }

  Future<int> saveUser(User user) async {
    Database db = await instance.db;
    return await db.update('user', user.toMap(), where: 'id = ?', whereArgs: [0]);
  }
  Future<int> outUser() async {
    Database db = await instance.db;
    return await db.update('user', {"id": 0, "token": '0', "email": '0', "username": '0'}, where: 'id = ?', whereArgs: [0]);
  }
}