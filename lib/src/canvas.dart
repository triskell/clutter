import 'dart:math';
import 'dart:typed_data';
import 'dart:ui';

class Canvas {
  final int width;
  final int height;
  final Uint8List pixels;

  Canvas(this.width, this.height) : pixels = Uint8List(width * height * 4);

  void clear() {
    pixels.fillRange(0, pixels.length, 0);
  }

  void setPixel(
    int x,
    int y,
    int r,
    int g,
    int b, [
    int a = 255,
  ]) {
    final index = y * width * 4 + x * 4;
    pixels[index + 0] = r;
    pixels[index + 1] = g;
    pixels[index + 2] = b;
    pixels[index + 3] = a;
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
    int x1,
    int y1,
    int x2,
    int y2,
    int r,
    int g,
    int b, [
    int a = 255,
  ]) {
    int dx = x2 - x1;
    int dy = y2 - y1;
    int dd = sqrt((dx * dx) + (dy * dy)).floor();

    for (int i = 0; i < dd; i++) {
      int x = x1 + ((dx * i) / dd).floor();
      int y = y1 + ((dy * i) / dd).floor();
      setPixel(x, y, r, g, b, a);
    }
  }

  void fillRect(
    int x1,
    int y1,
    int x2,
    int y2,
    int r,
    int g,
    int b, [
    int a = 255,
  ]) {
    for (int y = y1; y < y2; y++) {
      for (int x = x1; x < x2; x++) {
        setPixel(x, y, r, g, b, a);
      }
    }
  }

  void fillEllipse(
    int x1,
    int y1,
    int x2,
    int y2,
    int r,
    int g,
    int b, [
    int a = 255,
  ]) {
    int cx = (x1 + x2) ~/ 2;
    int cy = (y1 + y2) ~/ 2;

    for (int y = y1; y < y2; y++) {
      for (int x = x1; x < x2; x++) {
        if (((x - cx) * (x - cx) / (x2 - cx) / (x2 - cx) +
                (y - cy) * (y - cy) / (y2 - cy) / (y2 - cy)) <=
            1) {
          setPixel(x, y, r, g, b, a);
        }
      }
    }
  }
}
