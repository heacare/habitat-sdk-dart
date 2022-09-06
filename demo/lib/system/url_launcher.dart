import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, TargetPlatform;
import 'package:flutter/material.dart' show BuildContext, Theme;
import 'package:flutter_custom_tabs/flutter_custom_tabs.dart' as custom_tabs;
import 'package:url_launcher/url_launcher.dart' as basic;

enum LaunchMode {
  /// Launches the URL within the app and with a web browser shell
  customTabs,

  /// Passes the URL to the OS to be handled by another application.
  externalApplication,

  /// Passes the URL to the OS to be handled by another non-browser application.
  externalNonBrowserApplication,
}

Future<bool> launchUrl(
  final Uri url, {
  final LaunchMode mode = LaunchMode.customTabs,
  final BuildContext? context,
}) async {
  LaunchMode allowedMode = mode;
  switch (defaultTargetPlatform) {
    case TargetPlatform.android:
    case TargetPlatform.iOS:
      break;
    default:
      if (allowedMode == LaunchMode.customTabs) {
        allowedMode = LaunchMode.externalApplication;
      }
  }
  switch (allowedMode) {
    case LaunchMode.customTabs:
      await custom_tabs.launch(
        url.toString(),
        customTabsOption: custom_tabs.CustomTabsOption(
          showPageTitle: true,
          toolbarColor:
              context == null ? null : Theme.of(context).colorScheme.primary,
        ),
      );
      return true;
    case LaunchMode.externalApplication:
      return basic.launchUrl(
        url,
        mode: basic.LaunchMode.externalApplication,
      );
    case LaunchMode.externalNonBrowserApplication:
      return basic.launchUrl(
        url,
        mode: basic.LaunchMode.externalNonBrowserApplication,
      );
  }
}
