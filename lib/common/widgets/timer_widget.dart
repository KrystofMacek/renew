import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:renew/common/styling.dart';
import 'package:renew/common/utils.dart';

class TimerUI extends StatefulWidget {
  const TimerUI({
    Key? key,
    required this.size,
    required this.timerValue,
    required Duration timerDuration,
    required TextTheme textTheme,
  })   : _timerDuration = timerDuration,
        _textTheme = textTheme,
        super(key: key);

  final double size;
  final double timerValue;
  final Duration _timerDuration;
  final TextTheme _textTheme;

  @override
  _TimerUIState createState() => _TimerUIState();
}

class _TimerUIState extends State<TimerUI> with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Color?> animation;

  @override
  void initState() {
    // TODO: implement initState
    //
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );

    animation = ColorTween(
      begin: accentColorYellow,
      end: accentColorYellowLight,
    ).animate(_controller);

    _controller.forward();
    _controller.addListener(() {
      if (_controller.status == AnimationStatus.completed) {
        _controller.reverse();
      }
      if (_controller.status == AnimationStatus.dismissed) {
        _controller.forward();
      }
      this.setState(() {});
    });

    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.size,
      height: widget.size,
      child: Stack(
        children: [
          ShaderMask(
            shaderCallback: (rect) {
              return SweepGradient(
                startAngle: 0,
                endAngle: math.pi * 2,
                center: Alignment.center,
                transform: GradientRotation(-math.pi / 2),
                stops: [
                  widget.timerValue,
                  widget.timerValue,
                ],
                colors: [
                  animation.value!,
                  colorWhiteBlue,
                ],
              ).createShader(rect);
            },
            child: Container(
              width: widget.size,
              height: widget.size,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(color: shadow, spreadRadius: 2, blurRadius: 5),
                ],
                shape: BoxShape.circle,
                color: Colors.white,
              ),
            ),
          ),
          Center(
            child: Container(
              height: widget.size - 40,
              width: widget.size - 40,
              decoration: BoxDecoration(
                color: primaryBlue,
                gradient: RadialGradient(
                  radius: .8,
                  colors: [primaryBlue, shadow],
                  // begin: Alignment.topLeft,
                  // end: Alignment.bottomRight,
                ),
                shape: BoxShape.circle,
              ),
            ),
          ),
          Transform.rotate(
            angle: (math.pi * 2) * widget.timerValue,
            child: Transform.translate(
              offset: Offset(0, -(widget.size - 20) / 2),
              child: Center(
                child: Container(
                  height: 30,
                  width: 30,
                  decoration: BoxDecoration(
                    color: accentColorYellow,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: accentColorYellow,
                        spreadRadius: 1,
                        blurRadius: 6,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Center(
            child: Text(
              '${formatDuration(widget._timerDuration)}',
              style: widget._textTheme.headline3,
              textAlign: TextAlign.center,
            ),
          ),

          // static circle to make the line look nicer
          // Transform.translate(
          //   offset: Offset(0, -(widget.size - 20) / 2),
          //   child: Center(
          //     child: AnimatedContainer(
          //       duration: Duration(seconds: 1),
          //       height: 20,
          //       width: 20,
          //       decoration: BoxDecoration(
          //         color: animation.value,
          //         shape: BoxShape.circle,
          //       ),
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}
