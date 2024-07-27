import 'package:flutter/material.dart';

ThemeData buildThemeData() {
  return ThemeData(
      elevatedButtonTheme: const ElevatedButtonThemeData(
          style: ButtonStyle(
              elevation: WidgetStatePropertyAll(3),
              backgroundColor: WidgetStatePropertyAll(Color(0xff003466)),
              textStyle: WidgetStatePropertyAll(TextStyle(color: Colors.white)),
              shape: WidgetStatePropertyAll(
                ContinuousRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10))),
              ))));
}
