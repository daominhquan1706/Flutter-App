import 'package:cloud_firestore/cloud_firestore.dart';

class Stage {
  String id;
  String projectId;
  String stageName;
  Timestamp createDate;
  List<String> tasks;

  Stage({
    this.projectId,
    this.stageName,
    this.createDate,
    this.tasks,
  });

  Stage.fromSnapshot(DocumentSnapshot snapshot) {
    this.id = snapshot.documentID;
    this.projectId = snapshot['project_id'];
    this.stageName = snapshot['stage_name'];
    this.createDate = snapshot['create_date'];
    this.tasks = (snapshot['tasks'] as List).map((f) => f.toString()).toList();
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['project_id'] = this.projectId;
    json['stage_name'] = this.stageName;
    json['create_date'] = this.createDate;
    json['tasks'] = this.tasks;
    return json;
  }
}
