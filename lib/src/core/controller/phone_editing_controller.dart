import 'package:flutter/material.dart';

import '../../models/country.dart';
import '../data/country_provider.dart';

/// A controller for an editable international phone number field.
class PhoneEditingController extends TextEditingController {
  /// Creates a controller for editing international phone nubmers.
  ///
  /// The constructor treats null [phoneNumber] & [countryCode] as
  /// empty values.
  PhoneEditingController({
    final String? phoneNumber,
    final String? countryCode,
  }) {
    if (phoneNumber != null) {
      text = phoneNumber;
    } else {
      //Handled by TextEditingController.
    }
    if (countryCode != null) {
      _country = CountryProvider.getCountryData(
        countryCode: countryCode,
      );
    } else {
      _country = Country.empty();
    }
  }

  late Country _country;

  /// The current phone number [String].
  String get phoneNumber => text;

  /// Set the current phone number [String].
  ///
  /// Setting this will notify all the listeners that they need to update
  /// (it calls [notifyListeners]). For this reason, this value should only
  /// be set between frames, e.g. in response to user actions, not during the
  /// build, layout, or paint phases.
  set phoneNumber(final String newPhoneNumber) {
    text = newPhoneNumber;
  }

  /// The current country [Country].
  Country get country => _country;

  /// The current ISO-Alpha2 country code [String].
  String get countryCode => _country.alpha2Code;

  /// Set the current country [Country] using countryCode [String].
  ///
  /// Setting this will notify all the listeners that they need to update
  /// (it calls [notifyListeners]). For this reason, this value should only
  /// be set between frames, e.g. in response to user actions, not during the
  /// build, layout, or paint phases.
  set countryCode(final String newCountryCode) {
    _country = CountryProvider.getCountryData(countryCode: newCountryCode);
    notifyListeners();
  }

  /// The current ISO-Alpha2 country code [String].
  String get countryDialCode => _country.dialCode;

  /// Set the current country [Country] using countryCode [String].
  ///
  /// Setting this will notify all the listeners that they need to update
  /// (it calls [notifyListeners]). For this reason, this value should only
  /// be set between frames, e.g. in response to user actions, not during the
  /// build, layout, or paint phases.
  set countryDialCode(final String newDialCode) {
    _country = CountryProvider.getCountryData(dialCode: newDialCode);
    notifyListeners();
  }

  /// Set the current [value] to empty.
  ///
  /// After calling this function, [phoneNumber] will be the empty string and
  /// the selection will be collapsed at zero offset.
  @override
  void clear() {
    _country = Country.empty();
    super.clear();
  }
}
