import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:renew/common/constants.dart';
import 'package:renew/screens/timer/providers/notifications_provider.dart';
import 'package:hive/hive.dart';

final currentFocusTimeProvider =
    StateNotifierProvider<CurrentFocusTime>((ref) => CurrentFocusTime());

class CurrentFocusTime extends StateNotifier<int> {
  CurrentFocusTime()
      : super(
          Hive.box('userPreferences').get('intervalFocus', defaultValue: 45),
        );

  update(int i) {
    state = i;
    Hive.box('userPreferences').put('intervalFocus', i);
  }
}

final currentBreakTimeProvider =
    StateNotifierProvider<CurrentBreakTime>((ref) => CurrentBreakTime());

class CurrentBreakTime extends StateNotifier<int> {
  CurrentBreakTime()
      : super(
          Hive.box('userPreferences').get('intervalBreak', defaultValue: 10),
        );

  update(int i) {
    state = i;
    Hive.box('userPreferences').put('intervalBreak', i);
  }
}

final timerControllerProvider = StateNotifierProvider<TimerController>(
  (ref) => TimerController(
    ref.watch(currentBreakTimeProvider.state),
    ref.watch(currentFocusTimeProvider.state),
    ref.watch(notificationProvider),
  ),
);

class TimerController extends StateNotifier<Duration> {
  TimerController(
    this._currentBreakTime,
    this._currentFocusTime,
    this._notificationProvider,
  )   : baseBreakSeconds = _currentBreakTime * 60,
        baseFocusSeconds = _currentFocusTime * 60,
        super(Duration(minutes: _currentFocusTime));

  final int _currentBreakTime;
  final int _currentFocusTime;
  final NotificationProvider _notificationProvider;

  TIMER_STATES timerState = TIMER_STATES.PAUSED;
  CURRENT_TIMER currentTimer = CURRENT_TIMER.FOCUS;

  TIMER_STATES getTimerState() => timerState;
  CURRENT_TIMER getTimerType() => currentTimer;

  int baseBreakSeconds;
  int baseFocusSeconds;

  setNewTimer(Duration duration) {
    state = duration;
  }

  reset() {
    state = Duration(minutes: _currentFocusTime);
    timerState = TIMER_STATES.PAUSED;
    currentTimer = CURRENT_TIMER.FOCUS;
  }

  resetBaseTimes() {
    baseBreakSeconds = _currentBreakTime * 60;
    baseFocusSeconds = _currentFocusTime * 60;
  }

  addToATimer(Duration duration) {
    Duration newDuration =
        Duration(seconds: state.inSeconds + duration.inSeconds);

    if (newDuration.inSeconds > 0) {
      state = newDuration;
      if (newDuration.inSeconds > baseFocusSeconds &&
          currentTimer == CURRENT_TIMER.FOCUS) {
        baseFocusSeconds = newDuration.inSeconds;
      }
      if (newDuration.inSeconds > baseBreakSeconds &&
          currentTimer == CURRENT_TIMER.BREAK) {
        baseBreakSeconds = newDuration.inSeconds;
      }

      if (timerState == TIMER_STATES.RUNNING) scheduleNotification(true);
    } else {
      state = Duration(milliseconds: 500);
      if (timerState == TIMER_STATES.RUNNING) scheduleNotification(true);
    }
  }

  tick() {
    state = Duration(seconds: state.inSeconds - 1);
    if (state.inSeconds < 1) {
      timerState = TIMER_STATES.PAUSED;
    }
  }

  startBreak() {
    updateCurrentTimerType(CURRENT_TIMER.BREAK);
    baseFocusSeconds = _currentFocusTime * 60;
    setNewTimer(Duration(minutes: _currentBreakTime));
  }

  startFocus() {
    updateCurrentTimerType(CURRENT_TIMER.FOCUS);
    baseBreakSeconds = _currentBreakTime * 60;
    setNewTimer(Duration(minutes: _currentFocusTime));
  }

  scheduleNotification(bool isReschedule) {
    // set notification "duration" time into the future.

    String title = '';
    String body = '';
    if (currentTimer == CURRENT_TIMER.FOCUS) {
      title = 'Focus Time is Over';
      body = 'Good Job! 👍, time to Renew.';
    } else {
      title = 'Break Time is Over';
      body = 'Are you Renewed? Good, let\'s focus again!. 🚀';
    }
    _notificationProvider.scheduleNotification(
      state,
      title,
      body,
      DateTime.now(),
      isReschedule,
    );
  }

  updateCurrentTimerType(CURRENT_TIMER type) => currentTimer = type;

  pauseTimer() {
    timerState = TIMER_STATES.PAUSED;
    _notificationProvider.cancelNotification();
  }

  resumeTimer() {
    timerState = TIMER_STATES.RUNNING;
    scheduleNotification(false);
  }

  DateTime minimezedOn = DateTime.now();
  moveToBackground() {
    minimezedOn = DateTime.now();
    print('minized $minimezedOn');
    print('minized timer $state');
  }

  moveToForeground() {
    print('maximized ${DateTime.now()}');
    int currentMS = DateTime.now().millisecondsSinceEpoch;
    print('current MS = $currentMS');
    int minimizedOnMS = minimezedOn.millisecondsSinceEpoch;
    print('minimizedOn MS = $minimizedOnMS');
    int diff = currentMS - minimizedOnMS;

    print('diff MS = $diff');

    Duration updatedTimer = Duration(milliseconds: state.inMilliseconds);
    print('updatedTimer = $updatedTimer');
    // state = updatedTimer;
  }

  Stream<Duration> watchTimerStream() {
    return Stream<Duration>.periodic(Duration(seconds: 1), (count) {
      if (timerState == TIMER_STATES.RUNNING) {
        tick();
      }
      return state;
    });
  }
}

final timerDurationStream = StreamProvider.autoDispose<Duration>((ref) {
  return ref.watch(timerControllerProvider).watchTimerStream();
});
