import 'package:coupons/colors.dart';
import 'package:coupons/models/country.dart';
import 'package:coupons/providers/countries.dart';
import 'package:coupons/screens/couponPage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart';

class StorePage extends StatefulWidget {
  final Store store;

  const StorePage({Key key, this.store}) : super(key: key);
  @override
  _StorePageState createState() => _StorePageState();
}

class _StorePageState extends State<StorePage> {
  @override
  Widget build(BuildContext context) {
    var couponData = Provider.of<CountriesProvider>(context);
    return Stack(
      children: [
        Opacity(
          opacity: 0.4,
          child: Image.network(
            'https://coupons.buycheapkeys.com/storage/' + widget.store.photo,
            fit: BoxFit.cover,
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
          ),
        ),
        Scaffold(
          appBar: AppBar(
            backgroundColor: mainColor,
            title: Text(widget.store.title),
            elevation: 10,
          ),
          backgroundColor: mainColor.withOpacity(0.9),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: ListView.builder(
              itemCount: widget.store.coupons.length,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 15.0),
                  child: Container(
                    height: 120,
                    width: double.infinity,
                    child: Stack(
                      children: [
                        Align(
                          alignment: Alignment.center,
                          child: Image.asset(
                            'assets/images/card.png',
                            fit: BoxFit.cover,
                          ),
                        ),
                        Align(
                          alignment: Alignment.topCenter,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: verticalText("Valid for".tr() + " "+
                                widget.store.coupons[index].expiryDate
                                    .difference(DateTime.now())
                                    .inDays
                                    .toString() +
                                " " +
                                "days".tr()),
                          ),
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: Text(
                            widget.store.coupons[index].offer,
                            style: TextStyle(
                                color: mainColor,
                                fontSize: 40,
                                fontWeight: FontWeight.w900),
                          ),
                        ),
                        Align(
                          alignment: Alignment.topCenter,
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Container(
                            margin: EdgeInsets.only(bottom: 5),
                            width: 120,
                            height: 30,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                color: Colors.orange[900]),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => CouponPage(
                                          store: couponData
                                              .getStorebyId(widget.store.id)
                                              .title,
                                          coupon: couponData.getcouponbyid(
                                              widget.store.coupons[index].id,
                                              widget.store.id),
                                        )));
                              },
                              child: Center(
                                  child: Text(
                                'Getoffer',
                                textAlign: TextAlign.center,
                                style: TextStyle(color: Colors.white),
                              ).tr()),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}

Widget verticalText(String text) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      text.contains('-')
          ? Text(
              'Expired',
              style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
            )
          : Text(
              text,
              style: TextStyle(
                color: Colors.green[900],
                fontWeight: FontWeight.w900,
                letterSpacing: 0.5,
              ),
            ),
      Divider(
        height: 5,
        thickness: 1,
      ),
    ],
  );
}
