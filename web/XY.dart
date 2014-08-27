class XY {
 num x;
 num y;
 
 XY(this.x, this.y) {}
 
 XY sum(num dx, num dy) => new XY(x + dx, y + dy); 
}