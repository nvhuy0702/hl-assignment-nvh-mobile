import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'vote_model.dart';

class VotesDatabase {
  static final VotesDatabase instance = VotesDatabase._init();

  static Database? _database;

  VotesDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('votes.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {  
    const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const textType = 'TEXT';

    await db.execute('''
CREATE TABLE $tableVotes ( 
  ${VoteFields.id} $idType, 
  ${VoteFields.contentJoke} $textType,
  ${VoteFields.funny} $textType,
  ${VoteFields.notFunny} $textType
  )
''');
  }

  Future<Vote> create(Vote note) async {
    final db = await instance.database;
    final id = await db.insert(tableVotes, note.toJson());
    return note.copy(id: id);
  }
}
