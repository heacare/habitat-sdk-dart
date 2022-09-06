import 'package:flutter/material.dart'
    show
        ThemeData,
        ColorScheme,
        Color,
        Colors,
        Brightness,
        ThemeMode,
        SnackBarBehavior;
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart' show SystemUiOverlayStyle;
import 'package:flutter/widgets.dart' show WidgetsBinding;

/// For now, we're following Material Design 3. We are using
/// [dynamic color](https://m3.material.io/styles/color/dynamic-color/overview),
/// allowing users to pick their colour palette. Example code can be found
/// [here](https://github.com/material-foundation/material-dynamic-color-flutter/blob/main/example/lib/complete_example.dart)
///
/// Eventually, we should customize this theme to fit our brand better

final ColorScheme _lightColorSchemeFallback = ColorScheme.fromSeed(
  seedColor: const Color(0xFFFF9900),
  primary: const Color(0xFFFF9900),
  onPrimary: const Color(0xFFFFFFFF),
  // Not really inverse of primary
  inversePrimary: const Color(0xFFFF9900),
);
final ColorScheme _darkColorSchemeFallback = ColorScheme.fromSeed(
  brightness: Brightness.dark,
  seedColor: const Color(0xFFFF9900),
  primary: const Color(0xFFFF9900),
  onPrimary: const Color(0xFFFFFFFF),
  // Not really inverse of primary
  inversePrimary: const Color(0xFFFF9900),
);

ThemeData resolveThemeData(
  final Brightness brightness,
  final ColorScheme? colorSchemeDynamic,
) {
  ColorScheme? colorScheme = colorSchemeDynamic;
  if (colorScheme == null) {
    switch (brightness) {
      case Brightness.light:
        colorScheme = _lightColorSchemeFallback;
        break;
      case Brightness.dark:
        colorScheme = _darkColorSchemeFallback;
        break;
    }
  }

  final ThemeData themeData = ThemeData.from(
    colorScheme: colorScheme,
    useMaterial3: true,
  );

  return themeData.copyWith(
    toggleableActiveColor: colorScheme.primary,
    // TODO(serverwentdown): Proper design
    snackBarTheme: themeData.snackBarTheme.copyWith(
      actionTextColor: colorScheme.inversePrimary,
      behavior: SnackBarBehavior.floating,
    ),
    bottomSheetTheme: themeData.bottomSheetTheme.copyWith(
      shape: _bottomSheetShape,
    ),
    tabBarTheme: themeData.tabBarTheme.copyWith(
      indicator: _tabBarIndicator(colorScheme),
      labelColor: colorScheme.primary,
      unselectedLabelColor: colorScheme.onSurface,
      labelStyle:
          themeData.textTheme.labelLarge!.copyWith(fontWeight: FontWeight.w500),
      unselectedLabelStyle:
          themeData.textTheme.labelLarge!.copyWith(fontWeight: FontWeight.w500),
    ),
  );
}

final SystemUiOverlayStyle _lightSystemUiOverlayStyle =
    SystemUiOverlayStyle.dark.copyWith(
  statusBarColor: Colors.transparent,
  systemNavigationBarColor: Colors.transparent,
  systemNavigationBarIconBrightness: Brightness.dark,
  systemNavigationBarContrastEnforced: false,
);
final SystemUiOverlayStyle _darkSystemUiOverlayStyle =
    SystemUiOverlayStyle.light.copyWith(
  statusBarColor: Colors.transparent,
  systemNavigationBarColor: Colors.transparent,
  systemNavigationBarIconBrightness: Brightness.light,
  systemNavigationBarContrastEnforced: false,
);

SystemUiOverlayStyle resolveOverlayStyle(final ThemeMode themeMode) {
  Brightness brightness;
  switch (themeMode) {
    case ThemeMode.light:
      brightness = Brightness.light;
      break;
    case ThemeMode.dark:
      brightness = Brightness.dark;
      break;
    case ThemeMode.system:
      brightness = WidgetsBinding.instance.window.platformBrightness;
  }

  return brightness == Brightness.light
      ? _lightSystemUiOverlayStyle
      : _darkSystemUiOverlayStyle;
}

// BottomSheet

const ShapeBorder _bottomSheetShape = RoundedRectangleBorder(
  borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
);

// TabBar

Decoration _tabBarIndicator(final ColorScheme colorScheme) => BoxDecoration(
      border: Border(
        bottom: BorderSide(
          width: 2,
          color: colorScheme.primary,
        ),
      ),
    );
