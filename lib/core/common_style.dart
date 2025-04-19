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
  static const TextStyle diaryFont = TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 20,
  );
  static const TextStyle diaryIconFont = TextStyle(
    fontSize: 13,
  );
  static const TextStyle bodyFont = TextStyle(
    color: primaryGray,
    fontSize: 16,
  );
  static const TextStyle guideFont =
      TextStyle(color: secondGray, fontSize: 16, height: 1.5);

  static const TextStyle labelFont = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w500,
  );
  static const TextStyle diaryLabelFont = TextStyle(
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
        backgroundColor: WidgetStateProperty.all<Color>(primaryGray),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        overlayColor:
            WidgetStateProperty.all<Color>(primaryGray.withValues(alpha: 0.3)),
        foregroundColor: WidgetStateProperty.all<Color>(primaryGray),
      ),
    ),
    fontFamily: gamja,
    primaryColor: primaryGray,
    scaffoldBackgroundColor: subGray,
    textTheme: const TextTheme(bodyMedium: bodyFont),
    iconTheme: const IconThemeData(color: primaryGray),
    useMaterial3: false,
  );

  static ButtonStyle basicBtn = ButtonStyle(
    backgroundColor: WidgetStateProperty.all<Color>(primaryGray),
    foregroundColor: WidgetStateProperty.all<Color>(subGray),
    fixedSize: WidgetStateProperty.all<Size>(const Size(200, 40)),
    textStyle: WidgetStateProperty.all<TextStyle>(
      TextStyle(fontSize: 18, fontFamily: GoogleFonts.gamjaFlower().fontFamily),
    ),
  );

  static ButtonStyle reverseBtn = ButtonStyle(
    backgroundColor: WidgetStateProperty.all<Color>(subGray),
    foregroundColor: WidgetStateProperty.all<Color>(primaryGray),
    fixedSize: WidgetStateProperty.all<Size>(const Size(200, 40)),
    textStyle: WidgetStateProperty.all<TextStyle>(
      TextStyle(fontSize: 18, fontFamily: GoogleFonts.gamjaFlower().fontFamily),
    ),
  );

  static calendarTheme(Widget child, BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        colorScheme: Theme.of(context).colorScheme.copyWith(
              primary: primaryGray,
            ),
      ),
      child: child,
    );
  }
}
