import 'package:flutter/material.dart';

import '../../../abstract_factory/tool_panel_factory/widgets/independent/event_listenable_builder.dart';
import '../app/app.dart';

class DrawingBoard extends StatelessWidget {
  final App app;

  const DrawingBoard({Key? key, required this.app}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerDown: (e) => app.manipulator.mouseDown(
        e.localPosition.dx,
        e.localPosition.dy,
      ),
      onPointerHover: (e) => app.manipulator.mouseMove(
        e.localPosition.dx,
        e.localPosition.dy,
      ),
      onPointerMove: (e) => app.manipulator.mouseMove(
        e.localPosition.dx,
        e.localPosition.dy,
      ),
      onPointerUp: (e) => app.manipulator.mouseUp(),
      child: Container(
        constraints: BoxConstraints.expand(),
        color: Color(0xff1f1f1f),
        child: EventListenableBuilder(
          event: app.shapes.onChange,
          builder: (_) {
            return EventListenableBuilder(
              event: app.manipulator.onUpdate,
              builder: (_) {
                return MouseRegion(
                  cursor: app.manipulator.cursor,
                  child: CustomPaint(
                    painter: _Painter(app),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}

class _Painter extends CustomPainter {
  final App app;

  _Painter(this.app);

  @override
  void paint(Canvas canvas, Size size) {
    canvas.translate(0.5, 0.5);
    for (final shape in app.shapes) {
      shape.paint(canvas);
    }

    app.manipulator.paint(canvas);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
