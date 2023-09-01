import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:virtual_diary/providers/user_diaries.dart';
import 'package:virtual_diary/widgets/diary_item.dart';

class CalendarScreen extends ConsumerStatefulWidget {
  const CalendarScreen({super.key});

  @override
  ConsumerState<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends ConsumerState<CalendarScreen> {
  final DateTime _now = DateTime.now();
  DateTime _today = DateTime.now();

  void _onDaySelected(DateTime day, DateTime focusedDay) {
    setState(() {
      _today = day;
    });
  }

  @override
  Widget build(BuildContext context) {
    final firstDate = DateTime(_now.year - 3, _now.month, _now.day);
    final lastDate = DateTime(_now.year, _now.month + 3, _now.day);
    final diariesList = ref.watch(diaresProvider);
    int maxSeries = 0;
    int actualSeries = 0;
    int maxCurrent = 1;
    int actualCurrent = 1;
    List<DateTime> dots = [];

    void addDot(DateTime dotDate) {
      dots.add(dotDate);
    }

    bool hasDot(DateTime date) {
      return dots.any((dot) => isSameDay(dot, date));
    }

    if (diariesList.isNotEmpty) {
      if (diariesList.length == 1) {
        actualSeries = 1;
        maxSeries = 1;
      }

      diariesList.sort((a, b) => a.date.compareTo(b.date));

      for (var diary in diariesList) {
        addDot(DateTime.parse(diary.date));
      }

      for (var i = 0; i < dots.length - 1; i++) {
        if (dots[i].day + 1 == dots[i + 1].day ||
            dots[i].day == 31 && dots[i + 1].day == 1 ||
            dots[i].day == 30 && dots[i + 1].day == 1 ||
            dots[i].month == 2 && dots[i].day == 29 && dots[i + 1].day == 1 ||
            dots[i].month == 2 && dots[i].day == 28 && dots[i + 1].day == 1) {
          maxCurrent += 1;
        } else {
          maxCurrent = 1;
        }
        maxSeries < maxCurrent ? maxSeries = maxCurrent : null;
      }

      for (var i = dots.length - 1; i > 0; i--) {
        if (dots[i].day - 1 == dots[i - 1].day ||
            dots[i].day == 1 && dots[i - 1].day == 31 ||
            dots[i].day == 1 && dots[i - 1].day == 30 ||
            dots[i].day == 1 &&
                dots[i - 1].day == 29 &&
                dots[i - 1].month == 2 ||
            dots[i].day == 1 &&
                dots[i - 1].day == 28 &&
                dots[i - 1].month == 2) {
          actualCurrent += 1;
        } else {
          break;
        }
        actualSeries < actualCurrent ? actualSeries = actualCurrent : null;
      }
    }

    return Container(
      color: Theme.of(context).colorScheme.background,
      child: SingleChildScrollView(
        child: Column(
          children: [
            TableCalendar(
              locale: 'en-US',
              rowHeight: 45,
              calendarStyle: CalendarStyle(
                  selectedDecoration: BoxDecoration(
                    color: Theme.of(context)
                        .colorScheme
                        .surfaceTint
                        .withOpacity(0.7),
                    shape: BoxShape.circle,
                  ),
                  todayDecoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surfaceVariant,
                    shape: BoxShape.circle,
                  ),
                  todayTextStyle: TextStyle(
                    color: Theme.of(context).colorScheme.surfaceTint,
                  )),
              headerStyle: const HeaderStyle(
                  formatButtonVisible: false, titleCentered: true),
              availableGestures: AvailableGestures.all,
              selectedDayPredicate: (day) => isSameDay(day, _today),
              focusedDay: _today,
              firstDay: firstDate,
              lastDay: lastDate,
              onDaySelected: _onDaySelected,
              currentDay: _now,
              calendarBuilders: CalendarBuilders(
                markerBuilder: (context, day, events) {
                  if (hasDot(day)) {
                    return Positioned(
                      bottom: 0,
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        width: 6,
                        height: 6,
                      ),
                    );
                  } else {
                    return const SizedBox.shrink();
                  }
                },
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Text(
              'Days streak: $actualSeries',
              style: TextStyle(
                color: Theme.of(context).colorScheme.surfaceTint,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              'Longest streak: $maxSeries',
              style: TextStyle(
                color: Theme.of(context).colorScheme.surfaceTint,
                fontSize: 24,
              ),
            ),
            if (hasDot(_today))
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: DiaryItem(
                    diary: diariesList
                        .where((diary) =>
                            diary.date == _today.toString().split(" ")[0])
                        .first),
              ),
          ],
        ),
      ),
    );
  }
}
