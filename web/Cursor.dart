import "dart:math";
import 'RGBA.dart';
import 'IMap.dart';

abstract class Cursor {
  num x;
  num y;
  Random rng;
  
  Cursor(num this.x, num this.y) {
    rng = new Random();
  }
  
  execute(IMap map);
  
  RGBA randomColor() => new RGBA(rng.nextInt(255), rng.nextInt(255), rng.nextInt(255), rng.nextInt(255));
  num randomDelta() => (rng.nextDouble() * 2).round() - 1;
  num euclidianDistance(num x1, num y1, num x2, num y2) => sqrt(pow(x1 - x2, 2) + pow(y1 - y2, 2));
  bool onceIn(num i) => (rng.nextDouble() * i).round() == 0;
}


