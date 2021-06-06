import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:native_admob_flutter/native_admob_flutter.dart';
import 'package:renew/common/constants.dart';
import 'package:renew/common/styling.dart';
import 'package:renew/common/widgets/timer_widget.dart';
import 'package:renew/screens/workout_timer/providers/timer_provider.dart';
import 'package:wakelock/wakelock.dart';

class WorkoutTimerScreen extends StatefulWidget {
  WorkoutTimerScreen() : super(key: UniqueKey());

  @override
  _WorkoutTimerScreenState createState() => _WorkoutTimerScreenState();
}

class _WorkoutTimerScreenState extends State<WorkoutTimerScreen>
    with WidgetsBindingObserver {
  late AudioCache audioCache;

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      context.read(workoutTimer).moveToForeground();
      Wakelock.enable();
    } else if (state == AppLifecycleState.paused) {
      context.read(workoutTimer).moveToBackground();
      Wakelock.disable();
    }
    super.didChangeAppLifecycleState(state);
  }

  @override
  void initState() {
    WidgetsBinding.instance?.addObserver(this);

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

    return Container(
      color: primaryBlue,
      child: SafeArea(
        bottom: false,
        child: Scaffold(
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              // save task list as last config
              context.read(workoutTimer).reset();
              Navigator.of(context).popUntil((route) => route.isFirst);
              Wakelock.disable();
            },
            child: Icon(
              Icons.close,
              size: 30,
              color: _themeData.iconTheme.color,
            ),
          ),
          body: Consumer(
            builder: (context, watch, child) {
              WorkoutTimerController _workoutTimerController =
                  watch(workoutTimer);

              return Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: watch(workoutTimerStream).when(
                    data: (remainingDuration) {
                      bool _isBreak = _workoutTimerController.getTimerType() ==
                          CURRENT_TIMER.BREAK;

                      bool _finished =
                          _workoutTimerController.getTimerState() ==
                              TIMER_STATES.ENDED;

                      int baseSeconds =
                          _workoutTimerController.getBaseSeconds();

                      double timerValue =
                          (baseSeconds - remainingDuration.inSeconds) /
                              baseSeconds;

                      if (!_finished) {
                        return Column(
                          children: [
                            NativeAd(
                              buildLayout: adBannerLayoutBuilder,
                              loading: SizedBox(height: 50),
                              error: SizedBox(height: 50),
                              height: 50,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            // Consumer(
                            //   builder: (context, watch, child) {
                            //     return watch(adBannerFutureProvider(6)).when(
                            //       data: (value) => value,
                            //       loading: () => SizedBox(
                            //         height: 50,
                            //       ),
                            //       error: (_, __) => SizedBox(
                            //         height: 50,
                            //       ),
                            //     );
                            //   },
                            // ),
                            Text(
                              _isBreak ? 'Break' : 'Workout',
                              style: _textTheme.headline2,
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            TimerUI(
                                size: size,
                                timerValue: timerValue,
                                timerDuration: remainingDuration,
                                textTheme: _textTheme),
                            const SizedBox(
                              height: 30,
                            ),
                            Material(
                              elevation: 2,
                              borderRadius: BorderRadius.circular(50),
                              color: colorWhiteBlue,
                              child: IconButton(
                                icon: Icon(
                                  _workoutTimerController.getTimerState() ==
                                          TIMER_STATES.RUNNING
                                      ? Icons.pause
                                      : Icons.play_arrow,
                                  size: 30,
                                  color: shadow,
                                ),
                                onPressed: () {
                                  context.read(workoutTimer).toggleState();
                                },
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Text(
                              '${_workoutTimerController.getSets()}',
                              style: _textTheme.headline2,
                              textAlign: TextAlign.center,
                            ),
                          ],
                        );
                      } else {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            NativeAd(
                              buildLayout: adBannerLayoutBuilder,
                              loading: SizedBox(height: 50),
                              error: SizedBox(height: 50),
                              height: 50,
                            ),
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text('GOOD JOB'),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Material(
                                    elevation: 2,
                                    borderRadius: BorderRadius.circular(50),
                                    color: colorWhiteBlue,
                                    child: IconButton(
                                      icon: Icon(
                                        Icons.replay,
                                        size: 30,
                                        color: shadow,
                                      ),
                                      onPressed: () {
                                        context.read(workoutTimer).reset();
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        );
                      }
                    },
                    loading: () => SpinKitFadingCube(
                      color: accentColorYellow,
                    ),
                    error: (error, stackTrace) => Text('Error loading Timer'),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
