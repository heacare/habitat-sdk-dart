import 'package:flutter/material.dart';

import '../../widgets/screen.dart' show Screen;

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(final BuildContext context) => const Screen(
        children: [
          Center(child: Text('DashboardScreen')),
        ],
      );
}
