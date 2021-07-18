import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final AppBarTheme darkAppBarTheme = AppBarTheme(
  centerTitle: true,
  brightness: Brightness.dark,
  elevation: 0,
);

final AppBarTheme lightAppBarTheme = AppBarTheme(
  centerTitle: true,
  brightness: Brightness.light,
  elevation: 0,
);

final ColorScheme darkColorScheme = ColorScheme.dark(
  primary: Color(0xFF2A9D8F),
  primaryVariant: Color(0xFF264653),
  secondary: Color(0xFFE9C46A),
  secondaryVariant: Color(0xFFF4A261),
  background: Color(0xFF121B19),
  surface: Color(0xFF111615),
  onPrimary: Color(0xFFFFFFFF),
  onSecondary: Color(0xFF000000),
  onBackground: Color(0xFFFFFFFF),
  onSurface: Color(0xFFFFFFFF),
  onError: Color(0xFFFFFFFF),
  error: Color(0xFFE76F51),
);

final ColorScheme lightColorScheme = ColorScheme.light(
  primary: Color(0xFF2A9D8F),
  primaryVariant: Color(0xFF264653),
  secondary: Color(0xFFE9C46A),
  secondaryVariant: Color(0xFFF4A261),
  background: Color(0xFFF4F9F8),
  surface: Color(0xFFFDFEFE),
  onPrimary: Color(0xFFFFFFFF),
  onSecondary: Color(0xFF000000),
  onBackground: Color(0xFF000000),
  onSurface: Color(0xFF000000),
  onError: Color(0xFFFFFFFF),
  error: Color(0xFFE76F51),
);

final ThemeData darkThemeData = ThemeData(
  colorScheme: darkColorScheme,
  primaryColor: Color(0xFF2A9D8F),
  primaryColorDark: Color(0xFF227E72),
  primaryColorLight: Color(0xFF7FC4BC),
  secondaryHeaderColor: Color(0xFF8AC9C1),
  accentColor: Color(0xFF2A9D8F),
  toggleableActiveColor: Color(0xFFE9C46A),
  textSelectionTheme: TextSelectionThemeData(
    cursorColor: Color(0xFF2A9D8F),
    selectionColor: Color(0x802A9D8F),
    selectionHandleColor: Color(0xFF227E72),
  ),
  indicatorColor: Color(0xFFFFFFFF),
  bottomAppBarColor: Color(0xFF121B19),
  dividerColor: Color(0x1FFFFFFF),
  disabledColor: Color(0x62FFFFFF),
  backgroundColor: Color(0xFF121B19),
  canvasColor: Color(0xFF121B19),
  cardColor: Color(0xFF111615),
  dialogBackgroundColor: Color(0xFF111615),
  scaffoldBackgroundColor: Color(0xFF121212),
  errorColor: Color(0xFFE76F51),
  primaryColorBrightness: Brightness.dark,
  brightness: Brightness.dark,
  appBarTheme: darkAppBarTheme,
  textTheme: GoogleFonts.ralewayTextTheme(),
);

final ThemeData lightThemeData = ThemeData(
  colorScheme: lightColorScheme,
  primaryColor: Color(0xFF2A9D8F),
  primaryColorDark: Color(0xFF1D6E64),
  primaryColorLight: Color(0xFF7FC4BC),
  secondaryHeaderColor: Color(0xFF8AC9C1),
  accentColor: Color(0xFF2A9D8F),
  toggleableActiveColor: Color(0xFFE9C46A),
  textSelectionTheme: TextSelectionThemeData(
    cursorColor: Color(0xFF2A9D8F),
    selectionColor: Color(0x4D2A9D8F),
    selectionHandleColor: Color(0xFF1D6E64),
  ),
  indicatorColor: Color(0xFFFFFFFF),
  bottomAppBarColor: Color(0xFFF4F9F8),
  dividerColor: Color(0x1F000000),
  disabledColor: Color(0x61000000),
  backgroundColor: Color(0xFFF4F9F8),
  canvasColor: Color(0xFFF4F9F8),
  cardColor: Color(0xFFFDFEFE),
  dialogBackgroundColor: Color(0xFFFDFEFE),
  scaffoldBackgroundColor: Color(0xFFFFFFFF),
  errorColor: Color(0xFFE76F51),
  primaryColorBrightness: Brightness.light,
  brightness: Brightness.light,
  appBarTheme: lightAppBarTheme,
  textTheme: GoogleFonts.ralewayTextTheme(),
);
