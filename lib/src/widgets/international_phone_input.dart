import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../core/controller/phone_editing_controller.dart';
import 'country_item.dart';

/// {@template internation_phone_input}
/// Creates a [TextField] customized for accepting international phone numbers.
/// {@endtemplate}
class InternationalPhoneInput extends StatefulWidget {
  /// {@macro internation_phone_input}
  const InternationalPhoneInput({
    required final this.phoneEditingController,
    final Key? key,
  }) : super(key: key);

  /// Controls the phone number being editted.
  final PhoneEditingController phoneEditingController;

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
  late final TextEditingController _textEditingController;
  @override
  void initState() {
    _textEditingController = TextEditingController.fromValue(
      widget.phoneEditingController.value.numberEditingValue,
    );
    widget.phoneEditingController.addListener(() {
      _textEditingController.text = widget.phoneEditingController.phoneNumber;
      setState(() {
        // We rebuild the widget to display the latest
        // [widget.phoneEditingController]
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(final BuildContext context) {
    print('build');
    return TextField(
      controller: _textEditingController,
      decoration: InputDecoration(
        prefixIcon: CountryItem(
          country: widget.phoneEditingController.value.country,
          onTap: () {
            print('tapa tap');
          },
        ),
      ),
    );
  }
}
