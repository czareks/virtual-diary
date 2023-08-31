import 'package:flutter/material.dart';
import 'package:virtual_diary/models/diary.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:virtual_diary/providers/filters_provider.dart';

class FilterSwitch extends ConsumerWidget {
  const FilterSwitch({
    super.key,
    required this.mood,
    required this.title,
    required this.desc,
  });

  final Mood mood;
  final String title;
  final String desc;

  String capitalize(title) {
    return "${title[0].toUpperCase()}${title.substring(1)}";
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activeFilters = ref.watch(filtersProvider);

    return SwitchListTile(
      value: activeFilters[mood]!,
      onChanged: (isChecked) {
        ref.read(filtersProvider.notifier).setFilter(mood, isChecked);
      },
      title: Text(
        capitalize(title),
        style: Theme.of(context).textTheme.titleLarge!.copyWith(
              color: Theme.of(context).colorScheme.onBackground,
            ),
      ),
      subtitle: Text(
        desc,
        style: Theme.of(context).textTheme.labelMedium!.copyWith(
              color: Theme.of(context).colorScheme.onBackground,
            ),
      ),
      activeColor: Theme.of(context).colorScheme.tertiary,
      contentPadding: const EdgeInsets.only(
        left: 34,
        right: 22,
      ),
    );
  }
}
