import 'package:flutter/material.dart';

var myTheme = ThemeData.dark().copyWith(
    useMaterial3: true,
    colorScheme: ColorScheme.dark(
        primary: Color.fromARGB(255, 6, 226, 178),
        onPrimary: Color.fromARGB(255, 0, 0, 0)),
    listTileTheme: ListTileThemeData(
        style: ListTileStyle.drawer,
        tileColor: Color.fromARGB(255, 0, 0, 0),
        selectedColor: Color.fromARGB(255, 2, 168, 132)));
