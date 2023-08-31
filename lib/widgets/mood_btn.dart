import 'package:flutter/material.dart';
import 'package:virtual_diary/models/diary.dart';

class MoodBtn extends StatefulWidget {
  const MoodBtn({
    super.key,
    required this.isSelected,
    required this.mood,
    required this.onPressed,
  });

  final Mood mood;
  final bool isSelected;
  final VoidCallback onPressed;

  @override
  State<MoodBtn> createState() => _MoodBtnState();
}

class _MoodBtnState extends State<MoodBtn> {
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: widget.onPressed,
      style: ButtonStyle(
        padding: MaterialStateProperty.all(
          const EdgeInsets.symmetric(vertical: 12, horizontal: 18.5),
        ),
        backgroundColor: MaterialStateProperty.all(
          widget.isSelected
              ? Theme.of(context).colorScheme.secondaryContainer
              : Colors.transparent,
        ),
      ),
      child: Text(
        moodEmoticons[widget.mood] ?? '',
        style: const TextStyle(fontSize: 24),
      ),
    );
  }
}
