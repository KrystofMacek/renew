import 'package:hive/hive.dart';

part 'task.g.dart';

@HiveType(typeId: 0)
class Task extends HiveObject {
  Task(this.name, this.isChecked);

  @HiveField(0)
  String name;
  @HiveField(1)
  bool isChecked;

  toggle() => isChecked = !isChecked;
}
