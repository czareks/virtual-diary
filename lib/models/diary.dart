import 'dart:io';
import 'package:intl/intl.dart';

// final formatter = DateFormat.yMd();
final formatter = DateFormat('yyyy-MM-dd');

enum Mood {
  happy,
  sad,
  tired,
  angry,
  inlove,
  cute,
  hungry,
  excited,
  calm,
}

const moodEmoticons = {
  Mood.happy: '😄',
  Mood.sad: '😢',
  Mood.tired: '😴',
  Mood.angry: '😡',
  Mood.inlove: '❤️',
  Mood.cute: '🥰',
  Mood.hungry: '🍔',
  Mood.excited: '🎉',
  Mood.calm: '😌',
};

class Diary {
  const Diary({
    required this.title,
    required this.desc,
    required this.mood,
    required this.img,
    required this.date,
    required this.id,
  });

  final String id;
  final String title;
  final String desc;
  final Mood mood;
  final File img;
  final String date;
}
