import 'package:coupons/colors.dart';
import 'package:flutter/material.dart';

class Information extends StatefulWidget {
  @override
  _InformationState createState() => _InformationState();
}

class _InformationState extends State<Information> {
  bool openAboutus = false;
  bool openContactUs = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mainColor,
        title: Text("Information"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            GestureDetector(
              onTap: () {
                setState(() {
                  openAboutus = !openAboutus;
                });
              },
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(7)),
                child: ListTile(
                  title: Center(
                    child: Text(
                      "About us",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  trailing: Icon(Icons.arrow_drop_down),
                ),
              ),
            ),
            openAboutus
                ? Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(7),
                        color: Colors.white,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                            "An About Us page helps your company make a good first impression, and is critical for building customer trust and loyalty. An About Us page should make sure to cover basic information about the store and its founders, explain the company's purpose and how it differs from the competition, and encourage discussion and interaction. Here are some free templates, samples, and example About Us pages to help your ecommerce store stand out from the crowd."),
                      ),
                    ),
                  )
                : Divider(
                  color: buttonColor,
                  ),
            GestureDetector(
              onTap: () {
                setState(() {
                  openContactUs = !openContactUs;
                });
              },
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(7)),
                child: ListTile(
                  title: Center(
                    child: Text(
                      "Contact the developer",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  trailing: Icon(Icons.arrow_drop_down),
                ),
              ),
            ),
            openContactUs
                ? Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(7),
                        color: Colors.white,
                      ),
                      child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                    "Whatsapp",
                                    style: TextStyle(
                                        color: mainColor,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    "Email Us",
                                    style: TextStyle(
                                        color: mainColor,
                                        fontWeight: FontWeight.bold),
                                  )
                                ],
                              )
                            ],
                          )),
                    ),
                  )
                : Text(""),
          ],
        ),
      ),
    );
  }
}
