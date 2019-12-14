import 'package:cloud_firestore/cloud_firestore.dart';

class Task {
  String id;
  String userId;
  String projectId;
  String title;
  String content;
  String createDate;
  bool isDone;
  List<String> subTasks;

  Task.fromSnapshot(DocumentSnapshot snapshot) {
    this.id = snapshot.documentID;
    this.userId = snapshot['user_id'];
    this.projectId = snapshot['project_id'];
    this.title = snapshot['title'];
    this.content = snapshot['content'];
    this.createDate = snapshot['create_date'];
    this.isDone = snapshot['is_done'];
    this.subTasks = snapshot['sub_tasks'];
  }
}
