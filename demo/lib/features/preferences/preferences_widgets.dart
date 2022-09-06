import 'package:flutter/material.dart';

import '../../navigator.dart' show ForceRTL;
import '../../widgets/list_tile_centered.dart';

class PreferenceGroup extends StatelessWidget {
  const PreferenceGroup({super.key, required this.title, required this.items});

  final String title;
  final List<Widget> items;

  Widget _buildItems(final BuildContext context) => Column(
        children: items
            .expand(
              (final Widget item) => [
                const Divider(indent: 16, endIndent: 16, height: 0),
                item,
              ],
            )
            .skip(1)
            .toList(),
      );

  @override
  Widget build(final BuildContext context) => Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 32, vertical: 14),
                  child: Text(
                    title,
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                ),
              ),
            ],
          ),
          Card(
            clipBehavior: Clip.antiAlias,
            margin: const EdgeInsets.symmetric(horizontal: 16),
            child: _buildItems(context),
          ),
        ],
      );
}

class _ItemTemplate extends StatelessWidget {
  const _ItemTemplate({
    required this.label,
    this.description,
    required this.child,
    this.onTap,
    this.onLongPress,
  });

  final String label;
  final String? description;
  final Widget child;
  final GestureTapCallback? onTap;
  final GestureTapCallback? onLongPress;

  @override
  Widget build(final BuildContext context) => ListTileCentered(
        onTap: onTap,
        onLongPress: onLongPress,
        title: Text(label),
        subtitle: description == null ? null : Text(description!),
        trailing: child,
        minVerticalPadding: 16,
      );
}

class PreferenceSwitch extends StatelessWidget {
  const PreferenceSwitch({
    super.key,
    required this.label,
    this.description,
    required this.value,
    required this.onChanged,
  });

  final String label;
  final String? description;
  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(final BuildContext context) => _ItemTemplate(
        label: label,
        description: description,
        child: Switch.adaptive(
          value: value,
          onChanged: onChanged,
        ),
        onTap: () {
          onChanged(!value);
        },
      );
}

class PreferenceChoice<T> extends StatelessWidget {
  const PreferenceChoice({
    super.key,
    required this.label,
    this.description,
    required this.choices,
    required this.value,
    required this.onChanged,
  }) : assert(choices.length > 0);

  final String label;
  final String? description;
  final List<PreferenceChoiceItem<T>> choices;
  final T value;
  final ValueChanged<T> onChanged;

  @override
  Widget build(final BuildContext context) {
    final PreferenceChoiceItem<T> selected = choices.firstWhere(
      (final PreferenceChoiceItem<T> choice) => choice.value == value,
      orElse: () => choices[0],
    );

    return _ItemTemplate(
      label: label,
      description: description,
      child: Text(selected.label, style: Theme.of(context).textTheme.bodyLarge),
      onTap: () async {
        final double maxHeight = choices.length <= 3 ? 360 : double.infinity;
        final T? value = await showModalBottomSheet<T?>(
          constraints: BoxConstraints(maxHeight: maxHeight),
          context: context,
          builder: (final BuildContext context) => ForceRTL(
            PreferenceChoiceModal<T>(
              label: label,
              choices: choices,
              selected: selected,
            ),
          ),
        );
        if (value != null) {
          onChanged(value);
        }
      },
    );
  }
}

// TODO(serverwentdown): abstract away modal sheet as a standard dialog
class PreferenceChoiceModal<T> extends StatefulWidget {
  const PreferenceChoiceModal({
    super.key,
    required this.label,
    required this.choices,
    required this.selected,
  });

  final String label;
  final List<PreferenceChoiceItem<T>> choices;
  final PreferenceChoiceItem<T> selected;

  @override
  State<PreferenceChoiceModal<T>> createState() =>
      _PreferenceChoiceModalState<T>();
}

class _PreferenceChoiceModalState<T> extends State<PreferenceChoiceModal<T>> {
  T? value;

  @override
  void initState() {
    super.initState();
    value = widget.selected.value;
  }

  @override
  Widget build(final BuildContext context) => SafeArea(
        child: Column(
          children: [
            Row(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                  child: Text(
                    widget.label,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
              ],
            ),
            Expanded(
              child: ListView.separated(
                shrinkWrap: true,
                itemCount: widget.choices.length,
                itemBuilder: _buildListItem,
                separatorBuilder:
                    (final BuildContext context, final int index) =>
                        const Divider(indent: 64, endIndent: 16, height: 0),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  child: OutlinedButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text('Cancel'),
                  ),
                ),
              ],
            ),
          ],
        ),
      );

  Widget _buildListItem(final BuildContext context, final int index) {
    final PreferenceChoiceItem choice = widget.choices[index];

    return ListTileCentered(
      title: Text(choice.label),
      leading: Radio<T>(
        value: choice.value,
        groupValue: value,
        onChanged: (final newValue) {
          setState(() {
            value = newValue as T;
          });
          Navigator.of(context).pop(value);
        },
      ),
      minVerticalPadding: 16,
    );
  }
}

class PreferenceChoiceItem<T> {
  const PreferenceChoiceItem({required this.value, required this.label});

  final T value;
  final String label;
}

class PreferenceInfo extends StatelessWidget {
  const PreferenceInfo({
    super.key,
    required this.label,
    this.description,
    this.value,
    this.trailer,
    this.onTap,
    this.onLongPress,
  });

  final String label;
  final String? description;
  final String? value;
  final Widget? trailer;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;

  @override
  Widget build(final BuildContext context) => _ItemTemplate(
        label: label,
        description: description,
        onTap: onTap,
        onLongPress: onLongPress,
        child: Row(
          children: [
            if (value != null)
              Text(value!, style: Theme.of(context).textTheme.bodyLarge),
            if (trailer != null)
              IconTheme(
                data: Theme.of(context).iconTheme.copyWith(opacity: 0.38),
                child: trailer!,
              ),
          ],
        ),
      );
}
