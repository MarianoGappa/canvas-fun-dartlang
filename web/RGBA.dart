class RGBA {
  num r;
  num g;
  num b;
  num a;
  
  RGBA(this.r, this.g, this.b, this.a);
  
  isEmpty() => (r == 0 && g == 0 && b == 0) || a == 0;
}