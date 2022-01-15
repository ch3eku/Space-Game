import 'package:flame/components.dart';
import 'package:flame/geometry.dart';
import 'package:flutter_game/game/enemy.dart';
import 'package:flutter_game/game/game.dart';

class Bullet extends SpriteComponent
    with HasGameRef<SpaceGame>, HasHitboxes, Collidable {
  Bullet({Sprite? sprite, Vector2? size, Vector2? position})
      : super(sprite: sprite, size: size, position: position);

  final double _speed = 450;

  @override
  void onMount() {
    super.onMount();
    addHitbox(HitboxCircle(normalizedRadius: .3));
  }

  // @override
  // void render(Canvas canvas) {
  //   super.render(canvas);
  //   renderHitboxes(canvas);
  // }

  @override
  void onCollision(Set<Vector2> intersectionPoints, Collidable other) {
    super.onCollision(intersectionPoints, other);
    if (other is Enemy) {
      gameRef.remove(this);
    }
  }

  @override
  void update(double dt) {
    super.update(dt);
    position += Vector2(0, -1) * _speed * dt;
    if (position.y < 0) {
      remove(this);
    }
  }
}
