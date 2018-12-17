import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'package:writing_prompt/data/models/prompt.dart';

final String tablePrompt = 'prompt';
final String columnCount = 'count';
final String columnEnglish = 'english';
final String columnDone = 'done';

class DbHelper {
  Database _db;

  Future<Database> get db async {
    if(_db != null)
      return _db;
    _db = await initDb();
    return _db;
  }

  Future<Database> initDb() async {
    String path = join(await getDatabasesPath(), "test.db");
    return await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
          await db.execute('''
            create table $tablePrompt ( 
              $columnCount integer primary key, 
              $columnEnglish text not null,
              $columnDone integer not null)
            ''');
        });
  }

  Future<int> insert(Prompt prompt) async {
    var dbClient = await db;
    return await dbClient.insert(tablePrompt, prompt.toMap());
  }

  Future<List<Prompt>> getPrompts() async {
    var dbClient = await db;
    List<Map> maps = await dbClient.query(tablePrompt);
    List<Prompt> prompts = List<Prompt>();
    for (var value in maps) {
      prompts.add(Prompt.fromMap(value));
    }
    return prompts;
  }

  Future<int> delete(int id) async {
    var dbClient = await db;
    return await dbClient.delete(tablePrompt, where: '$columnCount = ?', whereArgs: [id]);
  }

  Future<int> update(Prompt prompt) async {
    var dbClient = await db;
    return await dbClient.update(tablePrompt, prompt.toMap(),
        where: '$columnCount = ?', whereArgs: [prompt.count]);
  }

  Future close() async {
    await db
      ..close();
  }

  DbHelper();

}