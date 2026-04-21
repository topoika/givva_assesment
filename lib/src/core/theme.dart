import 'package:flutter/material.dart';

ThemeData lightTheme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.light,
  primarySwatch: Colors.blue,
  primaryColor: Colors.blue,
  colorScheme: const ColorScheme.light(
    primary: Colors.blue,
    onPrimary: Color(0xFF0B2A2C),
    secondary: Colors.orange,
    onSecondary: Color(0xFF3A2200),
    surface: Colors.white,
    onSurface: Color(0xFF0B2A2C),
  ),
  scaffoldBackgroundColor: Colors.white,
  appBarTheme: AppBarThemeData(
    backgroundColor: Colors.transparent,
    elevation: 0,
    
    iconTheme: const IconThemeData(color: Colors.black),
    titleTextStyle: const TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.w600,
      fontSize: 17,
    ),
  ),
);

// context extension to get theme
extension ThemeContext on BuildContext {
  ThemeData get theme => Theme.of(this);
  double get width => MediaQuery.of(this).size.width;
  Color get primaryColor => theme.colorScheme.primary;
  double get height => MediaQuery.of(this).size.height;
  EdgeInsets get padding => MediaQuery.of(this).padding;
  double get statusBarHeight => MediaQuery.of(this).padding.top;
  double get bottomBarHeight => MediaQuery.of(this).padding.bottom;
}

extension StringExtension on String {
  String toTitleCase() => split(' ')
      .map(
        (word) => word.isNotEmpty
            ? word[0].toUpperCase() + word.substring(1).toLowerCase()
            : '',
      )
      .join(' ');
}
