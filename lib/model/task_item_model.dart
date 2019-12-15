import 'package:cloud_firestore/cloud_firestore.dart';

class Task {
  String id;
  String userId;
  String stageId;
  String projectId;
  String title;
  String content;
  Timestamp createDate;
  bool isDone;
  List<String> subTasks;

  Task();

  Task.fromSnapshot(DocumentSnapshot snapshot) {
    this.id = snapshot.documentID;
    this.userId = snapshot['user_id'];
    this.stageId = snapshot['stage_id'];
    this.projectId = snapshot['project_id'];
    this.title = snapshot['title'];
    this.content = snapshot['content'];
    this.createDate = snapshot['create_date'];
    this.isDone = snapshot['is_done'];
    this.subTasks = snapshot['sub_tasks'];
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = new Map<String, dynamic>();
    json['user_id'] = this.userId;
    json['stage_id'] = this.stageId;
    json['project_id'] = this.projectId;
    json['title'] = this.title;
    json['content'] = this.content;
    json['create_date'] = this.createDate;
    json['is_done'] = this.isDone;
    json['sub_tasks'] = this.subTasks;
    return json;
  }
}
