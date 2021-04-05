import 'package:flutter/material.dart';
import 'package:renew/common/styling.dart';

class CustomCheckBox extends StatelessWidget {
  const CustomCheckBox(
    Key? key,
    double size,
    double iconSize,
    bool isChecked,
    bool isDisabled,
    bool isClickable,
  )   : _size = size,
        _isClickable = isClickable,
        _iconSize = iconSize,
        _isChecked = isChecked,
        _isDisabled = isDisabled,
        super(key: key);

  final double _size;
  final double _iconSize;
  final bool _isChecked;
  final bool _isDisabled;
  final bool _isClickable;

  @override
  Widget build(BuildContext context) {
    if (_isDisabled) {
      return Container(
        height: _size,
        width: _size,
        decoration: BoxDecoration(
          color: Colors.grey[500],
          borderRadius: BorderRadius.circular(5),
        ),
      );
    }
    if (!_isClickable) {
      return Container(
        height: _size,
        width: _size,
        decoration: BoxDecoration(
          color: _isChecked ? Colors.grey[500] : Theme.of(context).cardColor,
          border: Border.all(
            width: 2,
            color: Colors.grey,
          ),
          borderRadius: BorderRadius.circular(5),
        ),
        child: Center(
          child: _isChecked
              ? Icon(
                  Icons.check,
                  size: _iconSize,
                  color: Colors.white,
                )
              : SizedBox(),
          // Icon(
          //     Icons.remove,
          //     size: _iconSize,
          //     color: Colors.white,
          //   ),
        ),
      );
    }

    return Container(
      height: _size,
      width: _size,
      decoration: BoxDecoration(
        boxShadow: [BoxShadow(color: shadow, spreadRadius: .2, blurRadius: 3)],
        border: Border.all(
          width: 2,
          color: accentColorYellow,
        ),
        borderRadius: BorderRadius.circular(5),
        color: lightPrimary,
      ),
      child: Center(
        child: _isChecked
            ? Icon(
                Icons.check,
                size: _iconSize,
                color: Colors.white,
              )
            : SizedBox(),
      ),
    );
  }
}
