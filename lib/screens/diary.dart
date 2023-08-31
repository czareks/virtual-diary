import 'package:flutter/material.dart';
import 'package:virtual_diary/models/diary.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:virtual_diary/providers/user_diaries.dart';

class DiaryScreen extends ConsumerWidget {
  const DiaryScreen({super.key, required this.diary});

  final Diary diary;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    void deleteDiary(String diaryId) {
      ref.watch(diaresProvider.notifier).deleteDiary(diaryId);
      Navigator.of(context).pop();
    }

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
        title: Text(
          diary.title,
          style: TextStyle(
            color: Theme.of(context).colorScheme.onPrimary,
          ),
        ),
        actions: [
          IconButton(
            color: Theme.of(context).colorScheme.errorContainer,
            icon: const Icon(Icons.delete_forever),
            onPressed: () {
              deleteDiary(diary.id);
            },
          ),
        ],
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.file(diary.img),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Mood: ${moodEmoticons[diary.mood]}',
                        style: const TextStyle(fontSize: 18),
                      ),
                      const SizedBox(
                        width: 130,
                      ),
                      Text(
                        diary.date,
                        style: const TextStyle(fontSize: 18),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    textAlign: TextAlign.justify,
                    diary.desc,
                    style: const TextStyle(fontSize: 15),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
