/// A [Country] model represents an instance of a country which
/// all the important metadta about the country
class Country {
  /// Creates an object of the [Country] data class.
  Country({
    required final this.name,
    required final this.alpha2Code,
    required final this.alpha3Code,
    required final this.dialCode,
    final String? flagUri,
  }) : flagUri = flagUri ?? 'assets/flags/${alpha2Code.toLowerCase()}.png';

  /// Creates a default object of the [Country] class that represents `India`.
  factory Country.empty() => Country(
        name: 'India',
        alpha2Code: 'IN',
        alpha3Code: 'IND',
        dialCode: '91',
      );

  /// Creates a Country object from the given [map].
  factory Country.fromMap(final Map<String, dynamic> map) => Country(
        name: map['en_short_name'] ?? '',
        alpha2Code: map['alpha_2_code'] ?? '',
        alpha3Code: map['alpha_3_code'] ?? '',
        dialCode: map['dial_code'] ?? '',
      );

  /// The name of the [Country]
  final String name;

  /// The alpha 2 isoCode of the [Country]
  final String alpha2Code;

  /// The alpha 3 isoCode of the [Country]
  final String alpha3Code;

  /// The dialCode of the [Country]
  final String dialCode;

  /// The _asset_ Uri which links to the flag for the [Country].
  final String flagUri;
}
