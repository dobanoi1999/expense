import 'package:flutter/material.dart';
import 'colors.dart';
import 'typography.dart';

ThemeData get lightTheme {
  return ThemeData(
    useMaterial3: true,
    fontFamily: FontFamilies.sans,
    brightness: Brightness.light,

    // Color scheme
    colorScheme: ColorScheme.fromSeed(
      seedColor: MyColors.primary,
      brightness: Brightness.light,
    ),

    // Scaffold background
    scaffoldBackgroundColor: MyColors.background,

    // App bar theme
    appBarTheme: AppBarTheme(
      backgroundColor: MyColors.primary,
      foregroundColor: MyColors.primaryForeground,
      elevation: 0,
      centerTitle: true,
    ),
    buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.accent),
    // Text themes
    textTheme: TextTheme(
      displayLarge: TextStyle(
        fontFamily: FontFamilies.heading,
        fontSize: FontSizes.display1,
        fontWeight: FontWeights.bold,
        color: MyColors.foreground,
      ),
      displayMedium: TextStyle(
        fontFamily: FontFamilies.heading,
        fontSize: FontSizes.display2,
        fontWeight: FontWeights.bold,
        color: MyColors.foreground,
      ),
      displaySmall: TextStyle(
        fontFamily: FontFamilies.heading,
        fontSize: FontSizes.display3,
        fontWeight: FontWeights.bold,
        color: MyColors.foreground,
      ),
      headlineMedium: TextStyle(
        fontFamily: FontFamilies.heading,
        fontSize: FontSizes.heading1,
        fontWeight: FontWeights.semibold,
        color: MyColors.foreground,
      ),
      headlineSmall: TextStyle(
        fontFamily: FontFamilies.heading,
        fontSize: FontSizes.heading2,
        fontWeight: FontWeights.semibold,
        color: MyColors.foreground,
      ),
      titleLarge: TextStyle(
        fontFamily: FontFamilies.heading,
        fontSize: FontSizes.heading3,
        fontWeight: FontWeights.semibold,
        color: MyColors.foreground,
      ),
      bodyLarge: TextStyle(
        fontFamily: FontFamilies.sans,
        fontSize: FontSizes.body1,
        color: MyColors.foreground,
      ),
      bodyMedium: TextStyle(
        fontFamily: FontFamilies.sans,
        fontSize: FontSizes.body2,
        color: MyColors.foreground,
      ),
      bodySmall: TextStyle(
        fontFamily: FontFamilies.sans,
        fontSize: FontSizes.body3,
        color: MyColors.mutedForeground,
      ),
      labelLarge: TextStyle(
        fontFamily: FontFamilies.sans,
        fontSize: FontSizes.label,
        fontWeight: FontWeights.semibold,
        color: MyColors.foreground,
      ),
    ),

    // Card theme
    cardTheme: CardThemeData(
      color: MyColors.card,
      surfaceTintColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Radius.radiusLg),
        side: BorderSide(color: MyColors.border),
      ),
      elevation: 0,
    ),

    // Button themes
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: MyColors.primary,
        foregroundColor: MyColors.primaryForeground,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Radius.radiusMd),
        ),
        textStyle: TextStyle(
          fontFamily: FontFamilies.sans,
          fontWeight: FontWeights.semibold,
        ),
      ),
    ),

    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: MyColors.primary,
        side: BorderSide(color: MyColors.border),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Radius.radiusMd),
        ),
        textStyle: TextStyle(
          fontFamily: FontFamilies.sans,
          fontWeight: FontWeights.semibold,
        ),
      ),
    ),

    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: MyColors.primary,
        textStyle: TextStyle(
          fontFamily: FontFamilies.sans,
          fontWeight: FontWeights.semibold,
        ),
      ),
    ),

    // Input decoration theme
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: MyColors.input,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(Radius.radiusMd),
        borderSide: BorderSide(color: MyColors.border),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(Radius.radiusMd),
        borderSide: BorderSide(color: MyColors.border),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(Radius.radiusMd),
        borderSide: BorderSide(color: MyColors.ring, width: 2),
      ),
      contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
    ),
  );
}

ThemeData get darkTheme {
  return ThemeData(
    useMaterial3: true,
    fontFamily: FontFamilies.sans,
    brightness: Brightness.dark,

    // Color scheme
    colorScheme: ColorScheme.fromSeed(
      seedColor: MyColorsDark.primary,
      brightness: Brightness.dark,
    ),

    // Scaffold background
    scaffoldBackgroundColor: MyColorsDark.background,

    // App bar theme
    appBarTheme: AppBarTheme(
      backgroundColor: MyColorsDark.primaryForeground,
      foregroundColor: MyColorsDark.primary,
      elevation: 0,
      centerTitle: true,
    ),
    buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.accent),
    // Text themes
    textTheme: TextTheme(
      displayLarge: TextStyle(
        fontFamily: FontFamilies.heading,
        fontSize: FontSizes.display1,
        fontWeight: FontWeights.bold,
        color: MyColorsDark.foreground,
      ),
      displayMedium: TextStyle(
        fontFamily: FontFamilies.heading,
        fontSize: FontSizes.display2,
        fontWeight: FontWeights.bold,
        color: MyColorsDark.foreground,
      ),
      displaySmall: TextStyle(
        fontFamily: FontFamilies.heading,
        fontSize: FontSizes.display3,
        fontWeight: FontWeights.bold,
        color: MyColorsDark.foreground,
      ),
      headlineMedium: TextStyle(
        fontFamily: FontFamilies.heading,
        fontSize: FontSizes.heading1,
        fontWeight: FontWeights.semibold,
        color: MyColorsDark.foreground,
      ),
      headlineSmall: TextStyle(
        fontFamily: FontFamilies.heading,
        fontSize: FontSizes.heading2,
        fontWeight: FontWeights.semibold,
        color: MyColorsDark.foreground,
      ),
      titleLarge: TextStyle(
        fontFamily: FontFamilies.heading,
        fontSize: FontSizes.heading3,
        fontWeight: FontWeights.semibold,
        color: MyColorsDark.foreground,
      ),
      bodyLarge: TextStyle(
        fontFamily: FontFamilies.sans,
        fontSize: FontSizes.body1,
        color: MyColorsDark.foreground,
      ),
      bodyMedium: TextStyle(
        fontFamily: FontFamilies.sans,
        fontSize: FontSizes.body2,
        color: MyColorsDark.foreground,
      ),
      bodySmall: TextStyle(
        fontFamily: FontFamilies.sans,
        fontSize: FontSizes.body3,
        color: MyColorsDark.mutedForeground,
      ),
      labelLarge: TextStyle(
        fontFamily: FontFamilies.sans,
        fontSize: FontSizes.label,
        fontWeight: FontWeights.semibold,
        color: MyColorsDark.foreground,
      ),
    ),

    // Card theme
    cardTheme: CardThemeData(
      color: MyColorsDark.card,
      surfaceTintColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Radius.radiusLg),
        side: BorderSide(color: MyColorsDark.border),
      ),
      elevation: 0,
    ),

    // Button themes
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: MyColorsDark.primary,
        foregroundColor: MyColorsDark.primaryForeground,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Radius.radiusMd),
        ),
        textStyle: TextStyle(
          fontFamily: FontFamilies.sans,
          fontWeight: FontWeights.semibold,
        ),
      ),
    ),

    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: MyColorsDark.primary,
        side: BorderSide(color: MyColorsDark.border),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Radius.radiusMd),
        ),
        textStyle: TextStyle(
          fontFamily: FontFamilies.sans,
          fontWeight: FontWeights.semibold,
        ),
      ),
    ),

    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: MyColorsDark.primary,
        textStyle: TextStyle(
          fontFamily: FontFamilies.sans,
          fontWeight: FontWeights.semibold,
        ),
      ),
    ),

    // Input decoration theme
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: MyColorsDark.input,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(Radius.radiusMd),
        borderSide: BorderSide(color: MyColorsDark.border),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(Radius.radiusMd),
        borderSide: BorderSide(color: MyColorsDark.border),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(Radius.radiusMd),
        borderSide: BorderSide(color: MyColorsDark.ring, width: 2),
      ),
      contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
    ),
  );
}
