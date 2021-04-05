import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:renew/common/styling.dart';
import 'package:renew/data/task.dart';
import 'package:renew/screens/tasks_settings/providers/tasks_provider.dart';
import 'package:renew/screens/tasks_settings/widgets/checkbox.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TaskListView extends StatelessWidget {
  const TaskListView({
    Key? key,
    required List<Task> taskList,
    required TextTheme textTheme,
  })   : _taskList = taskList,
        _textTheme = textTheme,
        super(key: key);

  final List<Task> _taskList;
  final TextTheme _textTheme;

  @override
  Widget build(BuildContext context) {
    return CustomDialog(
      backgroundColor: colorWhiteBlue,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 15),
        decoration: BoxDecoration(
          color: colorWhiteBlue,
          borderRadius: BorderRadius.circular(25),
        ),
        child: ListView.separated(
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return Container(
                padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                decoration: BoxDecoration(
                    color: colorWhiteBlue,
                    boxShadow: [
                      BoxShadow(color: shadow, spreadRadius: .2, blurRadius: 3)
                    ],
                    borderRadius: BorderRadius.circular(5)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Expanded(
                      child: AutoSizeText(
                        _taskList[index].name,
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
                          .read(selectedTaskListProvider)
                          .toggleTask(index),
                      child: CustomCheckBox(
                        key,
                        35,
                        30,
                        _taskList[index].isChecked,
                        false,
                        true,
                      ),
                    ),
                  ],
                ),
              );
            },
            separatorBuilder: (context, index) => SizedBox(
                  height: 5,
                ),
            itemCount: _taskList.length),
      ),
    );
  }
}
