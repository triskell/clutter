extension ColorExtension on int {
  int get a => (this >> 24) & 0xFF;
  int get r => (this >> 16) & 0xFF;
  int get g => (this >> 8) & 0xFF;
  int get b => this & 0xFF;
}
