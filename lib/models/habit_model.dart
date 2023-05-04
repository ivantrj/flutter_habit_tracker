import 'package:hive/hive.dart';

part 'habit_model.g.dart';

@HiveType(typeId: 0)
class Habit {
  @HiveField(0)
  String title;
  @HiveField(1)
  String? description;
  @HiveField(2)
  DateTime? creationDate;
  @HiveField(3)
  bool? done;

  Habit({required this.title, this.description, this.creationDate, this.done});
}
