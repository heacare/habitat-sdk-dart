import 'dart:math' show max;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart' hide Navigator;
import 'package:flutter/material.dart' as material show Navigator;
import 'package:provider/provider.dart' show Consumer;

import 'features/account/account_screen.dart' show AccountScreen;
import 'features/dashboard/dashboard_screen.dart' show DashboardScreen;
import 'features/preferences/preferences.dart' show Preferences;
import 'features/preferences/preferences_screen.dart'
    show PreferencesPage, PreferencesScreen;

class ForceRTL extends StatelessWidget {
  const ForceRTL(this.child, {super.key});

  final Widget child;

  @override
  Widget build(final BuildContext context) {
    if (!kDebugMode) {
      return child;
    }
    final Key key = UniqueKey();
    return Consumer<Preferences>(
      builder: (
        final BuildContext context,
        final Preferences preferences,
        final Widget? child,
      ) {
        if (preferences.forceRTL) {
          return Directionality(
            key: key,
            textDirection: TextDirection.rtl,
            child: child!,
          );
        }
        return Visibility(
          key: key,
          child: child!,
        );
      },
      child: child,
    );
  }
}

typedef _PreferredSizeWidgetBuilder = PreferredSizeWidget Function(
  BuildContext context,
);

class _NavigatorPage {
  const _NavigatorPage({
    required this.key,
    required this.tooltip,
    required this.label,
    required this.icon,
    required this.selectedIcon,
    this.screen,
    this.desktopScreen,
    this.appBar,
    this.desktopAppBar,
  });

  final String key;
  final String tooltip;
  final String label;
  final Icon icon;
  final Icon selectedIcon;

  final WidgetBuilder? screen;
  final WidgetBuilder? desktopScreen;

  final _PreferredSizeWidgetBuilder? appBar;
  final _PreferredSizeWidgetBuilder? desktopAppBar;
}

Route _preferencesRouteBuilder(final BuildContext context, final arguments) =>
    MaterialPageRoute(
      builder: (final BuildContext context) =>
          const ForceRTL(PreferencesPage()),
    );

Widget _preferencesButton(final BuildContext context) => IconButton(
      icon: const Icon(Icons.settings),
      tooltip: 'Settings',
      onPressed: () async {
        material.Navigator.of(context).restorablePush(_preferencesRouteBuilder);
      },
    );

final List<_NavigatorPage> _navigatorPages = <_NavigatorPage>[
  _NavigatorPage(
    key: 'home',
    tooltip: '',
    label: 'Home',
    icon: const Icon(Icons.chair_outlined),
    selectedIcon: const Icon(Icons.chair),
    screen: (final BuildContext context) => const DashboardScreen(),
    desktopScreen: (final BuildContext context) => const DashboardScreen(),
  ),
  _NavigatorPage(
    key: 'account',
    tooltip: '',
    label: 'Account',
    icon: const Icon(Icons.person_outline),
    selectedIcon: const Icon(Icons.person),
    screen: (final BuildContext context) => const AccountScreen(),
    appBar: (final BuildContext context) => AppBar(
      title: const Text('Account'),
      centerTitle: true,
      actions: [_preferencesButton(context)],
    ),
    desktopScreen: (final BuildContext context) => const AccountScreen(),
    desktopAppBar: (final BuildContext context) => AppBar(
      title: const Text('Account'),
      centerTitle: true,
    ),
  ),
  _NavigatorPage(
    key: 'settings',
    tooltip: '',
    label: 'Settings',
    icon: const Icon(Icons.settings_outlined),
    selectedIcon: const Icon(Icons.settings),
    desktopScreen: (final BuildContext context) => const PreferencesScreen(),
    desktopAppBar: (final BuildContext context) => AppBar(
      title: const Text('Settings'),
      centerTitle: true,
    ),
  ),
];

final List<_NavigatorPage> _pages = _navigatorPages
    .where((final _NavigatorPage page) => page.screen != null)
    .toList();
final List<NavigationDestination> _destinations = _pages
    .map(
      (final _NavigatorPage page) => NavigationDestination(
        tooltip: page.tooltip,
        label: page.label,
        icon: page.icon,
        selectedIcon: page.selectedIcon,
      ),
    )
    .toList();

final List<_NavigatorPage> _desktopPages = _navigatorPages
    .where((final _NavigatorPage page) => page.desktopScreen != null)
    .toList();
final List<NavigationRailDestination> _desktopDestinations = _desktopPages
    .map(
      (final _NavigatorPage page) => NavigationRailDestination(
        label: Text(page.label),
        icon: page.icon,
        selectedIcon: page.selectedIcon,
      ),
    )
    .toList();

class Navigator extends StatefulWidget {
  const Navigator({super.key});

  @override
  State<Navigator> createState() => _NavigatorState();
}

class _NavigatorState extends State<Navigator> with RestorationMixin {
  final RestorableString _selectedKey = RestorableString('');

  @override
  void dispose() {
    _selectedKey.dispose();
    super.dispose();
  }

  @override
  String get restorationId => 'navigator';

  @override
  void restoreState(
    final RestorationBucket? oldBucket,
    final bool initialRestore,
  ) {
    registerForRestoration(_selectedKey, 'selected_key');
  }

  @override
  Widget build(final BuildContext context) => LayoutBuilder(
        builder:
            (final BuildContext context, final BoxConstraints constraints) {
          if (constraints.maxWidth < 1024) {
            return _build(context);
          } else {
            return _buildDesktop(context);
          }
        },
      );

  int _selectedIndex(final List<_NavigatorPage> pages) => max(
        pages.indexWhere(
          (final _NavigatorPage page) => page.key == _selectedKey.value,
        ),
        0,
      );

  void _setCurrentIndex(final List<_NavigatorPage> pages, final int index) {
    _selectedKey.value = pages[index].key;
  }

  Widget _build(final BuildContext context) {
    final int selectedIndex = _selectedIndex(_pages);
    final _NavigatorPage selectedPage = _pages[selectedIndex];
    return Scaffold(
      appBar: selectedPage.appBar?.call(context),
      body: selectedPage.screen!.call(context),
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (final int index) {
          setState(() {
            _setCurrentIndex(_pages, index);
          });
        },
        selectedIndex: selectedIndex,
        destinations: _destinations,
      ),
    );
  }

  Widget _buildDesktop(final BuildContext context) {
    final int selectedIndex = _selectedIndex(_desktopPages);
    final _NavigatorPage selectedPage = _desktopPages[selectedIndex];
    return Scaffold(
      body: Row(
        children: [
          NavigationRail(
            onDestinationSelected: (final int index) {
              setState(() {
                _setCurrentIndex(_desktopPages, index);
              });
            },
            selectedIndex: selectedIndex,
            destinations: _desktopDestinations,
            labelType: NavigationRailLabelType.all,
            leading: Container(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Image.asset(
                'assets/brand/mark-gradient.png',
                width: 48,
                height: 48,
              ),
            ),
          ),
          Expanded(
            child: Column(
              children: [
                if (selectedPage.desktopAppBar != null)
                  selectedPage.desktopAppBar!(context),
                if (selectedPage.desktopScreen != null)
                  Expanded(child: selectedPage.desktopScreen!(context)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
