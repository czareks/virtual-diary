import 'package:flutter/material.dart';
import 'package:virtual_diary/screens/add_diary.dart';
import 'package:virtual_diary/screens/calendar.dart';
import 'package:virtual_diary/widgets/diaries_list.dart';
import 'package:virtual_diary/widgets/drawer_settings.dart';

class NavigationScreen extends StatefulWidget {
  const NavigationScreen({Key? key}) : super(key: key);

  @override
  State<NavigationScreen> createState() {
    return _NavigationState();
  }
}

class _NavigationState extends State<NavigationScreen> {
  int _selectedPageIndex = 0;

  bool _sortByDate = true;
  Widget? content;
  int _actualIndex = 0;

  @override
  void initState() {
    super.initState();
    content = DiariesList(sortBydate: _sortByDate);
  }

  void _sortDate() {
    setState(() {
      _sortByDate = !_sortByDate;
      content = DiariesList(sortBydate: _sortByDate);
    });
  }

  void _changeScreen(int index) {
    setState(() {
      _selectedPageIndex = index;
    });

    if (_selectedPageIndex == 0) {
      content = DiariesList(sortBydate: _sortByDate);
      setState(() {
        _actualIndex = 0;
      });
    }
    if (_selectedPageIndex == 1) {
      content = const CalendarScreen();
      setState(() {
        _actualIndex = 1;
      });
    }
    if (_selectedPageIndex == 2) {
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => const AddDiaryScreen(),
      ));
      _selectedPageIndex = _actualIndex;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme:
            IconThemeData(color: Theme.of(context).colorScheme.onPrimary),
        centerTitle: true,
        title: Text(
          'Virtual Diary',
          style: TextStyle(
            color: Theme.of(context).colorScheme.onPrimary,
          ),
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
        actions: [
          _actualIndex == 0
              ? IconButton(
                  onPressed: _sortDate,
                  icon: Icon(_sortByDate ? Icons.south : Icons.north))
              : IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.calendar_today_rounded))
        ],
      ),
      drawer: Drawer(
        backgroundColor: Theme.of(context).colorScheme.onPrimary,
        child: const DrawerSettings(),
      ),
      body: content,
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.book_rounded,
            ),
            label: 'Diary',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.calendar_month_rounded,
            ),
            label: 'Calendar',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.bookmark_add,
            ),
            label: 'Add diary',
          ),
        ],
        selectedItemColor: const Color.fromARGB(255, 235, 201, 133),
        unselectedItemColor: Theme.of(context).colorScheme.onPrimary,
        onTap: _changeScreen,
        currentIndex: _selectedPageIndex,
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
    );
  }
}
