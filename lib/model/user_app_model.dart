import 'package:cloud_firestore/cloud_firestore.dart';

class UserApp {
  String id;
  String name;
  String email;
  Timestamp createDate;

  UserApp.fromSnapshot(DocumentSnapshot snapshot) {
    this.id = snapshot.documentID;
    this.name = snapshot['name'];
    this.email = snapshot['email'];
    this.createDate = snapshot['create_date'];
  }

  Map<String, dynamic> toJson(UserApp item) {
    Map<String, dynamic> json = {};
    json['name'] = item.name;
    json['email'] = item.email;
    json['create_date'] = item.createDate;
    return json;
  }
}
