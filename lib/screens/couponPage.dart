import 'package:coupons/colors.dart';
import 'package:coupons/models/country.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:easy_localization/easy_localization.dart';

class CouponPage extends StatefulWidget {
  final Coupon coupon;
  final String store;

  const CouponPage({Key key, this.coupon, @required this.store})
      : super(key: key);

  @override
  _CouponPageState createState() => _CouponPageState();
}

class _CouponPageState extends State<CouponPage> {
  bool party;

  @override
  void initState() {
    getCouponStatus();
    super.initState();
    party = false;
  }

  bool justLink;

  getCouponStatus() {
    if (widget.coupon.coupon == "null1993") {
      justLink = true;
    } else {
      justLink = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mainColor,
        title: Text(
          "Getoffer",
          style: TextStyle(color: buttonColor),
        ).tr(),
      ),
      body: Container(
        height: height,
        width: double.infinity,
        child: ListView(
          children: [
            party
                ? Stack(
                    children: [
                      Image.asset(
                        'assets/images/party.gif',
                        width: width * 9,
                        fit: BoxFit.cover,
                      ),
                    ],
                  )
                : Image.asset(
                    'assets/images/notparty.gif',
                    width: width * 0.7,
                    height: height * 0.4,
                  ),
            Padding(
                padding: const EdgeInsets.all(8.0),
                child: !justLink
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Clipboard.setData(new ClipboardData(
                                      text: widget.coupon.coupon))
                                  .then((result) {
                                setState(() {
                                  party = true;
                                });
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    duration: Duration(seconds: 2),
                                    backgroundColor: Colors.white,
                                    content: Text(
                                      'The coupoun is copied.',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: mainColor,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                );
                              });
                            },
                            child: Container(
                              padding: EdgeInsets.all(20),
                              width: width * 0.2,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10)),
                              child: Center(
                                  child: Text(
                                'Copy',
                                textAlign: TextAlign.center,
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ).tr()),
                            ),
                          ),
                          Container(
                            width: width * 0.7,
                            padding: EdgeInsets.all(20),
                            decoration: BoxDecoration(
                                color: buttonColor,
                                borderRadius: BorderRadius.circular(10)),
                            child: Center(
                                child: Text(
                              widget.coupon.coupon,
                              style: TextStyle(fontWeight: FontWeight.w300),
                              textAlign: TextAlign.center,
                            )),
                          ),
                        ],
                      )
                    : Text('')),
            GestureDetector(
              onTap: () {
                _launchURL(widget.coupon.link);
              },
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 10),
                width: width,
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(width: 1, color: buttonColor)),
                child: Center(
                    child: Text(
                  "openlink",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: buttonColor, fontSize: 15),
                ).tr()),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: justLink
                  ? Text(
                      'You do not need a coupon to get this offer, just use the link and the discount will be automatically applied',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 15,
                          letterSpacing: 0.7,
                          height: 1.5,
                      ),
                    )
                  : Text(
                      'couponInfo',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 15,
                          letterSpacing: 0.7,
                          height: 1.5,
                          ),
                    ).tr(),
            ),
            GestureDetector(
              onTap: () {
                Share.share(
                    'Use this coupon ${widget.coupon.coupon} for ${widget.store} store, download this app to get good offers');
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.share,
                    color: buttonColor,
                  ),
                  SizedBox(
                    width: 3,
                  ),
                  Text(
                    "Share the coupon",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white),
                  )
                ],
              ),
            ),
            SizedBox(
              height: party ? height * 0.4 : height * 0.4,
            ),
          ],
        ),
      ),
    );
  }

  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
