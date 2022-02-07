import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../core/data/country_provider.dart';
import '../models/country.dart';

/// {@template country_list_dialog}
/// A dialog that displays list of all available [Country] objects.
/// {@endtemplate}
class CountryListDialog extends StatefulWidget {
  ///{@macro country_list_object}
  const CountryListDialog({final Key? key}) : super(key: key);

  @override
  State<CountryListDialog> createState() => _CountryListDialogState();
}

class _CountryListDialogState extends State<CountryListDialog> {
  late final TextEditingController _searchController;
  late List<Country> _countries;

  @override
  void initState() {
    _countries = CountryProvider.getAllCountriesData();
    _searchController = TextEditingController()
      ..addListener(() {
        setState(() {
          _countries =
              CountryProvider.searchCountries(_searchController.text.trim());
        });
      });

    super.initState();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(final BuildContext context) => Dialog(
        insetPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              height: 72,
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: const BoxDecoration(
                color: Color(0xFFF3F3F5),
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(4),
                ),
              ),
              child: TextField(
                controller: _searchController,
                textAlignVertical: TextAlignVertical.center,
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  hintText: 'Search by country name or code',
                  prefixIcon: Padding(
                    padding: const EdgeInsets.fromLTRB(12, 0, 12, 0),
                    child: SvgPicture.asset(
                      'assets/icons/search.svg',
                      package: 'international_phone_input',
                    ),
                  ),
                  prefixIconConstraints: BoxConstraints.tight(
                    const Size(48, 24),
                  ),
                  hintStyle: Theme.of(context).textTheme.bodyText1!.copyWith(
                        fontWeight: FontWeight.w400,
                        height: 0.5,
                        color: const Color(0xFF9E9E9E),
                      ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(24),
                    borderSide: const BorderSide(
                      width: 1.5,
                      color: Color(0xFFDDDDDD),
                    ),
                  ),
                  disabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(24),
                    borderSide: const BorderSide(
                      width: 1.5,
                      color: Color(0xFFDDDDDD),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(24),
                    borderSide: const BorderSide(
                      width: 1.5,
                      color: Color(0xFF007EFA),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Scrollbar(
                child: ListView.separated(
                  itemCount: _countries.length,
                  shrinkWrap: true,
                  itemBuilder: (final BuildContext context, final int index) =>
                      _CountryTile(_countries[index]),
                  separatorBuilder:
                      (final BuildContext context, final int index) =>
                          const Divider(
                    height: 1.5,
                    thickness: 1.5,
                    color: Color(0xFFF3F3F5),
                    indent: 72,
                    endIndent: 24,
                  ),
                ),
              ),
            )
          ],
        ),
      );
}

class _CountryTile extends StatelessWidget {
  const _CountryTile(
    final this.country, {
    final Key? key,
  }) : super(key: key);

  final Country country;

  @override
  Widget build(final BuildContext context) => ListTile(
        leading: CircleAvatar(
          radius: 20,
          backgroundColor: const Color(0xFFF3F3F5),
          backgroundImage: AssetImage(
            country.flagUri,
            package: 'international_phone_input',
          ),
        ),
        title: Text(
          country.name,
          style: Theme.of(context).textTheme.bodyText2!.copyWith(
                fontWeight: FontWeight.w600,
              ),
        ),
        subtitle: Text(
          country.dialCode,
          style: Theme.of(context).textTheme.caption!.copyWith(
                fontWeight: FontWeight.w400,
                color: const Color(0xFF616161),
              ),
        ),
        onTap: () {
          Navigator.pop(context, country);
        },
      );
  @override
  void debugFillProperties(final DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<Country>('country', country));
  }
}
