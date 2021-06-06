import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:native_admob_flutter/native_admob_flutter.dart';
import 'package:renew/common/providers/ads_provider.dart';
import 'package:renew/common/widgets/bee_animation.dart';
import 'package:renew/data/task.dart';
import 'package:renew/screens/tasks_settings/providers/tasks_provider.dart';

import 'package:renew/common/styling.dart';
import 'package:renew/screens/tasks_settings/widgets/checkbox.dart';

class TasksSettingsScreen extends ConsumerWidget {
  TasksSettingsScreen() : super(key: UniqueKey());

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final TextTheme _textTheme = Theme.of(context).textTheme;
    final ThemeData _themeData = Theme.of(context);

    final TextEditingController _taskInputController =
        TextEditingController(text: '');
    final List<Task> _tasksList = watch(tasksListProvider.state);

    for (var task in _tasksList) {
      print(task.toString());
    }

    return Container(
      color: primaryBlue,
      child: SafeArea(
        bottom: false,
        child: Scaffold(
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.pushNamed(context, '/timer');
              context.read(tasksListProvider).initSelectedList();
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
                  //     return watch(adBannerFutureProvider(3)).when(
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
                  Text(
                    'Renew Time Plan',
                    style: _textTheme.headline2,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  BeeAnimation(size: 60),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 30),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: _taskInputController,
                            decoration:
                                CustomDecoration.getInputDecoration('Task')
                                    .copyWith(
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 5),
                            ),
                            style: _textTheme.subtitle1?.copyWith(
                                color: Colors.grey[850], fontSize: 20),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        IconButton(
                          padding: EdgeInsets.all(0),
                          icon: Icon(Icons.add),
                          onPressed: () {
                            if (_taskInputController.text.isNotEmpty) {
                              context
                                  .read(tasksListProvider)
                                  .add(_taskInputController.text);
                              _taskInputController.clear();
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: ListView.separated(
                      itemBuilder: (context, index) {
                        if (index == _tasksList.length) {
                          return SizedBox(
                            height: 80,
                          );
                        }
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12.0),
                          child: GestureDetector(
                            onLongPress: () {
                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  title: Text('Remove task permanently ?'),
                                  actions: [
                                    TextButton(
                                        onPressed: () {
                                          context
                                              .read(tasksListProvider)
                                              .remove(index);
                                          Navigator.pop(context);
                                        },
                                        child: Text('Remove'))
                                  ],
                                ),
                              );
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 5, vertical: 5),
                              decoration: BoxDecoration(
                                  color: colorWhiteBlue,
                                  boxShadow: [
                                    BoxShadow(
                                        color: shadow,
                                        spreadRadius: .2,
                                        blurRadius: 3)
                                  ],
                                  borderRadius: BorderRadius.circular(5)),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Expanded(
                                    child: AutoSizeText(
                                      _tasksList[index].name,
                                      maxLines: 3,
                                      minFontSize: 16,
                                      style: _textTheme.button,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  GestureDetector(
                                    onTap: () => context
                                        .read(tasksListProvider)
                                        .toggleTask(index),
                                    child: CustomCheckBox(
                                      key,
                                      35,
                                      30,
                                      _tasksList[index].isChecked,
                                      false,
                                      true,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                      separatorBuilder: (context, index) => SizedBox(
                        height: 10,
                      ),
                      itemCount: _tasksList.length + 1,
                    ),
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
