import 'dart:io';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:virtual_diary/models/diary.dart';
import 'package:virtual_diary/widgets/mood_btn.dart';
import 'package:image_picker/image_picker.dart';
import 'package:virtual_diary/providers/user_diaries.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddDiaryForm extends ConsumerStatefulWidget {
  const AddDiaryForm({super.key});

  @override
  ConsumerState<AddDiaryForm> createState() => _AddDiaryFormState();
}

class _AddDiaryFormState extends ConsumerState<AddDiaryForm> {
  final _formKey = GlobalKey<FormState>();
  Mood selectedMood = Mood.happy;
  bool isMoodSelected(Mood mood) => mood == selectedMood;

  var _enteredTitle = '';
  var _enteredDesc = '';
  File? _selectedImg;
  DateTime? _selectedDate;

  void _saveDiary() async {
    if (_selectedDate == null || _selectedImg == null) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Invalid date and photo'),
          content: const Text('Please make sure a valid date and had photo'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(ctx);
              },
              child: const Text('Okay'),
            ),
          ],
        ),
      );
    }

    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      Diary newDiary = Diary(
          id: const Uuid().v4(),
          title: _enteredTitle,
          desc: _enteredDesc,
          mood: selectedMood,
          img: _selectedImg!,
          date: formatter.format(_selectedDate!));
      ref.watch(diaresProvider.notifier).addDiary(newDiary);
      Navigator.of(context).pop();
    }
  }

  void _takePictureFromCamera() async {
    final imagePicker = ImagePicker();
    final pickedImage =
        await imagePicker.pickImage(source: ImageSource.camera, maxWidth: 600);
    if (pickedImage == null) {
      return;
    }
    setState(() {
      _selectedImg = File(pickedImage.path);
    });
  }

  void _takePictureFromGallery() async {
    final imagePicker = ImagePicker();
    final pickedImage =
        await imagePicker.pickImage(source: ImageSource.gallery, maxWidth: 600);
    if (pickedImage == null) {
      return;
    }
    setState(() {
      _selectedImg = File(pickedImage.path);
    });
  }

  void _presentDatePicker() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month, now.day);
    final lastDate = DateTime(now.year, now.month, now.day);
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: firstDate,
      lastDate: lastDate,
    );
    setState(() {
      _selectedDate = pickedDate;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextFormField(
                maxLength: 50,
                decoration: const InputDecoration(
                  label: Text('Title'),
                ),
                validator: (value) {
                  if (value == null ||
                      value.isEmpty ||
                      value.trim().length <= 1 ||
                      value.trim().length > 50) {
                    return 'Must be between 2 and 50 characters';
                  }
                  return null;
                },
                onSaved: (newValue) {
                  _enteredTitle = newValue!;
                },
              ),
              TextFormField(
                maxLength: 1500,
                maxLines: null,
                decoration: const InputDecoration(
                  label: Text('Description'),
                ),
                validator: (value) {
                  if (value == null ||
                      value.isEmpty ||
                      value.trim().length <= 1 ||
                      value.trim().length > 1500) {
                    return 'Must be between 2 and 1500 characters';
                  }
                  return null;
                },
                onSaved: (newValue) {
                  _enteredDesc = newValue!;
                },
              ),
              const SizedBox(
                height: 15,
              ),
              const Text('Choose your mood'),
              const SizedBox(
                height: 15,
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    for (var mood in Mood.values)
                      MoodBtn(
                        isSelected: isMoodSelected(mood),
                        mood: mood,
                        onPressed: () {
                          setState(() {
                            selectedMood = mood;
                          });
                        },
                      ),
                  ],
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 1,
                    color:
                        Theme.of(context).colorScheme.primary.withOpacity(0.2),
                  ),
                ),
                height: 250,
                width: double.infinity,
                alignment: Alignment.center,
                child: _selectedImg == null
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          ElevatedButton.icon(
                            onPressed: _takePictureFromCamera,
                            icon: const Icon(Icons.camera_alt),
                            label: const Text('Make photo'),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Text(
                            'OR',
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.surfaceTint,
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          ElevatedButton.icon(
                            onPressed: _takePictureFromGallery,
                            icon: const Icon(Icons.photo),
                            label: const Text('Add photo'),
                          ),
                        ],
                      )
                    : Image.file(
                        _selectedImg!,
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: double.infinity,
                      ),
              ),
              const SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    _selectedDate == null
                        ? 'No date selected'
                        : formatter.format(_selectedDate!),
                  ),
                  IconButton(
                    onPressed: _presentDatePicker,
                    icon: const Icon(Icons.calendar_month),
                  ),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              ElevatedButton.icon(
                onPressed: _saveDiary,
                icon: const Icon(Icons.add),
                label: const Text('Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
