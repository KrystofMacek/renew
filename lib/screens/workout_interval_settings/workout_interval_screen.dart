import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:native_admob_flutter/native_admob_flutter.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:renew/common/providers/ads_provider.dart';
import 'package:renew/common/styling.dart';
import 'package:renew/common/utils.dart';
import 'package:renew/common/widgets/bee_animation.dart';
import 'package:renew/screens/workout_interval_settings/providers/workout_timer_data.dart';
import 'package:wakelock/wakelock.dart';

class WorkoutIntervalSettingsScreen extends ConsumerWidget {
  WorkoutIntervalSettingsScreen() : super(key: UniqueKey());

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final TextTheme _textTheme = Theme.of(context).textTheme;
    final ThemeData _themeData = Theme.of(context);

    final int _workoutSeconds = watch(workoutSeconds.state);

    final int _workoutBreakSeconds = watch(workoutBreakSeconds.state);

    final int _workoutSets = watch(workoutSets.state);

    return Container(
      color: primaryBlue,
      child: SafeArea(
        bottom: false,
        child: Scaffold(
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              // save as last config.
              Navigator.pushNamed(context, '/workout_timer');
              Wakelock.enable();
            },
            child: Icon(
              Icons.check,
              size: 30,
              color: _themeData.iconTheme.color,
            ),
          ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                NativeAd(
                  buildLayout: adBannerLayoutBuilder,
                  loading: SizedBox(height: 50),
                  error: SizedBox(height: 50),
                  height: 50,
                ),
                // Consumer(
                //   builder: (context, watch, child) {
                //     return watch(adBannerFutureProvider(5)).when(
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
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: IconButton(
                          iconSize: 30,
                          icon: Icon(Icons.arrow_back),
                          onPressed: () => Navigator.pop(context)),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  'Timer',
                  style: _textTheme.headline2,
                ),
                const SizedBox(
                  height: 30,
                ),
                BeeAnimation(size: 60),
                const SizedBox(
                  height: 10,
                ),
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          children: [
                            Text(
                              'Workout',
                              style: _textTheme.subtitle1,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    color: colorWhiteBlue,
                                    boxShadow: [
                                      BoxShadow(
                                        color: shadow,
                                        spreadRadius: .1,
                                        blurRadius: 3,
                                        offset: Offset(.3, .3),
                                      )
                                    ],
                                    borderRadius: BorderRadius.circular(25),
                                  ),
                                  child: NumberPicker(
                                    itemWidth: 75,
                                    minValue: 1,
                                    maxValue: 600,
                                    itemCount: 4,
                                    itemHeight: 25,
                                    textStyle: _textTheme.bodyText1,
                                    selectedTextStyle: _textTheme.bodyText2,
                                    value: _workoutSeconds,
                                    onChanged: (value) => context
                                        .read(workoutSeconds)
                                        .update(value),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              '${formatDuration(Duration(seconds: _workoutSeconds))}',
                            ),
                          ],
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Column(
                          children: [
                            Text(
                              'Break',
                              style: _textTheme.subtitle1,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    color: colorWhiteBlue,
                                    boxShadow: [
                                      BoxShadow(
                                        color: shadow,
                                        spreadRadius: .1,
                                        blurRadius: 3,
                                        offset: Offset(.3, .3),
                                      )
                                    ],
                                    borderRadius: BorderRadius.circular(25),
                                  ),
                                  child: NumberPicker(
                                    itemWidth: 75,
                                    minValue: 1,
                                    maxValue: 600,
                                    itemCount: 4,
                                    itemHeight: 25,
                                    textStyle: _textTheme.bodyText1,
                                    selectedTextStyle: _textTheme.bodyText2,
                                    value: _workoutBreakSeconds,
                                    onChanged: (value) => context
                                        .read(workoutBreakSeconds)
                                        .update(value),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              '${formatDuration(Duration(seconds: _workoutBreakSeconds))}',
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Column(
                      children: [
                        Text(
                          'Sets',
                          style: _textTheme.subtitle1,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: colorWhiteBlue,
                                boxShadow: [
                                  BoxShadow(
                                    color: shadow,
                                    spreadRadius: .1,
                                    blurRadius: 3,
                                    offset: Offset(.3, .3),
                                  )
                                ],
                                borderRadius: BorderRadius.circular(25),
                              ),
                              child: NumberPicker(
                                itemWidth: 50,
                                minValue: 1,
                                maxValue: 59,
                                itemCount: 4,
                                itemHeight: 25,
                                textStyle: _textTheme.bodyText1,
                                selectedTextStyle: _textTheme.bodyText2,
                                value: _workoutSets,
                                onChanged: (value) =>
                                    context.read(workoutSets).update(value),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
