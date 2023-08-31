import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart' as syspaths;
import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart' as sql;
import 'package:sqflite/sqlite_api.dart';
import 'package:virtual_diary/models/diary.dart';

Future<Database> _getDatabase() async {
  final dbPath = await sql.getDatabasesPath();
  final db = await sql.openDatabase(
    path.join(dbPath, 'diaries.db'),
    onCreate: (db, version) {
      return db.execute(
          'CREATE TABLE user_diaries(id TEXT PRIMARY KEY, title TEXT, desc TEXT, mood TEXT,img TEXT,date TEXT)');
    },
    version: 1,
  );
  return db;
}

class DiariesNotifier extends StateNotifier<List<Diary>> {
  DiariesNotifier() : super([]);

  Future<void> deleteDiary(String diaryId) async {
    final db = await _getDatabase();
    await db.delete('user_diaries', where: 'id = ?', whereArgs: [diaryId]);

    state = state.where((diary) => diary.id != diaryId).toList();
  }

  Future<void> loadDiaries() async {
    final db = await _getDatabase();
    final data = await db.query('user_diaries');
    final diaries = data
        .map(
          (row) => Diary(
            id: row['id'] as String,
            title: row['title'] as String,
            desc: row['desc'] as String,
            mood: Mood.values
                .firstWhere((mood) => mood.toString() == row['mood']),
            img: File(row['img'] as String),
            date: row['date'] as String,
          ),
        )
        .toList();
    state = diaries;
  }

  void addDiary(Diary diary) async {
    final appDir = await syspaths.getApplicationDocumentsDirectory();
    final filename = path.basename(diary.img.path);
    final copiedImage = await diary.img.copy('${appDir.path}/$filename');

    final db = await _getDatabase();
    db.insert('user_diaries', {
      'id': diary.id,
      'title': diary.title,
      'desc': diary.desc,
      'mood': diary.mood.toString(),
      'img': copiedImage.path,
      'date': diary.date,
    });
    state = [...state, diary];
  }
}

final diaresProvider = StateNotifierProvider<DiariesNotifier, List<Diary>>(
  (ref) => DiariesNotifier(),
);
