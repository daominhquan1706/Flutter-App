import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_app/model/project_item_model.dart';
import 'package:flutter_app/model/stage_item_model.dart';

class KanBanBloc {
  StreamController<List<Stage>> listStageController =
      new StreamController<List<Stage>>();
  List<Stage> list = [];
  final Project project;
  var collection = Firestore.instance.collection('stage');
  KanBanBloc.fromProject(this.project) {
    getListStage();
  }

  dispose() {
    listStageController.close();
  }

  void getListStage() {
    collection
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
    await collection.document().setData(state.toJson());
  }
}
