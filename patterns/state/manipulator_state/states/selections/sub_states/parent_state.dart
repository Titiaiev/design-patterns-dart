import 'dart:ui';

import '../sub_states/child_state.dart';
import '../selection_state.dart';

class ParentState extends SelectionState {
  ParentState({required super.selectedShape});

  void addMarkers(List<ChildState> markers) {
    _markers.addAll(markers);
  }

  @override
  void mouseDown(double x, double y) {
    for (final marker in _markers) {
      marker.mouseDown(x, y);
      if (marker.isDown) {
        context.changeState(marker);
        return;
      }
    }

    super.mouseDown(x, y);
  }

  @override
  void mouseMove(double x, double y) {
    super.mouseMove(x, y);

    for (final marker in _markers) {
      marker.mouseMove(x, y);
      if (marker.isHover) {
        return;
      }
    }
  }

  @override
  void paint(Canvas canvas) {
    super.paint(canvas);

    for (final marker in _markers) {
      marker.render(canvas);
    }
  }

  void updateMarkersPosition() {
    for (final marker in _markers) {
      marker.updatePosition();
    }
  }

  List<ChildState> _markers = [];
}
