import '../pattern/manipulator.dart';
import 'mixins/hover_shape_mixin.dart';
import 'selections/moving_state.dart';

class FreeState extends ManipulationState with HoverShapeMixin {
  @override
  void mouseDown(double x, double y) {
    tryToSelectAndStartMovingShape(x, y);
  }

  bool tryToSelectAndStartMovingShape(double x, double y) {
    final selectedShape = context.shapes.findShapeByCoordinates(x, y);

    if (selectedShape == null) {
      return false;
    }

    context.changeState(
      MovingState(
        startX: x,
        startY: y,
        selectedShape: selectedShape,
      ),
    );

    return true;
  }

  @override
  String toString() {
    return 'Free State';
  }
}
