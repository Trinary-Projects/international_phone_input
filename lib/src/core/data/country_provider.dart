import '../../models/country.dart';
import 'country_list.dart';

// ignore: avoid_classes_with_only_static_members
/// This class provides helper functions that involves manipulations.
/// of Countries from [Countries.countryList]
class CountryProvider {
  /// Returns the list of all the [Country] objects in [Countries].
  static List<Country> getAllCountriesData() {
    final List<Map<String, dynamic>> jsonList = Countries.countryList;
    return jsonList
        .map<Country>(
          (final Map<String, dynamic> country) => Country.fromMap(country),
        )
        .toList();
  }

  /// Searches the list of all the [Country] objects in [Countries] and returns
  /// a set of matching results.
  static List<Country> searchCountries(final String hint) {
    final List<Country> countries = getAllCountriesData();
    return countries
        .where(
          (final Country country) =>
              country.alpha3Code.toLowerCase().startsWith(hint.toLowerCase()) ||
              country.name.toLowerCase().contains(hint.toLowerCase()) ||
              country.dialCode.contains(hint.toLowerCase()),
        )
        .toList();
  }

  /// Returns a [Country], based on the passed parameters.
  ///
  /// Either [countryCode] or [dialCode] must be provided.
  /// Returns [Country.empty] if:-
  /// * [countryCode] or [dialCode] is an empty [String].
  /// * If no match are found.
  static Country getCountryData({
    final String? countryCode,
    final String? dialCode,
  }) {
    final List<Country> countries = getAllCountriesData();

    if (countries.isEmpty) {
      return Country.empty();
    }
    if (countryCode != null) {
      return countries.firstWhere(
        (final Country country) => country.alpha2Code == countryCode,
        orElse: () => Country.empty(),
      );
    } else if (dialCode != null) {
      return countries.firstWhere(
        (final Country country) => country.dialCode == '+$dialCode',
        orElse: () => Country.empty(),
      );
    } else {
      return Country.empty();
    }
  }
}
