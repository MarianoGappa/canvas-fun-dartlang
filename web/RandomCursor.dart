import 'Cursor.dart';

class RandomCursor extends Cursor {
  RandomCursor(num x, num y): super(x, y);

  num dx = 0;
  num dy = 0;

  execute(map) {
    for(var i = 0; i < 100; i++)
      updatePosition(map);
  }
  
  updatePosition(map) {
    dx = randomDelta();
    dy = randomDelta();
    
    if(map.inBounds(x + dx, y + dy)) {
      x = x + dx;
      y = y + dy;    
      map.set(x, y, randomColor());
    }    
  }
}
