import 'package:clutter/clutter.dart';
import 'package:flutter/material.dart';
import 'package:statsfl/statsfl.dart';

import 'hello_game.dart';

void main() {
  runApp(
    StatsFl(
      isEnabled: true,
      align: Alignment.topRight,
      child: GameWidget(
        game: HelloGame(),
      ),
    ),
  );
}
