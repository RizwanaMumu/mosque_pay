import 'dart:convert';

List<TownModel> townModelFromJson(String str) => List<TownModel>.from(json.decode(str).map((x) => TownModel.fromJson(x)));

class TownModel {
  String? id;
  String? name;

  TownModel({this.id, this.name});

  TownModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }


}