// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

List<Ads> welcomeFromJson(String str) => List<Ads>.from(json.decode(str).map((x) => Ads.fromJson(x)));

String welcomeToJson(List<Ads> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Ads {
    Ads({
        this.id,
        this.photo,
        this.desc,
        this.title,
        this.createdAt,
        this.updatedAt,
    });

    int id;
    String photo;
    String desc;
    String title;
    DateTime createdAt;
    DateTime updatedAt;

    factory Ads.fromJson(Map<String, dynamic> json) => Ads(
        id: json["id"],
        photo: json["photo"],
        desc: json["desc"],
        title: json["title"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "photo": photo,
        "desc": desc,
        "title": title,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
    };
}
