library manipulator;

import 'package:flutter/material.dart';
import '../app/shapes.dart';

part 'manipulation_state.dart';

class ManipulatorContext {
  final Shapes shapes;

  ManipulatorContext({
    required this.shapes,
    required ManipulationState initState,
  }) : _state = initState {
    _state._context = this;
  }

  ManipulationState _state;

  ManipulationState get state => _state;

  void changeState(ManipulationState newState) {
    if (_state == newState) {
      return;
    }

    _state = newState;
    _state._context = this;
    onStateChange._emit();
  }

  final onStateChange = Event();
  final onUpdate = Event();

  var cursor = MouseCursor.defer;

  void update() {
    onUpdate._emit();
  }

  @override
  String toString() {
    return _state.toString();
  }

  void mouseMove(double x, double y) {
    _state.mouseMove(x, y);
  }

  void mouseDown(double x, double y) {
    _state.mouseDown(x, y);
  }

  void mouseUp() {
    _state.mouseUp();
  }

  void keyDown(String key) {
    _state.keyDown(key);
  }

  void paint(Canvas canvas) {
    _state.paint(canvas);
  }
}

class Event extends ChangeNotifier {
  void _emit() => notifyListeners();
}
