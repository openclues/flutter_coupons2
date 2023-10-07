import 'package:coupons/providers/countries.dart';
import 'package:coupons/screens/countryChoose.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/downNavigator.dart';

class Loading extends StatefulWidget {
  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  @override
  void initState() {
    super.initState();
    Provider.of<CountriesProvider>(context, listen: false).getCountry();
    Provider.of<CountriesProvider>(context, listen: false).getallcountries();
    Provider.of<CountriesProvider>(context, listen: false).getallstores();
    Future.delayed(new Duration(seconds: 3), () async {
      if (await Provider.of<CountriesProvider>(context, listen: false)
              .getCountry() ==
          null) {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => CountryChoose()),
            (Route<dynamic> route) => false);
      } else {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => BottomNavigatorWidget()),
            (Route<dynamic> route) => false);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
