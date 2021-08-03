// To parse this JSON data, do
//
//     final rumahSakitModel = rumahSakitModelFromJson(jsonString);

import 'dart:convert';

List<RumahSakitModel> rumahSakitModelFromJson(String str) =>
    List<RumahSakitModel>.from(
        json.decode(str).map((x) => RumahSakitModel.fromJson(x)));

String rumahSakitModelToJson(List<RumahSakitModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class RumahSakitModel {
  RumahSakitModel({
    this.name,
    this.address,
    this.region,
    this.phone,
    this.province,
  });

  String name;
  String address;
  String region;
  String phone;
  String province;

  factory RumahSakitModel.fromJson(Map<String, dynamic> json) =>
      RumahSakitModel(
        name: json["name"],
        address: json["address"],
        region: json["region"],
        phone: json["phone"] == null ? null : json["phone"],
        province: json["province"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "address": address,
        "region": region,
        "phone": phone == null ? null : phone,
        "province": province,
      };
}
