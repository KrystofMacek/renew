import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:renew/data/task.dart';
import 'package:hive/hive.dart';

final tasksListProvider = StateNotifierProvider<TasksList>((ref) {
  return TasksList(
    ref.watch(selectedTaskListProvider),
  );
});

class TasksList extends StateNotifier<List<Task>> {
  TasksList(this._selectedTaskListProvider)
      : super(List<Task>.from(Hive.box('userPreferences')
            .get('fullTaskList', defaultValue: <Task>[]).cast<Task>()));

  final SelectedTasksList _selectedTaskListProvider;

  void add(String name) {
    Task newTask = Task(name, true);
    state.add(newTask);

    Hive.box('userPreferences').put('fullTaskList', state);
    state = state;
  }

  void toggleTask(int index) {
    state[index].toggle();
    Hive.box('userPreferences').put('fullTaskList', state);
    state = state;
  }

  void remove(int index) {
    state.removeAt(index);
    Hive.box('userPreferences').put('fullTaskList', state);
    state = state;
  }

  void initSelectedList() {
    state.forEach((element) {
      if (element.isChecked) {
        _selectedTaskListProvider.add(Task(element.name, false));
      }
    });
  }
}

final selectedTaskListProvider =
    StateNotifierProvider<SelectedTasksList>((ref) {
  return SelectedTasksList();
});

class SelectedTasksList extends StateNotifier<List<Task>> {
  SelectedTasksList() : super(<Task>[]);

  void add(Task task) {
    state.add(task);
    state = state;
  }

  void remove(int index) {
    state.removeAt(index);
    state = state;
  }

  void clear() {
    state = <Task>[];
  }

  void toggleTask(int index) {
    state[index].toggle();
    state = state;
  }
}
