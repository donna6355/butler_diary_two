import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CommonStyle {
  CommonStyle._();

  static const Color primaryGray = Color(0xff454442);
  static const Color secondGray = Color(0xff95948D);
  static const Color subGray = Color(0xffE5E4DB);
  static final String? gamja = GoogleFonts.gamjaFlower().fontFamily;

  static TextStyle basicFont = TextStyle(
    color: primaryGray,
    fontFamily: gamja,
    fontSize: 20,
  );
  static const TextStyle bodyFont = TextStyle(
    color: primaryGray,
    fontSize: 16,
  );

  static const TextStyle labelFont = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w500,
  );

  static InputDecoration underlineInput(String hint) {
    return InputDecoration(
      hintText: hint,
      counterText: '',
      focusedBorder: const UnderlineInputBorder(
        borderSide: BorderSide(color: CommonStyle.primaryGray, width: 2.0),
      ),
    );
  }

  static ThemeData theme = ThemeData(
    datePickerTheme:
        const DatePickerThemeData(headerBackgroundColor: primaryGray),
    appBarTheme: AppBarTheme(
      color: subGray,
      iconTheme: const IconThemeData(color: primaryGray),
      titleTextStyle: basicFont,
    ),
    snackBarTheme:
        SnackBarThemeData(contentTextStyle: TextStyle(fontFamily: gamja)),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(primaryGray),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        overlayColor:
            MaterialStateProperty.all<Color>(primaryGray.withOpacity(0.3)),
        foregroundColor: MaterialStateProperty.all<Color>(primaryGray),
      ),
    ),
    fontFamily: gamja,
    primaryColor: primaryGray,
    scaffoldBackgroundColor: subGray,
    textTheme: const TextTheme(bodyMedium: bodyFont),
    iconTheme: const IconThemeData(color: primaryGray),
  );

  static ButtonStyle basicBtn = ButtonStyle(
    backgroundColor: MaterialStateProperty.all<Color>(primaryGray),
    foregroundColor: MaterialStateProperty.all<Color>(subGray),
    fixedSize: MaterialStateProperty.all<Size>(const Size(200, 40)),
    textStyle: MaterialStateProperty.all<TextStyle>(
      TextStyle(fontSize: 18, fontFamily: GoogleFonts.gamjaFlower().fontFamily),
    ),
  );

  static ButtonStyle reverseBtn = ButtonStyle(
    backgroundColor: MaterialStateProperty.all<Color>(subGray),
    foregroundColor: MaterialStateProperty.all<Color>(primaryGray),
    fixedSize: MaterialStateProperty.all<Size>(const Size(200, 40)),
    textStyle: MaterialStateProperty.all<TextStyle>(
      TextStyle(fontSize: 18, fontFamily: GoogleFonts.gamjaFlower().fontFamily),
    ),
  );
}
