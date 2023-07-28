import 'package:flutter/material.dart';

class ThemeHelper {
  static ColorScheme colors(Brightness brightness, Color targetColor) =>
      ColorScheme.fromSeed(seedColor: targetColor, brightness: brightness);

  static ShapeBorder? roundedEdge = RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(15),
  );

  static DialogTheme dialogTheme = DialogTheme(shape: roundedEdge);
  static CardTheme cardTheme = CardTheme(
    shape: roundedEdge,
    elevation: 5,
  );

  static AppBarTheme appBarTheme(ColorScheme colorScheme) => AppBarTheme(
        backgroundColor: colorScheme.surface,
        foregroundColor: colorScheme.onSurface,
        elevation: 0,
        titleTextStyle: TextStyle(
          color: colorScheme.onSurface,
          fontWeight: FontWeight.bold,
          letterSpacing: 0.5,
          fontSize: 18,
        ),
        centerTitle: true,
      );

  static InputDecorationTheme inputDecoration(ColorScheme colorScheme) =>
      InputDecorationTheme(
        labelStyle: const TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w500,
        ),
        prefixIconColor: colorScheme.secondary,
        suffixIconColor: colorScheme.onSurface,
        focusedBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(Radius.circular(15)),
          borderSide: BorderSide(color: colorScheme.primary),
        ),
        enabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(15)),
          borderSide: BorderSide(color: Colors.grey),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: colorScheme.error, width: 2),
          borderRadius: const BorderRadius.all(Radius.circular(15)),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: colorScheme.error, width: 2),
          borderRadius: const BorderRadius.all(Radius.circular(15)),
        ),
      );

  static TextTheme textTheme(ColorScheme colorScheme) => TextTheme(
        titleSmall: TextStyle(color: colorScheme.onSurface),
        bodyMedium: TextStyle(color: colorScheme.onSurface),
        labelLarge: TextStyle(color: colorScheme.onSurface),
        labelMedium: TextStyle(color: colorScheme.onSurface),
        titleMedium: TextStyle(color: colorScheme.onSurface),
        titleLarge: TextStyle(color: colorScheme.onSurface),
        displayMedium: TextStyle(color: colorScheme.onSurface),
        displaySmall: TextStyle(color: colorScheme.onSurface),
        headlineSmall: TextStyle(
          color: colorScheme.onSurface,
          fontWeight: FontWeight.bold,
        ),
      ).apply(fontFamily: 'Poppins');

  static ThemeData lightTheme(Color targetColor) {
    final ColorScheme colorScheme = colors(Brightness.light, targetColor);
    return ThemeData.light(useMaterial3: true).copyWith(
      dialogTheme: dialogTheme,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: colorScheme.background,
      inputDecorationTheme: inputDecoration(colorScheme),
      cardTheme: cardTheme,
      appBarTheme: appBarTheme(colorScheme),
      textTheme: textTheme(colorScheme),
    );
  }
}
