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

  /// Returns a [Country], if [countryCode] is valid and matches a [Country]
  /// from the [Countries.countryList] else returns [Country.empty]:-
  /// * If [countryCode] is as empty [String].
  /// * If no matches are found.
  static Country getCountryData({required final String countryCode}) {
    final List<Country> countries = getAllCountriesData();

    if (countries.isEmpty) {
      return Country.empty();
    }

    return countries.firstWhere(
      (final Country country) => country.alpha2Code == countryCode,
      orElse: () => Country.empty(),
    );
  }
}
