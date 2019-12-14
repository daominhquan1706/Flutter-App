import 'package:cloud_firestore/cloud_firestore.dart';

class Stage {
  String id;
  String stageName;
  Timestamp createDate;
  List<String> tasks;

  Stage.fromSnapshot(DocumentSnapshot snapshot) {
    this.id = snapshot.documentID;
    this.stageName = snapshot['stage_name'];
    this.createDate = snapshot['create_date'];
    this.tasks = snapshot['tasks'];
  }

  Map<String, dynamic> toJson(Stage item) {
    Map<String, dynamic> json;
    json['stage_name'] = item.stageName;
    json['create_date'] = item.createDate;
    json['tasks'] = item.tasks;
    return json;
  }
}
