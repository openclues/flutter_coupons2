import 'package:coupons/models/ads.dart';
import 'package:coupons/models/country.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:dio_http_cache/dio_http_cache.dart';

class CountriesProvider with ChangeNotifier {
  static const String baseUrl = "https://coupons.buycheapkeys.com/api/";

  bool choosen;
  List<Country> _countriesList = [];

  List<Country> get countries {
    return [..._countriesList];
  }

  String countryName;

  saveCountry(String country) async {
    if (await FlutterSecureStorage().read(key: "country") == null) {
      FlutterSecureStorage().write(key: "country", value: country);
    } else {
      await FlutterSecureStorage().deleteAll();
      FlutterSecureStorage().write(key: "country", value: country);
    }
  }

  Future<String> getCountry() async {
    String country = await FlutterSecureStorage().read(key: "country");

    return country;
  }

  Future<List<Country>> getallcountries() async {
    Dio dio = Dio();
    dio.interceptors.add(DioCacheManager(CacheConfig()).interceptor);

    Response response = await dio.get(baseUrl + "countries",
        options: buildCacheOptions(Duration(days: 7),
            forceRefresh: true, maxStale: Duration(days: 7)));
    List<Country> dara = (response.data as List).map((x) {
      return Country.fromJson(x);
    }).toList();
    _countriesList.addAll(dara);
    return dara;
  }

  Future<List<Store>> getallstores({String search}) async {
    Dio dio = Dio();
    String name = await getCountry();

    dio.interceptors.add(
        DioCacheManager(CacheConfig(baseUrl: baseUrl + "stores/"))
            .interceptor);
    String url = (baseUrl + "stores/$name").replaceAll(" ", "%20");
    url.replaceAll(' ', '%20');
    print(url);
    Response response = await dio.get(url,
        options: buildCacheOptions(Duration(days: 7),
            forceRefresh: true, maxStale: Duration(days: 10)));
    List<Store> dara = (response.data as List).map((x) {
      return Store.fromJson(x);
    }).toList();
    _stores.clear();
    _stores.addAll(dara);

    return dara;
  }

  List<Store> _stores = [];

  List<Store> get stores {
    return [..._stores];
  }

  Store getStorebyId(int id) {
    return stores.where((element) => element.id == id).first;
  }

  Coupon getcouponbyid(int couponId, int storeId) {
    Store store = _stores.where((element) => element.id == storeId).first;
    return store.coupons.where((element) => element.id == couponId).first;
  }

  Future<List<Ads>> getallads() async {
    Response response = await Dio().get(baseUrl + "ads",
        options: buildCacheOptions(Duration(days: 7),
            forceRefresh: true, maxStale: Duration(days: 7)));
    List<Ads> dara = (response.data as List).map((x) {
      return Ads.fromJson(x);
    }).toList();
    return dara;
  }
}
