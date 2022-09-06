import 'package:flutter/material.dart';

class Screen extends StatelessWidget {
  const Screen({
    super.key,
    this.fullWidth = false,
    this.listView = false,
    this.child,
    this.children,
  }) : assert(child != null || children != null);

  final bool fullWidth;
  final bool listView;
  final Widget? child;
  final List<Widget>? children;

  @override
  Widget build(final BuildContext context) {
    Widget wrappedChild;
    if (child != null) {
      wrappedChild = child!;
    } else {
      wrappedChild = Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: children!,
      );
    }

    if (!listView) {
      wrappedChild = SingleChildScrollView(
        child: SafeArea(
          child: wrappedChild,
        ),
      );
    }

    if (!fullWidth) {
      wrappedChild = Align(
        alignment: Alignment.topCenter,
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 600),
          child: wrappedChild,
        ),
      );
    }

    return wrappedChild;
  }
}

EdgeInsetsGeometry listViewPaddingTB(
  final BuildContext context, {
  final double top = 0,
  final double bottom = 0,
}) =>
    MediaQuery.of(context)
        .padding
        .add(EdgeInsets.only(top: top, bottom: bottom));
