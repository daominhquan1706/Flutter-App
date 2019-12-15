import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_app/model/project_item_model.dart';
import 'package:flutter_app/model/stage_item_model.dart';
import 'package:flutter_app/model/task_item_model.dart';

class KanBanBloc {
  StreamController<List<Stage>> listStageController =
      new StreamController<List<Stage>>();
  List<Stage> list = [];
  final Project project;
  var collectionStage = Firestore.instance.collection('stage');
  var collectionTask = Firestore.instance.collection('task');
  KanBanBloc.fromProject(this.project) {
    getListStage();
  }

  dispose() {
    listStageController.close();
  }

  void getListStage() {
    collectionStage
        .where('project_id', isEqualTo: project.id)
        .snapshots()
        .listen((event) {
      list = event.documents.map((ds) => Stage.fromSnapshot(ds)).toList();
      listStageController.sink.add(list);
    });
  }

  Future<void> addNewStage(String text) async {
    Stage state = new Stage(
      projectId: project.id,
      createDate: Timestamp.now(),
      stageName: text,
      tasks: [],
    );
    await collectionStage.document().setData(state.toJson());
  }

  Future<void> addNewTask(Stage stage, String text) async {
    Task task = new Task()
      ..isDone = false
      ..title = text
      ..createDate = Timestamp.now()
      ..stageId = stage.id
      ..projectId = stage.projectId
      ..userId = (await FirebaseAuth.instance.currentUser()).uid;
    await collectionTask.document().setData(task.toJson());
  }
}
