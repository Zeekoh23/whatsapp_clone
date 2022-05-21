import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/country_model.dart';

class CountryList extends StatefulWidget {
  CountryList({Key? key, this.setCountryData}) : super(key: key);
  final Function? setCountryData;

  _CountryListState createState() => _CountryListState();
}

class _CountryListState extends State<CountryList> {
  @override
  Widget build(BuildContext context) {
    final country = Provider.of<CountryModel>(context, listen: false);
    return InkWell(
      onTap: () {
        widget.setCountryData!(country);
      },
      child: Card(
        margin: const EdgeInsets.all(0.30),
        child: Container(
          height: 60,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          child: Row(children: [
            Image.asset(
              'assets/images/${country.flag}',
              height: 25,
              width: 25,
            ),
            const SizedBox(
              width: 15,
            ),
            Text(country.name),
            Expanded(
              child: Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(country.code),
                  ],
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
