import 'package:virtual_diary/models/diary.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FiltersNotifier extends StateNotifier<Map<Mood, bool>> {
  FiltersNotifier()
      : super({
          Mood.happy: false,
          Mood.sad: false,
          Mood.tired: false,
          Mood.angry: false,
          Mood.inlove: false,
          Mood.cute: false,
          Mood.hungry: false,
          Mood.excited: false,
          Mood.calm: false,
        });

  void setFilters(Map<Mood, bool> chosenFilters) {
    state = chosenFilters;
  }

  void setFilter(Mood mood, bool isActive) {
    state = {
      ...state,
      mood: isActive,
    };
  }
}

final filtersProvider = StateNotifierProvider<FiltersNotifier, Map<Mood, bool>>(
  (ref) => FiltersNotifier(),
);
