import 'package:flutter/material.dart';
import '../models/country_model.dart';

class CountryProvider with ChangeNotifier {
  String countryname = 'India';
  String countrycode = '+91';
  List<CountryModel> countries = [
    CountryModel(name: 'Nigeria', code: '+234', flag: 'nigeria.png'),
    CountryModel(
      name: 'India',
      code: '+91',
      flag: 'india.webp',
    ),
    CountryModel(name: 'Pakistan', code: '+92', flag: 'pakistan.webp'),
    CountryModel(
      name: 'United States of America',
      code: '+1',
      flag: 'USA.webp',
    ),
    CountryModel(name: 'South Africa', code: '+27', flag: 'southafrica.webp'),
    CountryModel(
      name: 'Afghanistan',
      code: '+93',
      flag: 'afghanistan.webp',
    ),
    CountryModel(
      name: 'United Kingdom',
      code: '+44',
      flag: 'england.webp',
    ),
    CountryModel(name: 'Italy', code: '+39', flag: 'Italy.webp'),
    CountryModel(name: 'Nigeria', code: '+234', flag: 'nigeria.png'),
    CountryModel(
      name: 'India',
      code: '+91',
      flag: 'india.webp',
    ),
    CountryModel(name: 'Pakistan', code: '+92', flag: 'pakistan.webp'),
    CountryModel(
      name: 'United States of America',
      code: '+1',
      flag: 'USA.webp',
    ),
    CountryModel(name: 'South Africa', code: '+27', flag: 'southafrica.webp'),
    CountryModel(
      name: 'Afghanistan',
      code: '+93',
      flag: 'afghanistan.webp',
    ),
    CountryModel(
      name: 'United Kingdom',
      code: '+44',
      flag: 'england.webp',
    ),
    CountryModel(name: 'Italy', code: '+39', flag: 'Italy.webp'),
  ];
}
