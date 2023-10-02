import 'dart:io';

import 'package:sqflite/sqflite.dart';
import 'package:ai_brainstorm/data/models/message_model.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class ChatDatabase {
  Database? _database;

  Future<Database> get database async {
    if (_database != null){
      return _database!;
    }
    Directory appDocDir = await getApplicationDocumentsDirectory();
    String path = join(appDocDir.path , 'chat_database.db');
    _database = await openDatabase(path);
    return _database!;
  }

  Future<List<String>> get allTableNames async {
    Database db = await database;
    return await db.rawQuery(
      'SELECT * FROM sqlite_master'
    ).then((value){
      return value.map((e) => e['tbl_name'].toString()).toList();
    });
  }

  Future<bool> tableExists(String tableName) async{
    var tables = await allTableNames;
    return tables.contains(tableName);
  }
  

  void create(String tableName) async{
    if (! await tableExists(tableName)){
      Database db = await database;
      db.execute('CREATE TABLE $tableName(timestamp TEXT, message TEXT, sender TEXT)');
    }
  }
  Future<List<Message>> read(String table) async {
    Database db = await database;
    List<Map> maps = await db.query(table);
    List<Message> messages = maps.map((map) => Message.fromMap(map)).toList();
    return messages;
  }

  void update(String table, Message message) async {
    if ( await tableExists(table)){
      Database db = await database;
      db.insert(table, message.toMap());
    }
  }

  void delete (String table) async {
    Database db = await database;
    db.execute('DROP TABLE IF EXISTS $table');
  }
  void close() async{
    Database db = await database;
    db.close();
  }
}