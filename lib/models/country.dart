// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

List<Store> welcomeFromJson(String str) => List<Store>.from(json.decode(str).map((x) => Store.fromJson(x)));

String welcomeToJson(List<Store> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Store {
    Store({
        this.id,
        this.title,
        this.createdAt,
        this.updatedAt,
        this.photo,
        this.coupons,
    });

    int id;
    String title;
    DateTime createdAt;
    DateTime updatedAt;
    String photo;
    List<Coupon> coupons;

    factory Store.fromJson(Map<String, dynamic> json) => Store(
        id: json["id"],
        title: json["title"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        photo: json["photo"],
        coupons: List<Coupon>.from(json["coupons"].map((x) => Coupon.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "photo": photo,
        "coupons": List<dynamic>.from(coupons.map((x) => x.toJson())),
    };
}

class Country {
    Country({
        this.id,
        this.name,
        this.createdAt,
        this.updatedAt,
    });

    int id;
    String name;
    DateTime createdAt;
    DateTime updatedAt;

    factory Country.fromJson(Map<String, dynamic> json) => Country(
        id: json["id"],
        name: json["name"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
    };
}


class Coupon {
    Coupon({
        this.id,
        this.coupon,
        this.storeId,
        this.expiryDate,
        this.createdAt,
        this.updatedAt,
        this.link,
        this.offer,
        this.countryTag,
    });

    int id;
    String coupon;
    String storeId;
    DateTime expiryDate;
    String createdAt;
    String updatedAt;
    String link;
    String offer;
    String countryTag;

    factory Coupon.fromJson(Map<String, dynamic> json) => Coupon(
        id: json["id"],
        coupon: json["coupon"],
        storeId: json["store_id"],
        expiryDate: DateTime.parse(json["expiry_date"]),
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        link: json["link"],
        offer: json["offer"],
        countryTag: json["country_tag"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "coupon": coupon,
        "store_id": storeId,
        "expiry_date": "${expiryDate.year.toString().padLeft(4, '0')}-${expiryDate.month.toString().padLeft(2, '0')}-${expiryDate.day.toString().padLeft(2, '0')}",
        "created_at": createdAt,
        "updated_at": updatedAt,
        "link": link,
        "offer": offer,
        "country_tag": countryTag,
    };
}
