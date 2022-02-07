import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../models/country.dart';

/// An item representing the [country] assigned to it.
class CountryItem extends StatelessWidget {
  /// Creates a item to represent the selected country and provides a [onTap]
  /// callback.
  const CountryItem({
    required final this.country,
    required final this.onTap,
    final Key? key,
  }) : super(key: key);

  /// The country that needs to be represented by this widget.
  final Country country;

  /// Called when the [CountryItem] is tapped.
  final VoidCallback onTap;

  @override
  Widget build(final BuildContext context) => Padding(
        padding: const EdgeInsets.only(left: 6, right: 12),
        child: TextButton.icon(
          onPressed: onTap,
          style: TextButton.styleFrom(
            backgroundColor: const Color(0xFFF3F3F5),
            minimumSize: const Size(72, 36),
            maximumSize: const Size(128, 36),
          ),
          icon: Image.asset(
            country.flagUri,
            width: 28,
            height: 18,
            package: 'international_phone_input',
            errorBuilder: (
              final BuildContext context,
              final Object error,
              final StackTrace? stackTrace,
            ) =>
                const SizedBox.shrink(),
          ),
          label: Text(
            country.dialCode,
            maxLines: 1,
            style: Theme.of(context).textTheme.bodyText1?.copyWith(
                  color: const Color(0xFF616161),
                ),
          ),
        ),
      );
  @override
  void debugFillProperties(final DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty<Country>('country', country))
      ..properties.add(ObjectFlagProperty<VoidCallback>.has('onTap', onTap));
  }
}
