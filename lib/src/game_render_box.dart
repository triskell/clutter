import 'dart:ui' as ui;

import 'package:flutter/scheduler.dart';
import 'package:flutter/widgets.dart';

import 'canvas.dart';
import 'game.dart';

class GameRenderBox extends RenderBox with WidgetsBindingObserver {
  Game _game;

  Game get game => _game;

  set game(Game value) {
    if (_game == value) {
      return;
    }

    _game = value;
  }

  Duration _previous = Duration.zero;

  late final Ticker _ticker;

  ui.Image? _bufferImage;

  GameRenderBox(
    this._game,
  ) {
    _ticker = Ticker(_tick);
    _ticker.start();
  }

  @override
  bool get isRepaintBoundary => true;

  @override
  bool get sizedByParent => true;

  @override
  Size computeDryLayout(BoxConstraints constraints) => constraints.biggest;

  void _tick(Duration timestamp) {
    final durationDelta = timestamp - _previous;
    final dt = durationDelta.inMicroseconds / Duration.microsecondsPerSecond;
    _previous = timestamp;

    game.update(dt);
    render();
  }

  void render() {
    if (hasSize == false) {
      return;
    }

    final buffer = Canvas(size.width.toInt(), size.height.toInt());

    game.render(buffer);

    buffer.decodeImage((image) {
      _bufferImage = image;
      markNeedsPaint();
    });
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    final buffer = _bufferImage;
    if (buffer != null) {
      context.canvas.drawImage(buffer, offset, Paint());
    }
  }

  @override
  void dispose() {
    _ticker.dispose();
    super.dispose();
  }
}
