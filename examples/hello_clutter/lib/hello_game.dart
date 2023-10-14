import 'package:clutter/clutter.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

class HelloGame implements Game {
  var running = true;
  var r = 0, g = 86, b = 172;

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
    canvas.setScaledPixel(2, 2, 50, r, g, b);
  }

  @override
  void update(double dt) {
    if (running) {
      int inc = (dt * 100).floor();
      r = (r + inc) % 255;
      g = (g + inc) % 255;
      b = (b + inc) % 255;
    }
  }
}
