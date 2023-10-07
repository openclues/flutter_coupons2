import 'package:coupons/colors.dart';
import 'package:coupons/models/ads.dart';
import 'package:coupons/models/country.dart';
import 'package:coupons/providers/countries.dart';
import 'package:coupons/screens/storePage.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart';

class MyHomePage extends StatefulWidget {
  final String name;
  MyHomePage({Key key, this.name}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String search;
  bool searchtap = false;
  @override
  Widget build(BuildContext context) {
    // WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToBottom());

    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    var data = Provider.of<CountriesProvider>(context, listen: false);
    return SafeArea(
      child: Scaffold(
        backgroundColor: mainColor,
        appBar: AppBar(
          actions: [
            Padding(
              padding: const EdgeInsets.only(
                right: 10,
              ),
              child: Padding(
                padding: const EdgeInsets.only(right: 16.0),
                child: GestureDetector(
                  onTap: data.getallcountries,
                  child: Row(
                    children: [
                      SizedBox(
                        width: 5,
                      ),
                      FutureBuilder(
                        future: data.getCountry(),
                        builder:
                            (BuildContext context, AsyncSnapshot snapshot) {
                          return snapshot.hasData
                              ? Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    snapshot.data,
                                    style: TextStyle(
                                        color: buttonColor),
                                  ),
                                )
                              : Text('');
                        },
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
          backgroundColor: mainColor,
          title: Text(
            "Coupons",
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: ListView(
            children: [
              FutureBuilder(
                future: data.getallads(),
                builder:
                    (BuildContext context, AsyncSnapshot<List<Ads>> snapshot) {
                  if (snapshot.hasError) {
                    return Center(
                        child: Text(
                      "",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                          letterSpacing: 1,
                          height: 1.5),
                    ));
                  }
                  return snapshot.hasData
                      ? Container(
                          height: height * 0.2,
                          child: ListView.builder(
                            addAutomaticKeepAlives: false,
                            addRepaintBoundaries: false,
                            dragStartBehavior: DragStartBehavior.start,
                            addSemanticIndexes: true,
                            // controller: _scrollController,
                            scrollDirection: Axis.horizontal,
                            shrinkWrap: true,
                            physics: ClampingScrollPhysics(),
                            itemCount: snapshot.data.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Padding(
                                padding: const EdgeInsets.only(
                                    right: 10.0, bottom: 10),
                                child: Container(
                                    // height: height * 0.2,
                                    width: width * 0.5,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(14),
                                        image: DecorationImage(
                                            image: NetworkImage(
                                                'https://coupons.buycheapkeys.com/storage/' +
                                                    snapshot.data[index].photo),
                                            fit: BoxFit.cover)),
                                    child: Text("")),
                              );
                            },
                          ),
                        )
                      : Text('');
                },
              ),
              Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: searchtap ? Colors.white : buttonColor,
                      borderRadius: BorderRadius.circular(4)),
                  height: width * 0.1,
                  child: Center(
                    child: Text(
                      'Stores',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: mainColor,
                      ),
                    ).tr(),
                  )),
              SizedBox(
                height: 10,
              ),
              searchtap == false
                  ? StoresWidgets(data: data, search: search)
                  : Center(
                      child: Text(
                        "There is no products yet",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}

class StoresWidgets extends StatelessWidget {
  const StoresWidgets({
    Key key,
    @required this.data,
    @required this.search,
  }) : super(key: key);

  final CountriesProvider data;
  final String search;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: data.getallstores(search: search),
      builder: (BuildContext context, AsyncSnapshot<List<Store>> snapshot) {
        if (snapshot.hasError) {
          return Center(
            child: Text(
              "There is something wrong, please try again later",
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                  letterSpacing: 1,
                  height: 1.5),
            ),
          );
        }
        return snapshot.data == null
            ? Center(
                child: CircularProgressIndicator(),
              )
            : GridView.builder(
                shrinkWrap: true,
                physics: ClampingScrollPhysics(),
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => StorePage(
                                store:
                                    data.getStorebyId(snapshot.data[index].id),
                              )));
                      print(snapshot.data[index].coupons.length);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(
                            10,
                          ),
                        ),
                        border: Border.all(color: buttonColor),
                        image: DecorationImage(
                          image: NetworkImage(
                            'https://coupons.buycheapkeys.com/storage/' +
                                snapshot.data[index].photo,
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: GridTile(
                        footer: Container(
                          color: mainColor.withOpacity(.5),
                          child: Padding(
                            padding: const EdgeInsets.all(1),
                            child: Text(
                              snapshot.data[index].title,
                              textAlign: TextAlign.center,
                              style: TextStyle(color: buttonColor),
                            ),
                          ),
                        ),
                        child: Text(''),
                      ),
                    ),
                  );
                },
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                    childAspectRatio: 3 / 2),
              );
      },
    );
  }
}
