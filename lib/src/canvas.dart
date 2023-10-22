import 'dart:math';
import 'dart:typed_data';
import 'dart:ui';

import 'package:clutter/src/int_extension.dart';

typedef IPoint = Point<int>;

extension PointExtension on Point<double> {
  IPoint toIPoint() => IPoint(x.floor(), y.floor());
}

class Canvas {
  final int width;
  final int height;
  final Uint8List pixels;

  Canvas(this.width, this.height) : pixels = Uint8List(width * height * 4);

  void clear() {
    pixels.fillRange(0, pixels.length, 0);
  }

  void _setPixel(
    int x,
    int y,
    int r,
    int g,
    int b,
    int a,
  ) {
    final index = y * width * 4 + x * 4;
    pixels[index + 0] = r;
    pixels[index + 1] = g;
    pixels[index + 2] = b;
    pixels[index + 3] = a;
  }

  void setPixel(
    IPoint p,
    int color,
  ) {
    _setPixel(p.x, p.y, color.r, color.g, color.b, color.a);
  }

  void decodeImage(void Function(Image) callback) {
    decodeImageFromPixels(
      pixels,
      width,
      height,
      PixelFormat.rgba8888,
      callback,
    );
  }
}

extension CanvasDrawExtension on Canvas {
  void drawLine(
    IPoint p1,
    IPoint p2,
    int color,
  ) {
    IPoint dp = p2 - p1;
    int dist = p1.distanceTo(p2).floor();

    for (int i = 0; i < dist; i++) {
      int x = p1.x + ((dp.x * i) / dist).floor();
      int y = p1.y + ((dp.y * i) / dist).floor();
      setPixel(IPoint(x, y), color);
    }
  }

  void fillRect(
    IPoint p1,
    IPoint p2,
    int color,
  ) {
    for (int y = p1.y; y < p2.y; y++) {
      for (int x = p1.x; x < p2.x; x++) {
        setPixel(IPoint(x, y), color);
      }
    }
  }

  void fillEllipse(
    IPoint p1,
    IPoint p2,
    int color,
  ) {
    int cx = (p1.x + p2.x) ~/ 2;
    int cy = (p1.y + p2.y) ~/ 2;

    for (int y = p1.y; y < p2.y; y++) {
      for (int x = p1.x; x < p2.x; x++) {
        if (((x - cx) * (x - cx) / (p2.x - cx) / (p2.x - cx) +
                (y - cy) * (y - cy) / (p2.y - cy) / (p2.y - cy)) <=
            1) {
          setPixel(IPoint(x, y), color);
        }
      }
    }
  }

  void fillCircle(
    IPoint center,
    int radius,
    int color,
  ) {
    int cx = center.x;
    int cy = center.y;

    for (int y = cy - radius; y < cy + radius; y++) {
      for (int x = cx - radius; x < cx + radius; x++) {
        if (((x - cx) * (x - cx) + (y - cy) * (y - cy)) <= radius * radius) {
          setPixel(IPoint(x, y), color);
        }
      }
    }
  }
}
