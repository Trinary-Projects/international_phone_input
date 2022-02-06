import 'package:flutter/material.dart';

import '../../models/country.dart';
import '../data/country_provider.dart';
import 'phone_editing_value.dart';

/// A controller for an editable international phone number field.
class PhoneEditingController extends ValueNotifier<PhoneEditingValue> {
  /// Creates a controller for editing international phone nubmers.
  ///
  /// The constructor treats null [phoneNumber] & [countryCode] as
  /// empty values.
  PhoneEditingController({
    final String? phoneNumber,
    final String? countryCode,
  }) : super(
          PhoneEditingValue(
            numberEditingValue: phoneNumber == null
                ? TextEditingValue.empty
                : TextEditingValue(text: phoneNumber),
            country: countryCode == null
                ? Country.empty()
                : CountryProvider.getCountryData(
                    countryCode: countryCode,
                  ),
          ),
        );

  /// The current phone number [String].
  String get phoneNumber => value.numberEditingValue.text;

  /// Set the current phone number [String].
  ///
  /// Setting this will notify all the listeners that they need to update
  /// (it calls [notifyListeners]). For this reason, this value should only
  /// be set between frames, e.g. in response to user actions, not during the
  /// build, layout, or paint phases.
  set phoneNumber(final String newPhoneNumber) {
    value = value.copyWith(
      numberEditingValue: value.numberEditingValue.copyWith(
        text: newPhoneNumber,
      ),
    );
  }

  /// The current country [Country].
  Country get country => value.country;

  /// The current ISO-Alpha2 country code [String].
  String get countryCode => value.country.alpha2Code;

  /// Set the current country [Country] using countryCode [String].
  ///
  /// Setting this will notify all the listeners that they need to update
  /// (it calls [notifyListeners]). For this reason, this value should only
  /// be set between frames, e.g. in response to user actions, not during the
  /// build, layout, or paint phases.
  set countryCode(final String newCountryCode) {
    value = value.copyWith(
      country: CountryProvider.getCountryData(countryCode: newCountryCode),
    );
  }

  /// Set the current [value] to empty.
  ///
  /// After calling this function, [phoneNumber] will be the empty string and
  /// the selection will be collapsed at zero offset.
  void clear() {
    print('clear function in PhoneEditingController');
    value = PhoneEditingValue(
      numberEditingValue: TextEditingValue.empty,
      country: Country.empty(),
    );
  }
}
