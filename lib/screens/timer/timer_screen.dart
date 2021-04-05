import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:renew/common/constants.dart';
import 'package:renew/common/providers/current_timer.dart';
import 'package:renew/common/styling.dart';

import 'package:renew/screens/tasks_settings/providers/tasks_provider.dart';

import 'package:renew/screens/timer/widgets/timer_widget_ui.dart';

class TimerScreen extends StatefulWidget {
  TimerScreen() : super(key: UniqueKey());

  @override
  _TimerScreenState createState() => _TimerScreenState();
}

class _TimerScreenState extends State<TimerScreen>
    with WidgetsBindingObserver, TickerProviderStateMixin {
  late FlutterLocalNotificationsPlugin _flutterNotifications;
  late AnimationController _animationController;

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      context.read(timerControllerProvider).moveToForeground();
    } else if (state == AppLifecycleState.paused) {
      context.read(timerControllerProvider).moveToBackground();
    }
    super.didChangeAppLifecycleState(state);
  }

  @override
  void initState() {
    WidgetsBinding.instance?.addObserver(this);
    _animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 1));
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance?.addObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final TextTheme _textTheme = Theme.of(context).textTheme;
    final ThemeData _themeData = Theme.of(context);

    double size = MediaQuery.of(context).size.width * .8;
    double breakSize = size * .8;

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // save task list as last config
          Navigator.of(context).popUntil((route) => route.isFirst);
          context.read(timerControllerProvider).reset();
          context.read(timerControllerProvider).resetBaseTimes();

          context.read(selectedTaskListProvider).clear();
        },
        child: Icon(
          Icons.close,
          size: 30,
          color: _themeData.iconTheme.color,
        ),
      ),
      body: Consumer(
        builder: (context, watch, child) {
          TimerController _timerController = watch(timerControllerProvider);

          return Center(
            child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: watch(timerDurationStream).when(
                  data: (timerDuration) {
                    int breakSeconds = _timerController.baseBreakSeconds;
                    int focusSeconds = _timerController.baseFocusSeconds;

                    bool _isBreak =
                        _timerController.getTimerType() == CURRENT_TIMER.BREAK;

                    double timerValue;

                    if (!_isBreak) {
                      timerValue = (focusSeconds - timerDuration.inSeconds) /
                          focusSeconds;
                    } else {
                      timerValue = (breakSeconds - timerDuration.inSeconds) /
                          breakSeconds;
                    }

                    return TimerWidget(
                      timerController: _timerController,
                      textTheme: _textTheme,
                      size: size,
                      timerValue: timerValue,
                      animationController: _animationController,
                      timerDuration: timerDuration,
                      isBreak: _isBreak,
                    );
                  },
                  loading: () => SpinKitFadingCube(
                    color: accentColorYellow,
                  ),
                  error: (error, stackTrace) {
                    return Text('$error');
                  },
                )),
          );
        },
      ),
    );
  }
}
