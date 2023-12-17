import 'package:flutter/material.dart';

const Color _customColor = Color.fromARGB(255, 158, 87, 170);

const List<Color> _colorThemes = [_customColor];

class AppTheme {
  final int selectedColor;

  AppTheme({required this.selectedColor})
      : assert(selectedColor >= 0 && selectedColor < _colorThemes.length,
            'Color must be between 0 and ${_colorThemes.length}');

  ThemeData theme() {
    return ThemeData(
        useMaterial3: true, colorSchemeSeed: _colorThemes[selectedColor]);
  }
}
