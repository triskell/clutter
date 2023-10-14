import 'package:flutter/widgets.dart';

import 'canvas.dart';

abstract class Game {
  /// Handles a keyboard event.
  KeyEventResult onKeyboardEvent(FocusNode node, RawKeyEvent event);

  /// Updates the game state.
  void update(double dt);

  /// Render the game.
  void render(Canvas canvas);
}
