import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:native_admob_flutter/native_admob_flutter.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:renew/common/constants.dart';
import 'package:renew/common/providers/ads_provider.dart';
import 'package:renew/common/providers/current_timer.dart';
import 'package:renew/common/styling.dart';
import 'package:renew/common/utils.dart';
import 'package:renew/common/widgets/bee_animation.dart';
import 'package:renew/screens/interval_settings/providers/presets_provider.dart';

class IntervalSettingsScreen extends ConsumerWidget {
  IntervalSettingsScreen() : super(key: UniqueKey());

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final TextTheme _textTheme = Theme.of(context).textTheme;
    final ThemeData _themeData = Theme.of(context);

    final int _currentFocusTime = watch(currentFocusTimeProvider.state);
    final int _currentBreakTime = watch(currentBreakTimeProvider.state);

    final int _presetsProviderState = watch(presetsProvider.state);
    return Container(
      color: primaryBlue,
      child: SafeArea(
        bottom: false,
        child: Scaffold(
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              // save as last config.
              Navigator.pushNamed(context, '/tasks');
            },
            child: Icon(
              Icons.check,
              size: 30,
              color: _themeData.iconTheme.color,
            ),
          ),
          body: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
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
                  //     return watch(adBannerFutureProvider(2)).when(
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
                      IconButton(
                          iconSize: 30,
                          icon: Icon(Icons.arrow_back),
                          onPressed: () => Navigator.pop(context)),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  AutoSizeText(
                    'Focus | Renew',
                    maxLines: 1,
                    style: _textTheme.headline2,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  BeeAnimation(size: 60),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Presets',
                    style: _textTheme.subtitle1,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
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
                          color: shadow,
                          spreadRadius: .2,
                          blurRadius: 3,
                          offset: Offset(.3, .3),
                        )
                      ],
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: ConstrainedBox(
                      constraints: BoxConstraints(maxWidth: 250),
                      child: DropdownButtonFormField<String>(
                        decoration: CustomDecoration.getInputDecoration(''),
                        value: TIMER_OPTIONS[_presetsProviderState],
                        icon: Icon(
                          Icons.arrow_drop_down,
                          color: shadow,
                        ),
                        onChanged: (String? label) {
                          if (label != null) {
                            int indexOfLabel = TIMER_OPTIONS.indexOf(label);
                            context.read(presetsProvider).update(indexOfLabel);
                            switch (indexOfLabel) {
                              case 0:
                                context
                                    .read(currentFocusTimeProvider)
                                    .update(25);
                                context
                                    .read(currentBreakTimeProvider)
                                    .update(5);
                                break;
                              default:
                                context
                                    .read(currentFocusTimeProvider)
                                    .update(45);
                                context
                                    .read(currentBreakTimeProvider)
                                    .update(5);
                            }
                          }
                        },
                        items: TIMER_OPTIONS
                            .map<DropdownMenuItem<String>>((itemLabel) {
                          return DropdownMenuItem<String>(
                            value: itemLabel,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Text(
                                itemLabel,
                                style: _textTheme.bodyText1,
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          Text(
                            'Focus',
                            style: _textTheme.subtitle1,
                          ),
                          SizedBox(
                            height: 10,
                          ),
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
                              minValue: 1,
                              maxValue: 480,
                              itemCount: 5,
                              itemHeight: 25,
                              itemWidth: 75,
                              textStyle: _textTheme.bodyText1,
                              selectedTextStyle: _textTheme.bodyText2,
                              value: _currentFocusTime,
                              onChanged: (value) => context
                                  .read(currentFocusTimeProvider)
                                  .update(value),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            '${formatDuration(Duration(minutes: _currentFocusTime))}',
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Text(
                            'Renew',
                            style: _textTheme.subtitle1,
                          ),
                          SizedBox(
                            height: 10,
                          ),
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
                              minValue: 1,
                              maxValue: 240,
                              itemCount: 5,
                              itemHeight: 25,
                              itemWidth: 75,
                              textStyle: _textTheme.bodyText1,
                              selectedTextStyle: _textTheme.bodyText2,
                              value: _currentBreakTime,
                              onChanged: (value) {
                                print(value);
                                context
                                    .read(currentBreakTimeProvider)
                                    .update(value);
                              },
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            '${formatDuration(Duration(minutes: _currentBreakTime))}',
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
      ),
    );
  }
}
