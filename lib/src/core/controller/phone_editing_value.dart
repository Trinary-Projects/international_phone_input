import 'package:flutter/widgets.dart';

import '../../models/country.dart';

/// The current [TextEditingValue], and country code value for editing a run
/// of phone number.
@immutable
class PhoneEditingValue {
  /// Creates information for editing phone numbers.
  ///
  /// The [numberEditingValue], and [country] arguments must not be null but
  /// each have default values.
  const PhoneEditingValue({
    required final this.numberEditingValue,
    required final this.country,
  });

  /// The current phone number as [TextEditingValue].
  final TextEditingValue numberEditingValue;

  /// The current country code as [Country].
  final Country country;

  /// Creates a copy of this value but with the given fields replaced with the
  /// new values.
  PhoneEditingValue copyWith({
    final TextEditingValue? numberEditingValue,
    final Country? country,
  }) =>
      PhoneEditingValue(
        numberEditingValue: numberEditingValue ?? this.numberEditingValue,
        country: country ?? this.country,
      );
}
