import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_app/model/project_item_model.dart';

class ProjectBloc {
  StreamController<List<Project>> projectController =
      new StreamController<List<Project>>();
  var collection = Firestore.instance.collection('project');

  dispose() {
    projectController.close();
  }

  void getProject() {
    FirebaseAuth.instance.currentUser().then((user) {
      collection
          .where('user_id', isEqualTo: user.uid)
          .snapshots()
          .listen((event) {
        List<Project> projects = new List<Project>();
        projects =
            event.documents.map((ds) => Project.fromSnapshot(ds)).toList();
        projectController.sink.add(projects);
      });
    });
  }

  Future<bool> createProject(Project project) async {
    try {
      await collection.document().setData(Project.toJson(project));
      return true;
    } catch (e, s) {
      print(s);
      return false;
    }
  }
}
