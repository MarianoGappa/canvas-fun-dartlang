import "dart:html";
import 'dart:async';
import 'dart:collection';
import 'Cursor.dart';
import 'IMap.dart';

import 'RandomCursor.dart';
import 'GradientCursor.dart';
import 'RelativeCursor.dart';
import 'XY.dart';

CanvasRenderingContext2D context;
Queue<Cursor> cursors = new Queue();
ImageData imgData;
IMap map;

main() {
  CanvasElement canvas = document.body.querySelector("#canvas");
  canvas.width = 500;
  canvas.height = 500;
  context = canvas.getContext("2d");
  
  Rectangle rect = canvas.getBoundingClientRect();
  XY clientBoundingRect = new XY(rect.left, rect.top);
  
  canvas.onClick.listen((e) {
    print("hi");
    num x =  e.client.x - clientBoundingRect.x;
    num y = e.client.y - clientBoundingRect.y;
    document.body.querySelector("#xy").setInnerHtml("(X, Y) = ($x, $y)");
    return new XY(x, y);
  } );
  
  imgData = context.createImageData(500, 500);
  map = new IMap(imgData);
  
  cursors.add(new RandomCursor(250, 250));
  cursors.add(new GradientCursor(50, 50));
  cursors.add(new RelativeCursor(0, 0));

  var timer = new Timer.periodic(new Duration(milliseconds:5), buildScreen);
  var timer2 = new Timer.periodic(new Duration(milliseconds:50), decreaseAlpha);
  
}

buildScreen(timer) {
  cursors.forEach((c) => c.execute(map));
  context.putImageData(imgData, 0, 0);
}

decreaseAlpha(timer) {
  var pix = imgData.data;
    var n = 1;
    // Loop over each pixel and set a transparent red.
    for (var i = 0; i < n; i += 4) {
      pix[i+3] = pix[i+3] > 0 ? pix[i+3] - 1 : pix[i+3]; // alpha channel
      n = pix.length;
    }  
}

buildCanvas() {
  var canvas = new Element.html('<canvas/>');
  canvas.width = 500;
  canvas.height = 500;
  
  return canvas;
}
