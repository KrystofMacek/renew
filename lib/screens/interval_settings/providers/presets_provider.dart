import 'package:flutter_riverpod/flutter_riverpod.dart';

final presetsProvider =
    StateNotifierProvider<PresetsProvider>((ref) => PresetsProvider());

class PresetsProvider extends StateNotifier<int> {
  PresetsProvider() : super(1);

  update(int index) => state = index;
}
