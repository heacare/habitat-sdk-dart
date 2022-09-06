import 'package:flutter/material.dart';

import '../../widgets/screen.dart' show Screen;

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(final BuildContext context) => const Screen(
        children: <Widget>[
          Center(child: Text('AccountScreen')),
        ],
      );
}
