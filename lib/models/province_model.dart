// To parse this JSON data, do
//
//     final provinceModel = provinceModelFromJson(jsonString);

import 'dart:convert';

ProvinceModel provinceModelFromJson(String str) =>
    ProvinceModel.fromJson(json.decode(str));

String provinceModelToJson(ProvinceModel data) => json.encode(data.toJson());

class ProvinceModel {
  ProvinceModel({
    this.data,
  });

  List<Datum> data;

  factory ProvinceModel.fromJson(Map<String, dynamic> json) => ProvinceModel(
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datum {
  Datum({
    this.fid,
    this.kodeProvi,
    this.provinsi,
    this.kasusPosi,
    this.kasusSemb,
    this.kasusMeni,
  });

  int fid;
  int kodeProvi;
  String provinsi;
  int kasusPosi;
  int kasusSemb;
  int kasusMeni;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        fid: json["fid"],
        kodeProvi: json["kodeProvi"],
        provinsi: json["provinsi"],
        kasusPosi: json["kasusPosi"],
        kasusSemb: json["kasusSemb"],
        kasusMeni: json["kasusMeni"],
      );

  Map<String, dynamic> toJson() => {
        "fid": fid,
        "kodeProvi": kodeProvi,
        "provinsi": provinsi,
        "kasusPosi": kasusPosi,
        "kasusSemb": kasusSemb,
        "kasusMeni": kasusMeni,
      };
}
