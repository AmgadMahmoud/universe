import 'package:flutter/material.dart';

class MyColors {
  static Color primaryColor = HexColor("#2A5579");
  static Color primaryDarkColor = HexColor("#15567C");
  static Color accentColor = HexColor("#F26D33");
  static Color accentLightColor = HexColor("#FF7815");
  static Color backgroundGreyColor = HexColor("#F5F5F5");
  static Color textPrimaryColor = HexColor("#585858");
  static Color textPrimaryLightColor = HexColor("#9C9A99");
  static Color inputBackgroundColor = HexColor("#9CB3BE");
  static Color navigationColor = HexColor("#14141E");
  static Color drawerColor = HexColor("#398BAF");
  static Color whiteColor = HexColor("#FFFFFF");
  static Color commentColor = HexColor("#BECCD4");
}

class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF$hexColor";
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}
