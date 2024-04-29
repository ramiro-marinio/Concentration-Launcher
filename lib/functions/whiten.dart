import 'dart:ui';

Color adjustWhiteness(Color color, double factor) {
  assert(factor >= 0 && factor <= 1, 'Factor must be between 0 and 1');

  // Interpolate between the original color and white based on the factor
  int red = (color.red + (255 - color.red) * factor).round();
  int green = (color.green + (255 - color.green) * factor).round();
  int blue = (color.blue + (255 - color.blue) * factor).round();

  // Return the new color
  return Color.fromARGB(255, red, green, blue);
}

Color adjustDarkness(Color color, double factor) {
  assert(factor >= 0 && factor <= 1, 'Factor must be between 0 and 1');

  // Absolute darkness color
  Color absoluteDarkness = const Color.fromARGB(255, 29, 29, 33);

  // Interpolate between the original color and absolute darkness based on the factor
  int red = (color.red * (1 - factor) + absoluteDarkness.red * factor).round();
  int green =
      (color.green * (1 - factor) + absoluteDarkness.green * factor).round();
  int blue =
      (color.blue * (1 - factor) + absoluteDarkness.blue * factor).round();

  // Return the new color
  return Color.fromARGB(255, red, green, blue);
}
