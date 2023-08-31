import 'package:flutter/material.dart';
import 'package:virtual_diary/models/diary.dart';
import 'package:virtual_diary/providers/filters_provider.dart';
import 'package:virtual_diary/widgets/diary_item.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:virtual_diary/providers/user_diaries.dart';

class DiariesList extends ConsumerStatefulWidget {
  const DiariesList({
    super.key,
    required this.sortBydate,
  });

  final bool sortBydate;

  @override
  ConsumerState<DiariesList> createState() => _DiariesListState();
}

class _DiariesListState extends ConsumerState<DiariesList> {
  late Future<void> _diariesFuture;

  @override
  void initState() {
    super.initState();
    _diariesFuture = ref.read(diaresProvider.notifier).loadDiaries();
  }

  @override
  Widget build(BuildContext context) {
    final diariesList = ref.watch(diaresProvider);
    final List<Diary> filteredDiaries = [];

    final filters = ref.watch(filtersProvider);

    if (filters.containsValue(true)) {
      for (var i = 0; i < diariesList.length; i++) {
        if (filters[diariesList[i].mood]!) {
          filteredDiaries.add(diariesList[i]);
        }
      }
    } else {
      filteredDiaries.addAll(diariesList);
    }

    if (widget.sortBydate) {
      filteredDiaries.sort((a, b) => b.date.compareTo(a.date));
    } else {
      filteredDiaries.sort((a, b) => a.date.compareTo(b.date));
    }

    return Padding(
      padding: const EdgeInsets.all(10),
      child: FutureBuilder(
        future: _diariesFuture,
        builder: (context, snapshot) =>
            snapshot.connectionState == ConnectionState.waiting
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : ListView.builder(
                    itemCount: filteredDiaries.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: DiaryItem(
                          diary: filteredDiaries[index],
                        ),
                      );
                    },
                  ),
      ),
    );
  }
}
