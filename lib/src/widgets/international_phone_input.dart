import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../core/controller/phone_editing_controller.dart';
import '../models/country.dart';
import 'country_item.dart';
import 'country_list_dialog.dart';

/// {@template internation_phone_input}
/// Creates a [TextField] customized for accepting international phone numbers.
/// {@endtemplate}
class InternationalPhoneInput extends StatefulWidget {
  /// {@macro internation_phone_input}
  const InternationalPhoneInput({
    required final this.phoneEditingController,
    required this.focusNode,
    final this.suffix,
    final Key? key,
  }) : super(key: key);

  /// Controls the phone number being editted.
  final PhoneEditingController phoneEditingController;

  /// The suffix icon button in [TextField]
  final Widget? suffix;
  final FocusNode focusNode;

  @override
  State<InternationalPhoneInput> createState() =>
      _InternationalPhoneInputState();

  @override
  void debugFillProperties(final DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(
      DiagnosticsProperty<PhoneEditingController>(
        'phoneEditingController',
        phoneEditingController,
      ),
    );
  }
}

class _InternationalPhoneInputState extends State<InternationalPhoneInput> {
  @override
  Widget build(final BuildContext context) => TextField(
        controller: widget.phoneEditingController,
        focusNode: widget.focusNode,
        keyboardType: TextInputType.phone,
        decoration: InputDecoration(
          prefixIcon: ValueListenableBuilder<dynamic>(
            valueListenable: widget.phoneEditingController,
            builder: (
              final BuildContext context,
              final dynamic value,
              final Widget? child,
            ) =>
                CountryItem(
              country: widget.phoneEditingController.country,
              onTap: () {
                showDialog<Country>(
                  context: context,
                  builder: (final BuildContext context) =>
                      const CountryListDialog(),
                ).then((final Country? value) {
                  if (value == null) {
                    return;
                  }
                  widget.phoneEditingController.countryCode = value.alpha2Code;
                });
              },
            ),
          ),
          prefixIconConstraints: const BoxConstraints(
            maxHeight: 36,
          ),
          suffixIcon: widget.suffix,
        ),
      );
}
