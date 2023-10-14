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
  void setScaledPixel(
    int x,
    int y,
    int scale,
    int r,
    int g,
    int b, [
    int a = 255,
  ]) {
    for (int sy = 0; sy < scale; sy++) {
      for (int sx = 0; sx < scale; sx++) {
        setPixel(x * scale + sx, y * scale + sy, r, g, b, a);
      }
    }
  }
}
