import 'package:flutter/material.dart';
import 'package:renew/common/constants.dart';
import 'package:renew/common/providers/current_timer.dart';
import 'package:renew/screens/timer/widgets/buttons.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TimerControlls extends ConsumerWidget {
  const TimerControlls({
    Key? key,
    required AnimationController animationController,
  })   : _animationController = animationController,
        super(key: key);

  final AnimationController _animationController;

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final TimerController _timerController = watch(timerControllerProvider);

    final TIMER_STATES _timerStates = _timerController.getTimerState();
    final bool _timerIsBreak =
        _timerController.getTimerType() == CURRENT_TIMER.BREAK;

    if (_timerStates == TIMER_STATES.NOT_STARTED) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ButtonResumeTimer(animationController: _animationController),
        ],
      );
    } else if (_timerStates == TIMER_STATES.PAUSED) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _timerIsBreak
              ? ButtonRemoveTwo(animationController: _animationController)
              : ButtonRemoveFive(
                  animationController: _animationController,
                ),
          SizedBox(
            width: 15,
          ),
          ButtonResumeTimer(
            animationController: _animationController,
          ),
          SizedBox(
            width: 15,
          ),
          _timerIsBreak
              ? ButtonAddTwo(animationController: _animationController)
              : ButtonAddFive(
                  animationController: _animationController,
                ),
        ],
      );
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _timerIsBreak
            ? ButtonRemoveTwo(animationController: _animationController)
            : ButtonRemoveFive(
                animationController: _animationController,
              ),
        SizedBox(
          width: 15,
        ),
        ButtonPauseTimer(
          animationController: _animationController,
        ),
        SizedBox(
          width: 15,
        ),
        _timerIsBreak
            ? ButtonAddTwo(animationController: _animationController)
            : ButtonAddFive(
                animationController: _animationController,
              ),
      ],
    );
  }
}
