import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;

class DBHelper {
  //Setup Local Database Storage

  static Future<sql.Database> database() async {
    //To write to DB we need to access the DB and setup a connection.
    //Create a DB if we don't have one.
    //Get DB path in File System
    final dbPath = await sql.getDatabasesPath();
    //Note:You can have different versions of the Database
    //Open Database-opens an existing one or creates one if it doesn't exist.
    //Create a database
    return sql.openDatabase(path.join(dbPath, 'task_database.db'),
        onCreate: (db, version) async {
      //We need to execute 2 commands here.I.E we are creating 2 tables.So,we are executing them in a batch.
      sql.Batch batch = db.batch();
      //task_list table
      batch.execute(
          'CREATE TABLE IF NOT EXISTS task_list(id TEXT PRIMARY KEY,title TEXT NOT NULL)');
      //task table
      batch.execute(
          'CREATE TABLE IF NOT EXISTS task(id TEXT PRIMARY KEY,title TEXT NOT NULL,isDone INTEGER NOT NULL,task_list_id TEXT,FOREIGN KEY (task_list_id) REFERENCES task_list(id) ON UPDATE CASCADE ON DELETE CASCADE)');
      List<dynamic> result = await batch.commit();
    }, version: 1);
  }

  //Insert Data
  static Future<void> insert(String table, Map<String, Object> data) async {
    try{
      final db = await DBHelper.database();
      await db.insert(table, data,
          conflictAlgorithm: sql.ConflictAlgorithm.replace);
    }on sql.DatabaseException catch(e){
    print(e.toString());
  }
    try{}on sql.DatabaseException catch(e){
      print(e.toString());
    }
  }

  //Fetch Data for Task List
  static Future<List<Map<String, dynamic>>> getData(String table) async {
    List<Map<String, dynamic>> resultSet=[];
    try{
      final db = await DBHelper.database();
       resultSet= await db.query(table);
    }on sql.DatabaseException catch(e){
      print(e.toString());
    }
  return resultSet;
  }

//Fetch data for Task by their foreign key task_list_id
  static Future<List<Map<String, dynamic>>> getTaskData(
      String table, List<String> whereArgs) async {
    List<Map<String, dynamic>> resultSet=[];
    try{
      final db = await DBHelper.database();
      resultSet= await db
          .query(table, where: 'task_list_id=?', whereArgs: [whereArgs[0]]);
    }on sql.DatabaseException catch(e){
      print(e.toString());
    }
    return resultSet;
  }

//Update
//TODO:Get where and where args from the model
  static Future<void> update(String table, Map<String, Object> data) async {
    final db = await DBHelper.database();
    try{
      await db.update(table, data,
          where: 'id=?',
          whereArgs: ['id'],
          conflictAlgorithm: sql.ConflictAlgorithm.replace);
    }on sql.DatabaseException catch(e){
      print(e.toString());
    }
  }

  //Delete
  static Future<void> delete(String table, Map<String, Object> data) async {
    final db = await DBHelper.database();
    try{
        await db.delete(
        table,
        where: 'id=?',
        whereArgs: [data['id']],
      );
    }on sql.DatabaseException catch(e){
      print(e.toString());
    }
  }
}
