import 'package:mytodo/models/Task.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class TaskHelper {
  static const int _version = 1;
  static const String _dbName = 'Task.db';

  static Future<Database> _getDB() async {
    return openDatabase(join(await getDatabasesPath(), _dbName),
        onCreate: (db, version) async => await db.execute(
            "CREATE TABLE Task(id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT NOT NULL,  description TEXT NOT NULL, createdate TEXT NOT NULL, execute NUMERIC);"),
        version: _version);
  }

  static Future<int> addTask(Task task) async {
    final db = await _getDB();
    // final List<Map<String, dynamic>> maps = await db.query("Task");
    //
    // task.id = maps.length + 1;
    return await db.insert("Task", task.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<int> updateTask(Task task) async {
    final db = await _getDB();
    return await db.update("Task", task.toJson(),
        where: 'id = ?',
        whereArgs: [task.id],
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<int> deleteTask(Task task) async {
    final db = await _getDB();
    return await db.delete("Task", where: 'id = ?', whereArgs: [task.id]);
  }

  static Future<List<Task>?> getAllTask(int noExecute) async{
    final db = await _getDB();

    final List<Map<String, dynamic>> maps = await db.query("Task");

    if(maps.isEmpty){
      return null;
    }

      return List.generate(maps.length, (index) => Task.fromJson(maps[index])).where((element) => element.execute == noExecute).toList();
  }

  static Future<void> deleteDB() async{

   databaseFactory.deleteDatabase(_dbName);
  }
}
