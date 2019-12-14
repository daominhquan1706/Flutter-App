import 'package:cloud_firestore/cloud_firestore.dart';

class Project {
  String id;
  String projectName;
  String userId;
  Timestamp createDate;
  List<String> stages;

  Project();

  Project.fromSnapshot(DocumentSnapshot snapshot) {
    this.id = snapshot.documentID;
    this.projectName = snapshot['project_name'];
    this.userId = snapshot['user_id'];
    this.createDate = snapshot['create_date'];
    this.stages = snapshot['stages'];
  }

  static Map<String, dynamic> toJson(Project item) {
    Map<String, dynamic> json = {};
    json['project_name'] = item.projectName;
    json['user_id'] = item.userId;
    json['create_date'] = item.createDate;
    json['stages'] = item.stages;
    return json;
  }
}
