import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:socialui/Constance/constance.dart' as constance;

class AppTheme {
  static bool isLightTheme = true;

  static ThemeData getTheme() {
    if (isLightTheme) {
      return lightTheme();
    } else {
      return lightTheme();
    }
  }

  static TextTheme _buildTextTheme(TextTheme base) {
    return base.copyWith(
      headline6: GoogleFonts.ubuntu(
          textStyle: TextStyle(
              color: base.headline6!.color,
              fontSize: 20,
              fontWeight: FontWeight.w500)),
      subtitle1: GoogleFonts.ubuntu(
          textStyle: TextStyle(color: base.subtitle1!.color, fontSize: 18)),
      subtitle2: GoogleFonts.ubuntu(
          textStyle: TextStyle(
              color: base.subtitle2!.color,
              fontSize: 14,
              fontWeight: FontWeight.w500)),
      bodyText2: GoogleFonts.ubuntu(
          textStyle: TextStyle(color: base.bodyText2!.color, fontSize: 16)),
      bodyText1: GoogleFonts.ubuntu(
          textStyle: TextStyle(color: base.bodyText1!.color, fontSize: 14)),
      button: GoogleFonts.ubuntu(
          textStyle: TextStyle(
              color: base.button!.color,
              fontSize: 14,
              fontWeight: FontWeight.w500)),
      caption: GoogleFonts.ubuntu(
          textStyle: TextStyle(color: base.caption!.color, fontSize: 12)),
      headline4: GoogleFonts.ubuntu(
          textStyle: TextStyle(color: base.headline4!.color, fontSize: 34)),
      headline3: GoogleFonts.ubuntu(
          textStyle: TextStyle(color: base.headline3!.color, fontSize: 48)),
      headline2: GoogleFonts.ubuntu(
          textStyle: TextStyle(color: base.headline2!.color, fontSize: 60)),
      headline1: GoogleFonts.ubuntu(
          textStyle: TextStyle(color: base.headline1!.color, fontSize: 96)),
      headline5: GoogleFonts.ubuntu(
          textStyle: TextStyle(color: base.headline5!.color, fontSize: 24)),
      overline: GoogleFonts.ubuntu(
          textStyle: TextStyle(color: base.overline!.color, fontSize: 10)),
    );
  }

  static ThemeData lightTheme() {
    Color primaryColor = HexColor(constance.primaryColorString);
    Color secondaryColor = HexColor(constance.secondaryColorString);
    final ColorScheme colorScheme = const ColorScheme.light().copyWith(
      primary: primaryColor,
      secondary: secondaryColor,
    );

    final ThemeData base = ThemeData.light();
    return base.copyWith(
        appBarTheme: AppBarTheme(color: Color.fromARGB(255, 28, 23, 23)),
        popupMenuTheme:
            PopupMenuThemeData(color: Color.fromARGB(255, 16, 14, 14)),
        colorScheme: colorScheme,
        primaryColor: primaryColor,
        // ignore: deprecated_member_use
        buttonColor: primaryColor,
        splashColor: Color.fromARGB(255, 26, 21, 21).withOpacity(0.1),
        hoverColor: Color.fromARGB(0, 255, 254, 254),
        splashFactory: InkRipple.splashFactory,
        highlightColor: Color.fromARGB(0, 253, 245, 245),
        // ignore: deprecated_member_use
        accentColor: primaryColor,
        canvasColor: Color.fromARGB(255, 16, 15, 15),
        scaffoldBackgroundColor: HexColor("#4D596F"),
        backgroundColor: secondaryColor,
        errorColor: Colors.red,
        textTheme: _buildTextTheme(base.textTheme),
        primaryTextTheme: _buildTextTheme(base.textTheme),
        platform: TargetPlatform.iOS,
        indicatorColor: primaryColor,
        disabledColor: HexColor("#D5D7D8"));
  }
}

class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}
