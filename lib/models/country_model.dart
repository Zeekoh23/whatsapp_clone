import 'package:flutter/material.dart';

class CountryModel with ChangeNotifier {
  final String name;
  final String code;
  final String flag;

  CountryModel({required this.name, required this.code, required this.flag});
}
