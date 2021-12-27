import 'dart:math';

import 'package:design_patterns_dart/text_canvas.dart';

import 'render_element.dart';
import 'render_position.dart';

abstract class RenderLayout extends RenderElement {
  List<RenderPosition> get positions;

  final List<RenderElement> children;
  final int space;

  RenderLayout({
    required this.children,
    this.space = 3,
  });

  int get childWidth => children.fold<int>(
      0, (width, renderElement) => width + renderElement.width);

  int get childHeight => children.fold<int>(
      0, (height, renderElement) => height + renderElement.height);

  int get spacesSum => max(0, (children.length - 1) * space);

  @override
  void render(Canvas dc) {
    for(final child in positions) {
      child.render(dc);
    }
  }
}
