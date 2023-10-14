import 'package:flutter/widgets.dart';

import 'game.dart';
import 'game_render_box.dart';

class GameWidget extends StatelessWidget {
  const GameWidget({
    super.key,
    required Game game,
  }) : _game = game;

  final Game _game;

  @override
  Widget build(BuildContext context) {
    return FocusScope(
      child: Focus(
        autofocus: true,
        onKey: _game.onKeyboardEvent,
        child: _RenderGameWidget(game: _game),
      ),
    );
  }
}

class _RenderGameWidget extends LeafRenderObjectWidget {
  const _RenderGameWidget({
    super.key,
    required Game game,
  }) : _game = game;

  final Game _game;

  @override
  RenderBox createRenderObject(BuildContext context) {
    return GameRenderBox(_game);
  }

  @override
  void updateRenderObject(BuildContext context, GameRenderBox renderObject) {
    renderObject.game = _game;
  }
}
