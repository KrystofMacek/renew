import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rive/rive.dart' as rive;

final animationProvider = FutureProvider<rive.Artboard>((ref) async {
  rive.Artboard _riveArtboard;
  rive.RiveAnimationController _riveController;
  final riveFileName = 'assets/bee.riv';

  return await rootBundle.load('assets/bee.riv').then<rive.Artboard>(
    (data) async {
      // Load the RiveFile from the binary data.
      final file = rive.RiveFile.import(data);
      // The artboard is the root of the animation and gets drawn in the
      // Rive widget.
      final artboard = file.mainArtboard;
      // Add a controller to play back a known animation on the main/default
      // artboard.We store a reference to it so we can toggle playback.
      artboard.addController(_riveController = rive.SimpleAnimation('fly'));
      _riveArtboard = artboard;
      return _riveArtboard;
    },
  );
});
