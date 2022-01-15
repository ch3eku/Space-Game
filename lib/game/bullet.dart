import 'package:flame/components.dart';

class Bullet extends SpriteComponent {
  Bullet({Sprite? sprite, Vector2? size, Vector2? position})
      : super(sprite: sprite, size: size, position: position);

  final double _speed = 450;

  @override
  void update(double dt) {
    super.update(dt);
    position += Vector2(0, -1) * _speed * dt;
    if (position.y < 0) {
      remove(this);
    }
  }
}
