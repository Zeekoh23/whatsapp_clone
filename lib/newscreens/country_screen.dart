import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/country_provider.dart';
import '../widgets/country_list.dart';

class CountryScreen extends StatefulWidget {
  CountryScreen({Key? key, this.setCountryData}) : super(key: key);
  final Function? setCountryData;

  static const routename = '/countrylist';

  @override
  _CountryScreenState createState() => _CountryScreenState();
}

class _CountryScreenState extends State<CountryScreen> {
  @override
  Widget build(BuildContext context) {
    final countries =
        Provider.of<CountryProvider>(context, listen: false).countries;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 0,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(Icons.arrow_back, color: Colors.teal),
        ),
        title: const Text(
          'Choose a country',
          style: TextStyle(
              color: Colors.teal,
              fontWeight: FontWeight.w600,
              fontSize: 18,
              wordSpacing: 1),
        ),
        actions: [
          IconButton(
              icon: const Icon(Icons.search, color: Colors.teal),
              onPressed: () {}),
        ],
      ),
      body: ListView.builder(
        itemCount: countries.length,
        itemBuilder: (context, index) => ChangeNotifierProvider.value(
          value: countries[index],
          child: CountryList(
            setCountryData: widget.setCountryData,
          ),
        ),
      ),
    );
  }
}
