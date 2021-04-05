import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:renew/common/providers/current_timer.dart';
import 'package:renew/common/styling.dart';
import 'package:renew/screens/timer/providers/notifications_provider.dart';

class ButtonResumeTimer extends StatelessWidget {
  const ButtonResumeTimer({
    Key? key,
    required AnimationController animationController,
  })   : _animationController = animationController,
        super(key: key);

  final AnimationController _animationController;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 2,
      borderRadius: BorderRadius.circular(50),
      color: colorWhiteBlue,
      child: IconButton(
        icon: Icon(
          Icons.play_arrow,
          size: 30,
          color: shadow,
        ),
        onPressed: () {
          context.read(timerControllerProvider).resumeTimer();
          _animationController.forward();
        },
      ),
    );
  }
}

class ButtonPauseTimer extends StatelessWidget {
  const ButtonPauseTimer({
    Key? key,
    required AnimationController animationController,
  })   : _animationController = animationController,
        super(key: key);
  final AnimationController _animationController;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 2,
      borderRadius: BorderRadius.circular(50),
      color: colorWhiteBlue,
      child: IconButton(
        icon: Icon(
          Icons.pause,
          size: 30,
          color: shadow,
        ),
        onPressed: () {
          context.read(timerControllerProvider).pauseTimer();
          _animationController.stop();
        },
      ),
    );
  }
}

class ButtonAddFive extends StatelessWidget {
  const ButtonAddFive({
    Key? key,
    required AnimationController animationController,
  })   : _animationController = animationController,
        super(key: key);

  final AnimationController _animationController;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 2,
      borderRadius: BorderRadius.circular(50),
      color: colorWhiteBlue,
      child: GestureDetector(
        child: Container(
          padding: EdgeInsets.all(8),
          child: Text(
            'add 5m',
            style: Theme.of(context).textTheme.bodyText1,
          ),
        ),
        onTap: () {
          context
              .read(timerControllerProvider)
              .addToATimer(Duration(minutes: 5));
        },
      ),
    );
  }
}

class ButtonRemoveFive extends StatelessWidget {
  const ButtonRemoveFive({
    Key? key,
    required AnimationController animationController,
  })   : _animationController = animationController,
        super(key: key);

  final AnimationController _animationController;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 2,
      borderRadius: BorderRadius.circular(50),
      color: colorWhiteBlue,
      child: GestureDetector(
        child: Container(
          padding: EdgeInsets.all(8),
          child: Text('skip 5m', style: Theme.of(context).textTheme.bodyText1),
        ),
        onTap: () {
          context
              .read(timerControllerProvider)
              .addToATimer(Duration(minutes: -5));
        },
      ),
    );
  }
}

class ButtonAddTwo extends StatelessWidget {
  const ButtonAddTwo({
    Key? key,
    required AnimationController animationController,
  })   : _animationController = animationController,
        super(key: key);

  final AnimationController _animationController;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 2,
      borderRadius: BorderRadius.circular(50),
      color: colorWhiteBlue,
      child: GestureDetector(
        child: Container(
          padding: EdgeInsets.all(8),
          child: Text(
            'add 2m',
            style: Theme.of(context).textTheme.bodyText1,
          ),
        ),
        onTap: () {
          context
              .read(timerControllerProvider)
              .addToATimer(Duration(minutes: 2));
        },
      ),
    );
  }
}

class ButtonRemoveTwo extends StatelessWidget {
  const ButtonRemoveTwo({
    Key? key,
    required AnimationController animationController,
  })   : _animationController = animationController,
        super(key: key);

  final AnimationController _animationController;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 2,
      borderRadius: BorderRadius.circular(50),
      color: colorWhiteBlue,
      child: GestureDetector(
        child: Container(
          padding: EdgeInsets.all(8),
          child: Text('skip 2m', style: Theme.of(context).textTheme.bodyText1),
        ),
        onTap: () {
          context
              .read(timerControllerProvider)
              .addToATimer(Duration(minutes: -2));
        },
      ),
    );
  }
}

class FocusButton extends StatelessWidget {
  const FocusButton({
    Key? key,
    required TimerController timerController,
  })   : _timerController = timerController,
        super(key: key);

  final TimerController _timerController;

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(50),
      color: colorWhiteBlue,
      child: TextButton(
        child: Text(
          'Start Focusing',
          style: Theme.of(context).textTheme.bodyText1,
        ),
        onPressed: () {
          context.read(timerControllerProvider).resetBaseTimes();
          _timerController.startFocus();
        },
      ),
    );
  }
}

class BreakButton extends StatelessWidget {
  const BreakButton({
    Key? key,
    required TimerController timerController,
  })   : _timerController = timerController,
        super(key: key);

  final TimerController _timerController;

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(50),
      color: colorWhiteBlue,
      child: TextButton(
        child: Text(
          'Take a Break',
          style: Theme.of(context).textTheme.bodyText1,
        ),
        onPressed: () {
          context.read(timerControllerProvider).resetBaseTimes();
          _timerController.startBreak();
        },
      ),
    );
  }
}
