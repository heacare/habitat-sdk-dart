import 'package:flutter/material.dart';

/// A vertically-centered version of [ListTile] implemented using [Row]s and [Column]s. As we go along, we can slowly re-implement more of [ListTile]. See https://api.flutter.dev/flutter/material/ListTile/ListTile.html
class ListTileCentered extends StatelessWidget {
  // Construct a [ListTileCentered]
  const ListTileCentered({
    super.key,
    this.leading,
    this.title,
    this.subtitle,
    this.trailing,
    this.onTap,
    this.onLongPress,
    this.contentPadding = const EdgeInsets.symmetric(horizontal: 16),
    this.horizontalTitleGap = 16,
    this.minVerticalPadding = 4,
  });

  final Widget? leading;
  final Widget? title;
  final Widget? subtitle;
  final Widget? trailing;
  final GestureTapCallback? onTap;
  final GestureTapCallback? onLongPress;
  final EdgeInsetsGeometry contentPadding;
  final double horizontalTitleGap;
  final double minVerticalPadding;

  @override
  Widget build(final BuildContext context) {
    final ThemeData theme = Theme.of(context);

    final Widget titleText = AnimatedDefaultTextStyle(
      style: theme.textTheme.titleMedium!,
      duration: kThemeChangeDuration,
      child: title ?? const SizedBox(),
    );

    TextStyle subtitleStyle = theme.textTheme.bodyMedium!;
    subtitleStyle = subtitleStyle.copyWith(
      color: theme.textTheme.bodySmall!.color,
    );
    final Widget subtitleText = AnimatedDefaultTextStyle(
      style: subtitleStyle,
      duration: kThemeChangeDuration,
      child: subtitle ?? const SizedBox(),
    );

    final TextDirection textDirection = Directionality.of(context);

    return InkWell(
      onTap: onTap,
      onLongPress: onLongPress,
      child: SafeArea(
        top: false,
        bottom: false,
        minimum: contentPadding.resolve(textDirection),
        child: Row(
          textDirection: textDirection,
          children: [
            if (leading != null) leading!,
            if (leading != null) SizedBox(width: horizontalTitleGap),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: minVerticalPadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    titleText,
                    subtitleText,
                  ],
                ),
              ),
            ),
            if (trailing != null) SizedBox(width: horizontalTitleGap),
            if (trailing != null) trailing!,
          ],
        ),
      ),
    );
  }
}
