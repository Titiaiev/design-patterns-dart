import 'package:flutter/cupertino.dart';

import 'manipulation_state.dart';

class ManipulatorContext {
  late ManipulationState _state;

  ManipulatorContext({required ManipulationState initState})
      : _state = initState {
    _state.context = this;
  }

  ManipulationState get state => _state;

  void changeState(ManipulationState newState) {
    if (_state == newState) {
      return;
    }

    _state = newState;
    _state.context = this;
    onStateChange._emit();
  }

  final onStateChange = Event();

  void mouseMove(double x, double y) {}

  void mouseDown(double x, y) => _state.mouseDown(x, y);

  void mouseUp() {}

  void keyDown(String key) {}

  void paint(Canvas canvas) {}
}

class Event extends ChangeNotifier {
  void _emit() => notifyListeners();
}
