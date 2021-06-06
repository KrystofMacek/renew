import 'dart:async';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:native_admob_flutter/native_admob_flutter.dart';
import 'package:renew/common/constants.dart';
import 'package:renew/common/providers/ads_provider.dart';
import 'package:renew/common/providers/current_timer.dart';
import 'package:renew/common/styling.dart';
import 'package:renew/common/utils.dart';
import 'package:renew/common/widgets/timer_widget.dart';
import 'package:renew/data/task.dart';
import 'package:renew/screens/tasks_settings/providers/tasks_provider.dart';
import 'package:renew/screens/tasks_settings/widgets/checkbox.dart';

import 'package:renew/screens/timer/widgets/buttons.dart';
import 'package:renew/screens/timer/widgets/task_list_view.dart';
import 'package:renew/screens/timer/widgets/timer_controlls.dart';
import 'dart:math' as math;

class TimerWidget extends ConsumerWidget {
  const TimerWidget({
    Key? key,
    required TimerController timerController,
    required TextTheme textTheme,
    required this.size,
    required this.timerValue,
    required AnimationController animationController,
    required Duration timerDuration,
    required bool isBreak,
  })   : _timerController = timerController,
        _textTheme = textTheme,
        _animationController = animationController,
        _timerDuration = timerDuration,
        _isBreak = isBreak,
        super(key: key);

  final TimerController _timerController;
  final TextTheme _textTheme;
  final double size;
  final double timerValue;
  final AnimationController _animationController;
  final Duration _timerDuration;
  final bool _isBreak;

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    List<Task> _taskList = watch(selectedTaskListProvider.state);
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
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
        //     return watch(adBannerFutureProvider(4)).when(
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
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(
              width: 30,
            ),
            Text(
              _timerController.getTimerType() == CURRENT_TIMER.FOCUS
                  ? 'Focus'
                  : 'Break',
              style: _textTheme.headline2,
              textAlign: TextAlign.center,
            ),
            (_isBreak && _taskList.isNotEmpty)
                ? Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: colorWhiteBlue,
                    ),
                    child: Center(
                      child: IconButton(
                        icon: Icon(
                          Icons.view_list,
                          color: shadow,
                        ),
                        onPressed: () {
                          showDialog(
                            barrierDismissible: true,
                            context: context,
                            builder: (context) {
                              return TaskListView(
                                taskList: _taskList,
                                textTheme: _textTheme,
                                key: key,
                              );
                            },
                          );
                        },
                      ),
                    ),
                  )
                : SizedBox(
                    width: 40,
                  ),
          ],
        ),
        const SizedBox(
          height: 50,
        ),
        TimerUI(
            size: size,
            timerValue: timerValue,
            timerDuration: _timerDuration,
            textTheme: _textTheme),
        SizedBox(height: 30),
        TimerControlls(animationController: _animationController),
        SizedBox(height: 30),
        _timerDuration.inSeconds < 1
            ? (_timerController.getTimerType() == CURRENT_TIMER.FOCUS)
                ? BreakButton(timerController: _timerController)
                : FocusButton(timerController: _timerController)
            : SizedBox(),
      ],
    );
  }
}
