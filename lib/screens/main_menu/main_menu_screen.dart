import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:renew/common/styling.dart';
import 'package:rive/rive.dart' as rive;
import './providers/animation_provider.dart';

class MainMenuScreen extends StatefulWidget {
  MainMenuScreen() : super(key: UniqueKey());

  @override
  _MainMenuScreenState createState() => _MainMenuScreenState();
}

class _MainMenuScreenState extends State<MainMenuScreen>
    with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: MainMenuBody(),
      ),
    );
  }
}

class MainMenuBody extends StatefulWidget {
  const MainMenuBody({
    Key? key,
  }) : super(key: key);

  @override
  _MainMenuBodyState createState() => _MainMenuBodyState();
}

class _MainMenuBodyState extends State<MainMenuBody>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Color?> animation;

  late rive.Artboard _riveArtboard;
  late rive.RiveAnimationController _riveController;
  final riveFileName = 'assets/bee.riv';

  void _loadRiveFile() async {
    await rootBundle.load('assets/bee.riv').then(
      (data) async {
        // Load the RiveFile from the binary data.
        final file = rive.RiveFile.import(data);
        // The artboard is the root of the animation and gets drawn in the
        // Rive widget.
        final artboard = file.mainArtboard;
        // Add a controller to play back a known animation on the main/default
        // artboard.We store a reference to it so we can toggle playback.
        artboard.addController(_riveController = rive.SimpleAnimation('fly'));
        setState(() => _riveArtboard = artboard);
      },
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );

    animation = ColorTween(
      begin: colorWhiteBlue,
      end: accentColorYellowLight,
    ).animate(_controller);

    _controller.addListener(() {
      this.setState(() {});
    });
    // _loadRiveFile();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final TextTheme _textTheme = Theme.of(context).textTheme;
    final ThemeData _themeData = Theme.of(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(
          height: 50,
        ),
        // AnimatedDefaultTextStyle(child: child, style: style, duration: duration),

        // TextLiquidFill(
        //   text: 'Renew',
        //   waveColor: accentColorYellow,
        //   boxBackgroundColor: primaryBlue,
        //   textStyle: _textTheme.headline1!,
        //   // boxHeight: 300.0,
        // ),
        AnimatedTextKit(
          isRepeatingAnimation: false,
          onFinished: () {
            _controller.forward();
          },
          animatedTexts: [
            TyperAnimatedText(
              'Renew',
              textStyle:
                  _textTheme.headline1!.copyWith(color: accentColorYellowLight),
              curve: Curves.easeOut,
              speed: Duration(
                milliseconds: 300,
              ),
            ),
          ],
        ),
        Consumer(
          builder: (context, watch, child) {
            return watch(animationProvider).when(
              data: (value) {
                return Container(
                  height: 100,
                  width: 100,
                  child: rive.Rive(
                    artboard: value,
                    fit: BoxFit.cover,
                  ),
                );
              },
              loading: () => SizedBox(
                height: 100,
              ),
              error: (_, __) => SizedBox(
                height: 100,
              ),
            );
          },
        ),

        SizedBox(
          height: 45,
        ),
        Container(
          child: GestureDetector(
            onTap: () => Navigator.pushNamed(context, '/interval'),
            child: Container(
              decoration: BoxDecoration(
                color: colorWhiteBlue,
                gradient: RadialGradient(
                  radius: 3,
                  colors: [
                    Colors.white,
                    colorWhiteBlue,
                  ],
                ),
                boxShadow: [
                  BoxShadow(
                    color: colorWhiteBlue,
                    spreadRadius: .2,
                    blurRadius: 3,
                    offset: Offset(.3, .3),
                  )
                ],
                borderRadius: BorderRadius.circular(25),
              ),
              // elevation: 5,
              // shadowColor: accentColorYellow,
              // borderRadius: BorderRadius.circular(10),
              child: Container(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.timer,
                        color: shadow,
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Text(
                        'Interval Timer',
                        style: _textTheme.button,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        SizedBox(
          height: 30,
        ),
        Container(
          child: GestureDetector(
            onTap: () => Navigator.pushNamed(context, '/workout_interval'),
            child: Container(
              decoration: BoxDecoration(
                color: colorWhiteBlue,
                gradient: RadialGradient(
                  radius: 3,
                  colors: [
                    Colors.white,
                    colorWhiteBlue,
                  ],
                ),
                boxShadow: [
                  BoxShadow(
                    color: colorWhiteBlue,
                    spreadRadius: .2,
                    blurRadius: 3,
                    offset: Offset(.3, .3),
                  )
                ],
                borderRadius: BorderRadius.circular(25),
              ),
              // elevation: 5,
              // shadowColor: accentColorYellow,
              // borderRadius: BorderRadius.circular(10),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.fitness_center,
                      color: shadow,
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Text(
                      'Workout',
                      style: _textTheme.button,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
