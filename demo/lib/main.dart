import 'dart:async' show unawaited;

import 'package:dynamic_color/dynamic_color.dart' show DynamicColorBuilder;
import 'package:flutter/material.dart'
    show MaterialApp, ThemeData, Brightness, ColorScheme;
import 'package:flutter/services.dart' show SystemChrome, SystemUiMode;
import 'package:flutter/widgets.dart' hide Navigator;
import 'package:provider/provider.dart'
    show Provider, MultiProvider, ChangeNotifierProvider;

import 'features/preferences/preferences.dart' show Preferences, AppPreferences;
import 'navigator.dart';
import 'system/theme.dart' show resolveThemeData, resolveOverlayStyle;

void main() async {
  //await crashloggerWrap(() async {
  WidgetsFlutterBinding.ensureInitialized();
  //}, () async {
  // TODO(serverwentdown): Improve shared_preferences and sqflite startup time
  final Preferences preferences = await AppPreferences.load();
  unawaited(
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.edgeToEdge,
    ),
  );
  runApp(
    App(
      preferences: preferences,
    ),
  );
  //});
}

class App extends StatelessWidget {
  const App({
    super.key,
    required this.preferences,
  });

  final Preferences preferences;

  @override
  Widget build(final BuildContext context) => DynamicColorBuilder(
        builder:
            (final ColorScheme? lightDynamic, final ColorScheme? darkDynamic) {
          final ThemeData lightThemeData = resolveThemeData(
            Brightness.light,
            lightDynamic,
          );
          final ThemeData darkThemeData = resolveThemeData(
            Brightness.dark,
            darkDynamic,
          );

          return MultiProvider(
            providers: <ChangeNotifierProvider<dynamic>>[
              ChangeNotifierProvider<Preferences>.value(value: preferences),
            ],
            child: const ForceRTL(Navigator()),
            builder: (final BuildContext context, final Widget? child) {
              final Preferences preferences = Provider.of<Preferences>(context);
              SystemChrome.setSystemUIOverlayStyle(
                resolveOverlayStyle(preferences.themeMode),
              );
              return MaterialApp(
                title: 'Happily Ever After',
                themeMode: preferences.themeMode,
                theme: lightThemeData,
                darkTheme: darkThemeData,
                locale: preferences.locale,
                restorationScopeId: 'root',
                home: child,
              );
            },
          );
        },
      );
}
