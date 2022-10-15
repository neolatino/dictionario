import 'package:flutter/material.dart';

abstract class Style {
  static const Color colorPrimary = Pink;
  static const Color colorOnPrimary = Colors.white;
  static const Color colorSecondary = DarkPink;
  static const Color colorOnSecondary = Colors.white;
  static const Color colorSurface = DarkPink;
  static const Color colorOnSurface = Colors.white;
  static const Color colorAccent = Gold;

  static const Pink = Color.fromARGB(255, 165, 0, 35);
  static const Pink2 = Color.fromARGB(255, 130, 0, 28);
  static const DarkPink = Color.fromARGB(255, 115, 0, 25);
  static const DarkerPink = Color.fromARGB(255, 77, 0, 23);

  static const Ink = Color.fromARGB(255, 23, 23, 23);
  static const DarkBurgundy = Color.fromARGB(255, 80, 0, 18);
  static const Burgundy = Color.fromARGB(255, 160, 28, 53);
  static const Gold = Color.fromARGB(255, 255, 204, 0);
  static const DarkGold = Color.fromARGB(255, 190, 126, 2);
}
