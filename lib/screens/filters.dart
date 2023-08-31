import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:virtual_diary/models/diary.dart';
import 'package:virtual_diary/widgets/filter_switch.dart';

class FiltersScreen extends ConsumerStatefulWidget {
  const FiltersScreen({super.key});

  @override
  ConsumerState<FiltersScreen> createState() {
    return _FiltersScreenState();
  }
}

class _FiltersScreenState extends ConsumerState<FiltersScreen> {
  @override
  Widget build(BuildContext context) {
    List<Widget> filterWidgets = Mood.values.map((mood) {
      return FilterSwitch(
        title: mood.name.toString(),
        desc: 'Only include ${mood.name.toString()} diaries',
        mood: mood,
      );
    }).toList();

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        iconTheme:
            IconThemeData(color: Theme.of(context).colorScheme.onPrimary),
        title: Text(
          'Filters',
          style: TextStyle(
            color: Theme.of(context).colorScheme.onPrimary,
          ),
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: ListView(
        children: filterWidgets,
      ),
    );
  }
}
