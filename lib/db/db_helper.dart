import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo/models/task.dart';

class DBHelper {
  static Database? _db;
  static final int _version = 1;
  static final String _tableName = 'task';

  static Future<void> initDb() async {
    if (_db != null) {
      debugPrint('Not Null DB');
      return;
    } else {
      try {
        String _path = await getDatabasesPath() + 'task.db';
        debugPrint('init database path');
        Database db = await openDatabase(_path, version: _version,
            onCreate: (Database db, int version) async {
          debugPrint('creating a new one');
          await db.execute('CREATE TABLE $_tableName ('
              'id INTEGER PRIMARY KEY AUTOINCREMENT, '
              'title STRING, note TEXT , date STRING '
              'remind INTEGER, repeat STRING, '
              'color INTEGER, '
              'isCompleted INTEGER)');
        });
      } catch (e) {
        print(e);
      }
    }
  }

  static Future<int> insert(Task? task) async {
    print('insert function code');
    return await _db!.insert(_tableName, task!.toJson());
  }

  static Future<int> delete(Task? task) async {
    print('delete function code');
    return await _db!.delete(_tableName, where: 'id=?', whereArgs: [task!.id]);
  }

  static Future<List<Map<String, dynamic>>> query(Task? task) async {
    print('query function code');
    return await _db!.query(_tableName);
  }

  static Future<int> update(int id) async {
    print('update function code');
    return await _db!.rawUpdate(''' 
    
      UPDATE task 
      SET isCompleted = ?
      WHERE id = ? 

    ''', [1, id]);
  }
}
