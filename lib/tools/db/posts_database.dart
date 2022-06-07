import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:universe/data/models/post.dart';

class PostsDatabase {
  static final PostsDatabase instance = PostsDatabase._init();

  static Database? _database;

  PostsDatabase._init();

  Future<Database?> get database async {
    if (_database != null) return _database;
    _database ??= await _initDB('posts.db');
    return _database;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const intType = 'INTEGER';
    const boolType = 'BOOLEAN';
    const textType = 'TEXT';

    await db.execute('''
    CREATE TABLE $tablePosts (
     ${PostsFields.id} $idType,
     ${PostsFields.columnDocID} $intType,
     ${PostsFields.columnDescription} $textType,
     ${PostsFields.columnIsLiked} $boolType,
     ${PostsFields.columnIsSaved} $boolType,
     ${PostsFields.columnImage} $textType
    )
    ''');
  }

  Future<int?> insertPosts(Map post) async {
    final db = await instance.database;
    var map = <String, dynamic>{};

    map[PostsFields.columnDocID] = post["docID"];
    map[PostsFields.columnDescription] = post["description"];
    map[PostsFields.columnIsLiked] = post["isLiked"];
    map[PostsFields.columnIsSaved] = post["isSaved"];
    map[PostsFields.columnImage] = post["image"];

    var result = await db?.insert(tablePosts, map);
    return result;
  }

  Future<int?> deletePost(Map post) async {
    final db = await instance.database;
    var result = await db?.delete(tablePosts,
        where: '${PostsFields.columnDocID} = ?', whereArgs: [post["docID"]]);
    return result;
  }

  deleteTables() async {
    final db = await instance.database;
    db?.execute("DELETE FROM $tablePosts");
  }

  Future<int?> updatePost(Map post) async {
    final db = await instance.database;
    var map = <String, dynamic>{};

    map[PostsFields.columnDocID] = post["docID"];
    map[PostsFields.columnDescription] = post["description"];
    map[PostsFields.columnIsLiked] = post["isLiked"];
    map[PostsFields.columnIsSaved] = post["isSaved"];
    map[PostsFields.columnImage] = post["image"];

    var result = await db?.update(tablePosts, map,
        where: '${PostsFields.columnDocID} = ?', whereArgs: [post["docID"]]);
    return result;
  }

  Future<List<Post>?> getAllPosts() async {
    final db = await instance.database;
    final result = await db?.query(tablePosts);
    return result?.map((json) => Post.fromJson(json)).toList();
  }

  Future close() async {
    final db = await instance.database;
    db?.close();
  }
}
