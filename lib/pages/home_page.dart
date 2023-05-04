import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_habit_tracker/widgets/habit_tile.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'add_habit_view.dart';

import '../main.dart';
import '../models/habit_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        title: const Text(
          "Habit Tracker",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: ValueListenableBuilder<Box<Habit>>(
        valueListenable: Hive.box<Habit>('habits').listenable(),
        builder: (context, value, child) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Today's Habits",
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                Text(
                  formatDate(DateTime.now(), [d, ", ", MM, " ", yyyy]),
                  style: TextStyle(
                    color: Colors.grey.shade700,
                    fontSize: 18.0,
                  ),
                ),
                Divider(
                  height: 40.0,
                  thickness: 1.0,
                ),
                Expanded(
                  child: ListView.builder(
                      itemCount: box.values.length,
                      itemBuilder: (context, index) {
                        Habit currentHabit = box.getAt(index);
                        return HabitTile(
                          habit: currentHabit,
                        );
                      }),
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: ((context) => AddHabitView())));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
