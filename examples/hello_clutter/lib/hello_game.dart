import 'dart:math';

import 'package:clutter/clutter.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

class HelloGame implements Game {
  var running = true;
  var r = 0, g = 86, b = 172;
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
    canvas.fillRect(100, 100, 150, 130, r, g, b);

    const length = 80;
    const xOrigin = 100;
    const yOrigin = 100;
    final xTip = (xOrigin + length * cos(angle)).floor();
    final yTip = (yOrigin + length * sin(angle)).floor();
    canvas.fillEllipse(10, 10, xTip, yTip, r, g, b);
    canvas.drawLine(xOrigin, yOrigin, xTip, yTip, 255, 0, 0);
  }

  @override
  void update(double dt) {
    if (running) {
      int inc = (dt * 100).floor();
      r = (r + inc) % 255;
      g = (g + inc) % 255;
      b = (b + inc) % 255;

      angle = (angle + dt) % (2 * pi);
    }
  }
}
