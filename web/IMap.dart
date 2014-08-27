import 'dart:html';
import 'RGBA.dart';
import 'XY.dart';

class IMap {
  ImageData imgdata;
  
  IMap(this.imgdata);
  
  RGBA get(num x, num y) {
    num pos = xyToPos(x, y);
    return new RGBA(imgdata.data[pos], imgdata.data[pos + 1], imgdata.data[pos + 2], imgdata.data[pos + 3]);
  }
  
  set(num x, num y, RGBA color) {
    num pos = xyToPos(x, y);
    imgdata.data[pos] = color.r;
    imgdata.data[pos + 1] = color.g;
    imgdata.data[pos + 2] = color.b;
    imgdata.data[pos + 3] = color.a;
  }
  
  xyToPos(num x, num y) => (y * 4 * imgdata.width) + x * 4;
  
  bool inBounds(num x, num y) => x >= 0 && y >= 0 && x < 500 && y < 500;
  
  isEmpty(num x, num y) => get(x, y).isEmpty();
  
  getAllDirections(num x, num y) { 
    var directions = [new XY(-1, -1), new XY(0, -1), new XY(1, -1), new XY(-1, 0), new XY(1, 0), new XY(-1, 1), new XY(0, 1), new XY(1, 1)];
    directions.removeWhere(
        (xy) => inBounds(x + xy.x, y + xy.y) == false
    );
    print(directions);
    return directions;
  }
}