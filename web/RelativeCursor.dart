import 'Cursor.dart';
import 'RGBA.dart';
import 'IMap.dart';
import 'XY.dart';

class RelativeCursor extends Cursor {
  var positions = [];

  RelativeCursor(num x, num y): super(x, y) {
    positions.add(new XY(x, y));
  }
  
  
  num r = 50;
  num g = 127;
  num b = 50;
  
  num dx = 0;
  num dy = 0;
  
  num dg = 0;

  execute(map) {
    for(var i = 0; i < 2; i++) {
      updatePosition(map);
    }
  }
  
  updatePosition(IMap map) {
    var newPositions = [];
    
    positions.forEach((xyo) {  
      var directions = map.getAllDirections(xyo.x, xyo.y);
      
      directions.removeWhere((xy) => positions.length > 10 && onceIn(2) && !map.isEmpty(xyo.x + xy.x, xyo.y + xy.y));

      directions.forEach(
          (xy) => map.set(xyo.x + xy.x, xyo.y + xy.y, new RGBA(r, g, b, 255))
      );
      
      
      directions.forEach((xy) => newPositions.add(new XY(xyo.x + xy.x, xyo.y + xy.y)));
    
    });
    
    newPositions.forEach((xy) => positions.add(xy));
    positions.shuffle();
    
    if(positions.length > 100)
      positions.removeRange(100, positions.length - 1);
    
    g += randomDelta();
    
    x += positions[0].x;
    y += positions[0].y;
  }
}
