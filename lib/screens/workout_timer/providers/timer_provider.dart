import 'dart:io';

import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:renew/common/constants.dart';
import 'package:renew/screens/workout_interval_settings/providers/workout_timer_data.dart';

final workoutTimer = StateNotifierProvider<WorkoutTimerController>((ref) {
  final int sets = ref.watch(workoutSets.state);

  final int wSec = ref.watch(workoutSeconds.state);

  final int wbSec = ref.watch(workoutBreakSeconds.state);

  return WorkoutTimerController(
    Duration(
      seconds: wSec,
    ),
    Duration(
      seconds: wbSec,
    ),
    sets,
  );
});

class WorkoutTimerController extends StateNotifier<Duration> {
  WorkoutTimerController(
    this._workoutDuration,
    this._breakDuration,
    this._sets,
  ) : super(_workoutDuration);

  final Duration _workoutDuration;
  final Duration _breakDuration;

  final AudioCache _audioCache = AudioCache();
  final AudioPlayer _audioPlayer = AudioPlayer(mode: PlayerMode.LOW_LATENCY);

  AudioCache audioCache = AudioCache();

  _playLocal(double volume) async {
    audioCache.load('sounds/workout.wav');
    audioCache.play('sounds/workout.wav',
        mode: PlayerMode.LOW_LATENCY, volume: volume);
  }

  int _baseSeconds = 1;
  int _sets;

  TIMER_STATES _timerState = TIMER_STATES.NOT_STARTED;
  CURRENT_TIMER _currentTimer = CURRENT_TIMER.FOCUS;

  TIMER_STATES getTimerState() => _timerState;
  CURRENT_TIMER getTimerType() => _currentTimer;

  int getBaseSeconds() => _baseSeconds;
  int getSets() => _sets;

  void reset() {
    _baseSeconds =
        Hive.box('userPreferences').get('workoutSeconds', defaultValue: 30);

    int sets = Hive.box('userPreferences').get('workoutSets', defaultValue: 1);
    _sets = sets;

    state = _workoutDuration;
    _timerState = TIMER_STATES.NOT_STARTED;
    _currentTimer = CURRENT_TIMER.FOCUS;
  }

  void toggleState() {
    if (_timerState == TIMER_STATES.NOT_STARTED && _sets > 0) {
      _baseSeconds = state.inSeconds;
      _timerState = TIMER_STATES.RUNNING;
    } else if (_timerState == TIMER_STATES.PAUSED && _sets > 0) {
      _timerState = TIMER_STATES.RUNNING;
    } else {
      _timerState = TIMER_STATES.PAUSED;
    }
  }

  void _toggleType() {
    if (_currentTimer == CURRENT_TIMER.FOCUS) {
      _sets = _sets - 1;
      if (_sets == 0) {
        _timerState = TIMER_STATES.ENDED;
      } else {
        _currentTimer = CURRENT_TIMER.BREAK;
        _baseSeconds = _breakDuration.inSeconds;
      }
      state = _breakDuration;
    } else {
      _currentTimer = CURRENT_TIMER.FOCUS;
      _baseSeconds = _workoutDuration.inSeconds;

      state = _workoutDuration;
    }
  }

  tick() {
    if (state.inSeconds == 0 && _sets != 0) {
      _toggleType();
    } else {
      if (state.inSeconds <= 4) {
        if (state.inSeconds == 1) {
          _playLocal(1);
        } else {
          _playLocal(.4);
        }
      }
      state = Duration(seconds: state.inSeconds - 1);
    }
  }

  DateTime minimezedOn = DateTime.now();
  moveToBackground() {
    minimezedOn = DateTime.now();
    print('minized $minimezedOn');
  }

  moveToForeground() {
    int currentMS = DateTime.now().millisecondsSinceEpoch;
    int minimizedOnMS = minimezedOn.millisecondsSinceEpoch;
    int diff = currentMS - minimizedOnMS;

    state = Duration(milliseconds: state.inMilliseconds - diff);
  }

  Stream<Duration> watchTimerStream() {
    return Stream<Duration>.periodic(Duration(seconds: 1), (count) {
      if (_timerState == TIMER_STATES.RUNNING) {
        tick();
      }
      return state;
    });
  }
}

final workoutTimerStream = StreamProvider.autoDispose<Duration>((ref) {
  return ref.watch(workoutTimer).watchTimerStream();
});
