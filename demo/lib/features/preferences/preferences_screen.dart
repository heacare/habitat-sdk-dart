import 'package:flutter/foundation.dart' show kDebugMode;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:package_info_plus/package_info_plus.dart' show PackageInfo;
import 'package:provider/provider.dart' show Provider;

import '../../system/metadata.dart'
    show privacyPolicyUrl, sourceUrl, feedbackEmail, feedbackUrl;
import '../../system/url_launcher.dart' show launchUrl, LaunchMode;
import '../../widgets/screen.dart' show Screen, listViewPaddingTB;
import 'preferences.dart';
import 'preferences_widgets.dart';

class PreferencesPage extends StatelessWidget {
  const PreferencesPage({super.key});

  @override
  Widget build(final BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('Settings'),
          centerTitle: true,
        ),
        body: const PreferencesScreen(),
      );
}

class PreferencesScreen extends StatelessWidget {
  const PreferencesScreen({super.key});

  @override
  Widget build(final BuildContext context) {
    final List<Widget> items = _buildGroups(context);
    return Screen(
      listView: true,
      child: ListView.separated(
        padding: listViewPaddingTB(context, bottom: 16),
        itemCount: items.length,
        itemBuilder: (final BuildContext context, final int index) =>
            items[index],
        separatorBuilder: (final BuildContext context, final int index) =>
            const SizedBox(height: 8),
      ),
    );
  }

  List<Widget> _buildGroups(final BuildContext context) {
    final Preferences preferences = Provider.of<Preferences>(context);

    return [
      PreferenceGroup(
        title: 'Display',
        items: [
          PreferenceChoice<ThemeMode>(
            label: 'Theme',
            choices: _themeModeChoices,
            value: preferences.themeMode,
            onChanged: preferences.setThemeMode,
          ),
          if (kDebugMode)
            PreferenceSwitch(
              label: 'Force RTL',
              value: preferences.forceRTL,
              onChanged: preferences.setForceRTL,
            ),
        ],
      ),
      PreferenceGroup(
        title: 'About',
        items: [
          PreferenceInfo(
            label: 'Feedback',
            value: feedbackEmail,
            onTap: () async {
              await launchUrl(
                feedbackUrl,
                mode: LaunchMode.externalNonBrowserApplication,
              );
            },
            onLongPress: () async {
              const ClipboardData data = ClipboardData(text: feedbackEmail);
              await Clipboard.setData(data);
            },
          ),
          FutureBuilder<PackageInfo>(
            future: PackageInfo.fromPlatform(),
            builder: (
              final BuildContext context,
              final AsyncSnapshot<PackageInfo> snapshot,
            ) {
              String version = 'Loading';
              if (snapshot.data != null) {
                version =
                    '${snapshot.data!.version}+${snapshot.data!.buildNumber}';
              }
              return PreferenceInfo(
                label: 'Version',
                value: version,
              );
            },
          ),
          PreferenceInfo(
            label: 'Source code',
            onTap: () async {
              await launchUrl(sourceUrl, context: context);
            },
          ),
          PreferenceInfo(
            label: 'Open-source licenses',
            onTap: () async {
              showLicensePage(context: context);
            },
          ),
        ],
      ),
    ];
  }
}

const List<PreferenceChoiceItem<ThemeMode>> _themeModeChoices = [
  PreferenceChoiceItem(
    value: ThemeMode.system,
    label: 'System',
  ),
  PreferenceChoiceItem(
    value: ThemeMode.light,
    label: 'Light',
  ),
  PreferenceChoiceItem(
    value: ThemeMode.dark,
    label: 'Dark',
  ),
];
