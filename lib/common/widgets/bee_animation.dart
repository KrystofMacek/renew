import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:renew/screens/main_menu/providers/animation_provider.dart';
import 'package:rive/rive.dart' as rive;

class BeeAnimation extends StatelessWidget {
  const BeeAnimation({
    Key? key,
    required double size,
  })   : _size = size,
        super(key: key);

  final double _size;

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, watch, child) {
        return watch(animationProvider).when(
          data: (value) {
            return Container(
              height: _size,
              width: _size,
              child: rive.Rive(
                artboard: value,
                fit: BoxFit.cover,
              ),
            );
          },
          loading: () => SizedBox(
            height: _size,
          ),
          error: (_, __) => SizedBox(
            height: _size,
          ),
        );
      },
    );
  }
}
