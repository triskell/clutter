import 'package:flutter_test/flutter_test.dart';

import 'package:clutter/clutter.dart';

void main() {
  test('Canvas instanciates blank', () {
    final canvas = Canvas(20, 20);

    const bytes = 20 * 20 * 4;
    expect(canvas.pixels.length, bytes);
    expect(canvas.pixels.where((i) => i == 0).length, bytes);
  });

  test('Draws a pixel on the Canvas', () {
    final canvas = Canvas(20, 20);
    canvas.setPixel(5, 7, 26, 45, 189);

    const pixelSize = 4;
    const index = 7 * 20 * pixelSize + 5 * pixelSize;
    expect(canvas.pixels[index - 1], 0);
    expect(canvas.pixels[index], 26);
    expect(canvas.pixels[index + 1], 45);
    expect(canvas.pixels[index + 2], 189);
    expect(canvas.pixels[index + 3], 255);
    expect(canvas.pixels[index + 4], 0);
  });
}
