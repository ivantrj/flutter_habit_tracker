import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_habit_tracker/pages/home_page.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'models/habit_model.dart';

late Box box;
void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter<Habit>(HabitAdapter());
  box = await Hive.openBox<Habit>('habits');
  box.add(Habit(
    title: 'Test Habit',
    description: 'Testing the habit',
    creationDate: DateTime.now(),
    done: false,
  ));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}
