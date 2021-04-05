import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:renew/common/constants.dart';

// final currentWorkoutWorkTimeProvider =
//     StateNotifierProvider<CurrentFocusTime>((ref) => CurrentFocusTime());

// class CurrentFocusTime extends StateNotifier<Duration> {
//   CurrentFocusTime()
//       : super(
//           Duration(
//             seconds: Hive.box('userPreferences')
//                 .get('workoutWork', defaultValue: 900),
//           ),
//         );

//   save() {
//     Hive.box('userPreferences').put('workoutWork', state.inSeconds);
//   }

//   update(Duration i) {
//     state = i;
//   }
// }

// final currentWorkoutBreakTimeProvider =
//     StateNotifierProvider<CurrentBreakTime>((ref) => CurrentBreakTime());

// class CurrentBreakTime extends StateNotifier<Duration> {
//   CurrentBreakTime()
//       : super(
//           Duration(
//             seconds: Hive.box('userPreferences')
//                 .get('workoutBreak', defaultValue: 300),
//           ),
//         );

//   save() {
//     Hive.box('userPreferences').put('workoutBreak', state.inSeconds);
//   }

//   update(Duration i) {
//     state = i;
//   }
// }

final workoutSeconds =
    StateNotifierProvider<WorkoutSeconds>((ref) => WorkoutSeconds());

class WorkoutSeconds extends StateNotifier<int> {
  WorkoutSeconds()
      : super(Hive.box('userPreferences')
            .get('workoutSeconds', defaultValue: 30));

  update(int i) {
    Hive.box('userPreferences').put('workoutSeconds', i);
    state = i;
  }
}

final workoutBreakSeconds =
    StateNotifierProvider<WorkoutBreakSeconds>((ref) => WorkoutBreakSeconds());

class WorkoutBreakSeconds extends StateNotifier<int> {
  WorkoutBreakSeconds()
      : super(Hive.box('userPreferences')
            .get('workoutBreakSeconds', defaultValue: 15));

  update(int i) {
    Hive.box('userPreferences').put('workoutBreakSeconds', i);
    state = i;
  }
}

final workoutSets = StateNotifierProvider<WorkoutSets>((ref) => WorkoutSets());

class WorkoutSets extends StateNotifier<int> {
  WorkoutSets()
      : super(Hive.box('userPreferences').get('workoutSets', defaultValue: 2));

  update(int i) {
    Hive.box('userPreferences').put('workoutSets', i);
    state = i;
  }
}
