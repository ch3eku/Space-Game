import 'dart:math';

import 'package:flame/components.dart';
import 'package:flutter_game/game/game.dart';
import 'package:flutter_game/game/game_size.dart';

class Enemy extends SpriteComponent with GameSize, HasGameRef<SpaceGame> {
  Enemy({Sprite? sprite, Vector2? size, Vector2? position})
      : super(sprite: sprite, size: size, position: position) {
    angle = pi;
  }

  double speed = 200;

  @override
  void update(double dt) {
    super.update(dt);
    position += Vector2(0, 1) * speed * dt;
    if (position.y > gameSize.y) {
      remove(this);
    }
  }
}
