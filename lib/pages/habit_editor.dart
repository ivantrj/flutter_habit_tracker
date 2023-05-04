// ignore_for_file: unnecessary_import, implementation_imports, unused_import

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:hive/hive.dart';

import '../models/habit_model.dart';
import 'home_page.dart';

class HabitEditor extends StatefulWidget {
  final Habit? habit;

  const HabitEditor({this.habit, super.key});

  @override
  State<HabitEditor> createState() => _HabitEditorState();
}

class _HabitEditorState extends State<HabitEditor> {
  @override
  Widget build(BuildContext context) {
    TextEditingController habitTitle = TextEditingController(
        text: widget.habit != null ? widget.habit!.title : null);
    TextEditingController habitDescription = TextEditingController(
        text: widget.habit != null ? widget.habit!.description : null);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black87),
        title: Text(
          widget.habit == null ? "Add a new habit" : "Edit habit",
          style: const TextStyle(color: Colors.black),
        ),
        elevation: 0.0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Habit Title",
              style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 12.0,
            ),
            TextField(
              controller: habitTitle,
              decoration: InputDecoration(
                fillColor: Colors.blue.shade100.withAlpha(75),
                filled: true,
                hintText: "Enter habit title",
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
            const SizedBox(
              height: 12.0,
            ),
            TextField(
              controller: habitDescription,
              keyboardType: TextInputType.multiline,
              minLines: 5,
              maxLines: 25,
              decoration: InputDecoration(
                fillColor: Colors.blue.shade100.withAlpha(75),
                filled: true,
                hintText: "Enter habit description (optional)",
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
            Expanded(
              child: Align(
                alignment: FractionalOffset.bottomCenter,
                child: SizedBox(
                  width: double.infinity,
                  height: 60.0,
                  child: ElevatedButton(
                    onPressed: () {
                      var newHabit = Habit(
                        title: habitTitle.text,
                        description: habitDescription.text,
                        creationDate: DateTime.now(),
                        done: false,
                      );
                      Box<Habit> habitsBox = Hive.box<Habit>("habits");
                      if (widget.habit != null) {
                        widget.habit!.title = habitTitle.text;
                        widget.habit!.description = habitDescription.text;
                        widget.habit!.creationDate = DateTime.now();
                        widget.habit!.done = false;
                        widget.habit!.save();
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const HomePage()));
                      } else {
                        habitsBox.add(newHabit);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const HomePage()));
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue.shade200,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    child: Text(
                      widget.habit == null ? "Add Habit" : "Edit Habit",
                      style: const TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
