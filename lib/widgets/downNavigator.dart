import 'package:coupons/screens/countryChoose.dart';
import 'package:coupons/screens/myHomePage.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import '../screens/information.dart';

class BottomNavigatorWidget extends StatefulWidget {
  final page;

  const BottomNavigatorWidget({Key key, this.page}) : super(key: key);

  @override
  _BottomNavigatorWidgetState createState() => _BottomNavigatorWidgetState();
}

class _BottomNavigatorWidgetState extends State<BottomNavigatorWidget> {
  List pages = [
    Information(),
    MyHomePage(),
    CountryChoose(),
  ];

  int _page = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        index: _page,
        backgroundColor: Colors.transparent,
        animationCurve: Curves.easeInOut,
        items: <Widget>[
          Icon(
            Icons.info_outline,
            size: 30,
          ),
          Icon(Icons.storefront_sharp, size: 30),
          Icon(Icons.place_outlined, size: 30),
        ],
        onTap: (index) {
          setState(() {
            _page = index;
          });
        },
      ),
      body: widget.page == null ? pages[_page] : pages[widget.page],
    );
  }
}
