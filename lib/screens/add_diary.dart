import 'package:flutter/material.dart';
import 'package:virtual_diary/widgets/add_diary_form.dart';

class AddDiaryScreen extends StatelessWidget {
  const AddDiaryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
        title: Text(
          'Add new diary',
          style: TextStyle(
            color: Theme.of(context).colorScheme.onPrimary,
          ),
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: const AddDiaryForm(),
    );
  }
}
