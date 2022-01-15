import 'dart:math';

import 'package:flame/components.dart';
import 'package:flutter_game/game/enemy.dart';
import 'package:flutter_game/game/game.dart';
import 'package:flutter_game/game/game_size.dart';

class EnemyManager extends Component with GameSize, HasGameRef<SpaceGame> {
  late Timer timer;
  Random random = Random();

  EnemyManager() : super() {
    timer = Timer(1, onTick: _enemySpawn, repeat: true);
  }
  void _enemySpawn() async {
    Vector2 initialSize = Vector2(64, 64);
    Vector2 position = Vector2(random.nextDouble() * gameSize.x, 0);
    position.clamp(
        Vector2.zero() + initialSize / 2, gameSize - initialSize / 2);
    final sprite = await Sprite.load('enemy_A.png');
    final size = initialSize;

    // screen coordinates
    Enemy enemy = Enemy(sprite: sprite, size: size, position: position);
    enemy.anchor = Anchor.center;
    gameRef.add(enemy);
  }

  @override
  void onMount() {
    super.onMount();
    timer.start();
  }

  @override
  void onRemove() {
    super.onRemove();
    timer.stop();
  }

  @override
  void update(double dt) {
    super.update(dt);
    timer.update(dt);
  }
}
