import 'package:flutter/material.dart';
import 'package:virtual_diary/models/diary.dart';
import 'package:virtual_diary/screens/diary.dart';

class DiaryItem extends StatelessWidget {
  const DiaryItem({super.key, required this.diary});
  final Diary diary;

  void selectDiary(BuildContext context, Diary diary) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => DiaryScreen(
          diary: diary,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        selectDiary(context, diary);
      },
      splashColor: Theme.of(context).colorScheme.primary,
      borderRadius: BorderRadius.circular(16),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Stack(children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.file(
              diary.img,
              fit: BoxFit.cover,
              height: 200,
              width: double.infinity,
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                ),
                color: Colors.black.withOpacity(0.5),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    diary.title,
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.background),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Text(moodEmoticons[diary.mood]!),
                  const SizedBox(
                    width: 20,
                  ),
                  Text(
                    diary.date,
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.background),
                  ),
                ],
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
