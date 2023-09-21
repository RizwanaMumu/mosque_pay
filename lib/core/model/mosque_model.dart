
import 'dart:convert';

List<MosqueModel> mosqueModelFromJson(String str) => List<MosqueModel>.from(json.decode(str).map((x) => MosqueModel.fromJson(x)));

class MosqueModel {
  String? id;
  String? name;
  String? town;

  MosqueModel({this.id, this.name, this.town});

  MosqueModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    town = json['town'];
  }
}