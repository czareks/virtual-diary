import 'package:flutter/material.dart';
import 'package:virtual_diary/screens/filters.dart';

class DrawerSettings extends StatelessWidget {
  const DrawerSettings({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          DrawerHeader(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Theme.of(context).colorScheme.primaryContainer,
                  Theme.of(context)
                      .colorScheme
                      .primaryContainer
                      .withOpacity(0.8),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.collections_bookmark_rounded,
                  size: 48,
                  color: Theme.of(context).colorScheme.primary,
                ),
                const SizedBox(
                  width: 18,
                ),
                Text(
                  'Write a diary!',
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                ),
              ],
            ),
          ),
          ListTile(
            leading: Icon(
              Icons.menu_book_rounded,
              size: 26,
              color: Theme.of(context).colorScheme.onBackground,
            ),
            title: Text(
              'Diaries',
              style: Theme.of(context).textTheme.titleSmall!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground,
                    fontSize: 24,
                  ),
            ),
            onTap: () {
              Navigator.of(context).pop();
            },
          ),
          ListTile(
            leading: Icon(
              Icons.filter_list_rounded,
              size: 26,
              color: Theme.of(context).colorScheme.onBackground,
            ),
            title: Text(
              'Filters',
              style: Theme.of(context).textTheme.titleSmall!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground,
                    fontSize: 24,
                  ),
            ),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).push(
                MaterialPageRoute(builder: (ctx) => const FiltersScreen()),
              );
            },
          ),
          // ListTile(
          //   leading: Icon(
          //     Icons.settings,
          //     size: 26,
          //     color: Theme.of(context).colorScheme.onBackground,
          //   ),
          //   title: Text(
          //     'Settings',
          //     style: Theme.of(context).textTheme.titleSmall!.copyWith(
          //           color: Theme.of(context).colorScheme.onBackground,
          //           fontSize: 24,
          //         ),
          //   ),
          //   onTap: () {
          //     // onSelectScreen('filters');
          //   },
          // ),
        ],
      ),
    );
  }
}
