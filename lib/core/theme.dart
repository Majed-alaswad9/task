import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Color primaryColor = const Color(0xFF0C7075);

final theme = ThemeData(
  useMaterial3: true,
  scaffoldBackgroundColor: const Color(0xFF0E1621),
  cardColor: const Color(0xFF242F3D),
  listTileTheme: const ListTileThemeData(
    textColor: Colors.white,
  ),
  appBarTheme: AppBarTheme(
      centerTitle: true,
      color: primaryColor,
      titleTextStyle: const TextStyle(color: Colors.white, fontSize: 20),
      actionsIconTheme: const IconThemeData(color: Colors.white),
      //backgroundColor: primaryColor,
      systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: primaryColor,
          statusBarIconBrightness: Brightness.light)),
);
