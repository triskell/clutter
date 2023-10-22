import 'dart:math';

import 'package:clutter/clutter.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

class HelloGame implements Game {
  var running = true;
  var color = 0xFF0055CC;
  var angle = 0.0;

  @override
  KeyEventResult onKeyboardEvent(FocusNode node, RawKeyEvent event) {
    if (event.logicalKey == LogicalKeyboardKey.space) {
      if (event is RawKeyDownEvent) {
        running = !running;
      }
    }

    return KeyEventResult.handled;
  }

  @override
  void render(Canvas canvas) {
    canvas.fillRect(const IPoint(100, 100), const IPoint(150, 130), color);

    const length = 80;
    const origin = Point<double>(100, 100);
    final tip =
        (origin + Point(length * cos(angle), length * sin(angle))).toIPoint();
    canvas.fillEllipse(const IPoint(10, 10), tip, color);
    canvas.drawLine(origin.toIPoint(), tip, 0xFFFF0000);
  }

  @override
  void update(double dt) {
    if (running) {
      int inc = (dt * 100).floor();
      color = (color + inc) % 0x00FFFFFF + 0xFF000000;

      angle = (angle + dt) % (2 * pi);
    }
  }
}
