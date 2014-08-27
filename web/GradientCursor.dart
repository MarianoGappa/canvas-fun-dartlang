import 'Cursor.dart';
import 'RGBA.dart';

class GradientCursor extends Cursor {
  num sx;
  num sy;

  GradientCursor(num x, num y): super(x, y) {
    sx = x;
    sy = y;
  }

  num counter = 0;
  num radius = 3;
  num error = 3;
  
  num r = 127;
  num g = 127;
  num b = 127;
  
  num dx = 0;
  num dy = 0;
  
  num dr = 0;
  num dg = 0;
  num db = 0;

  execute(map) {
    for(var i = 0; i < 100; i++) {
      updatePosition(map);
      counter ++;
      if(counter == 1000) {
        radius ++;
        counter = 0;
      }
    }
  }
  
  updatePosition(map) {
    dx = randomDelta();
    dy = randomDelta();
    dr = randomDelta();
    dg = randomDelta();
    db = randomDelta();
    
    num distance = euclidianDistance(x + dx, y + dy, sx, sy);
    
    if(map.inBounds(x + dx, y + dy) && distance > radius - error && distance < radius + error) {
      x = x + dx;
      y = y + dy;
      
      r = colorInBounds(r + dr) ? r + dr : r;
      g = colorInBounds(g + dg) ? g + dg : g;
      b = colorInBounds(b + db) ? b + db : b;
      
      map.set(x, y, new RGBA(r, g, b, 255));
    }    
  }
  
  colorInBounds(num i) => i >= 0 && i <= 255;
}
