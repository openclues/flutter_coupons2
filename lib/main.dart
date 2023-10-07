import 'package:coupons/colors.dart';
import 'package:coupons/providers/countries.dart';
import 'package:coupons/screens/loadingScreen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(EasyLocalization(
      supportedLocales: [Locale('en', 'US'), Locale('en', 'EG')],
      path: 'assets/translations', // <-- change patch to your
      fallbackLocale: Locale('en', 'US'),
      child: MyApp()));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: CountriesProvider(),
      child: MaterialApp(
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          fontFamily: "Cairo",
          scaffoldBackgroundColor: mainColor,
          primarySwatch: Colors.blue,
        ),
        home: Loading(),
      ),
    );
  }
}
