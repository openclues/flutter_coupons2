import 'package:coupons/colors.dart';
import 'package:coupons/models/country.dart';
import 'package:coupons/providers/countries.dart';
import 'package:coupons/widgets/downNavigator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart';

class CountryChoose extends StatefulWidget {
  @override
  _CountryChooseState createState() => _CountryChooseState();
}

class _CountryChooseState extends State<CountryChoose> {
  String name;
  @override
  void initState() {
    super.initState();
    if (Provider.of<CountriesProvider>(context, listen: false)
            .countries
            .length ==
        0) {
      Provider.of<CountriesProvider>(context, listen: false).getallcountries();
    }
  }

  List<String> languages = ["Arabic", "English"];
  GlobalKey<FormState> _form = GlobalKey();
  GlobalKey<FormState> _language = GlobalKey();

  @override
  Widget build(BuildContext context) {
    var stores = Provider.of<CountriesProvider>(context);

    return Scaffold(
        body: FutureBuilder(
            future: stores.getallcountries(),
            builder:
                (BuildContext context, AsyncSnapshot<List<Country>> snapshot) {
              if (snapshot.data == null) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              List<String> country = snapshot.data.map((e) => e.name).toList();

              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "chooseCounty",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 25,
                            
                            height: 1.5),
                      ).tr(),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: buttonColor),
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                child: Text("Country"),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Container(
                                height: 60,
                                width: 1,
                                color: Colors.white,
                              ),
                            ),
                            Expanded(
                              child: Form(
                                key: _form,
                                child: DropdownButtonFormField(
                                  value: country.first,
                                  dropdownColor: buttonColor,
                                  elevation: 10,
                                  onChanged: (value) {},
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.all(20),
                                    fillColor: buttonColor,
                                  ),
                                  onSaved: (value) {
                                    setState(() {
                                      name = value;
                                    });
                                  },
                                  items: country.map((e) {
                                    return DropdownMenuItem<String>(
                                      value: e,
                                      child: Container(
                                        child: Row(
                                          children: [
                                            Icon(Icons.place_outlined),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 8.0),
                                              child: Text(
                                                e,
                                                style:
                                                    TextStyle(color: mainColor),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  }).toList(),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: buttonColor),
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                child: Text("Language"),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Container(
                                height: 60,
                                width: 1,
                                color: Colors.white,
                              ),
                            ),
                            Expanded(
                              child: Form(
                                key: _language,
                                child: DropdownButtonFormField(
                                  value: "English",
                                  dropdownColor: buttonColor,
                                  elevation: 10,
                                  onChanged: (value) {},
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.all(20),
                                    fillColor: buttonColor,
                                  ),
                                  onSaved: (value) {
                                    setState(() {
                                      if (value == "English") {
                                        EasyLocalization.of(context).locale =
                                            Locale('en', 'US');
                                      } else {
                                        setState(() {
                                          EasyLocalization.of(context).locale =
                                              Locale('en', 'EG');
                                        });
                                      }
                                    });
                                  },
                                  items: languages.map((e) {
                                    return DropdownMenuItem<String>(
                                      value: e,
                                      child: Container(
                                        child: Row(
                                          children: [
                                            Icon(Icons.translate_rounded),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 8.0),
                                              child: Text(
                                                e,
                                                style:
                                                    TextStyle(color: mainColor),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  }).toList(),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      GestureDetector(
                        onTap: () async {
                          _form.currentState.save();
                          _language.currentState.save();
                          await stores.saveCountry(name);
                          if (name == await stores.getCountry()) {
                            Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute(
                                    builder: (context) =>
                                        BottomNavigatorWidget()),
                                (Route<dynamic> route) => false);
                          } else {
                            null;
                          }
                        },
                        child: Container(
                          height: 50,
                          width: double.infinity,
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.white,
                          ),
                          child: Center(child: Text('Submit').tr()),
                        ),
                      ),
                      SizedBox(
                        height: 40,
                      ),
                    ],
                  ),
                ),
              );
            })

        // body: countries.length == 0 ?  Center(child: Text('There is no countries yet'),)  : Center(
        //   child: Column(
        //     mainAxisAlignment: MainAxisAlignment.center,
        //     children: [
        //       Padding(
        //         padding: EdgeInsets.all(20),
        //         child: Container(
        //           decoration: BoxDecoration(
        //               borderRadius: BorderRadius.circular(15),
        //               color: buttonColor),
        //           child: DropdownButtonFormField(
        //             value: countries.first,
        //             onChanged: (value) {
        //               setState(() {
        //                 name = value;
        //               });
        //             },
        //             items: countries.map((e) {
        //               return DropdownMenuItem<String>(
        //                 value: e,
        //                 child: Padding(
        //                   padding: const EdgeInsets.all(8.0),
        //                   child: Row(
        //                     children: <Widget>[
        //                       Icon(Icons.star),
        //                       Text(
        //                         e,
        //                         style: TextStyle(color: Colors.white),
        //                       ),
        //                     ],
        //                   ),
        //                 ),
        //               );
        //             }).toList(),
        //           ),
        //         ),
        //       )
        //     ],
        //   ),
        // ),
        );
  }
}
