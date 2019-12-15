import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/helper/color.dart';
import 'package:flutter_app/model/stage_item_model.dart';
import 'package:flutter_app/model/task_item_model.dart';
import 'package:flutter_app/resource/kanban_board/kan_ban_page.dart';

class StageItemPage extends StatefulWidget {
  final Stage stage;

  final KanBanState state;

  const StageItemPage({Key key, @required this.stage, @required this.state})
      : super(key: key);

  @override
  _StageItemPageState createState() => _StageItemPageState();
}

class _StageItemPageState extends State<StageItemPage> {
  TextEditingController taskController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: StreamBuilder(
            stream: Firestore.instance
                .collection('task')
                .where('project_id', isEqualTo: widget.stage.projectId)
                .where('stage_id', isEqualTo: widget.stage.id)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                QuerySnapshot qr = snapshot.data;

                List<Task> list =
                    qr.documents.map((f) => Task.fromSnapshot(f)).toList();
                return Column(children: [
                  Container(
                    color: AppColor.stageColor,
                    child: ListTile(
                      title: Text(
                        widget.stage.stageName,
                        style: TextStyle(color: AppColor.titleTextColor),
                      ),
                      subtitle: Text(
                        "${list.length} thẻ",
                        style: TextStyle(color: AppColor.subTitleTextColor),
                      ),
                    ),
                  ),
                  ...list.map((task) {
                    return ListTile();
                  }).toList(),
                  bottomStage(),
                ]);
              }

              return bottomStage();
            },
          ),
        ),
      ),
    );
  }

  Widget bottomStage() {
    return widget.state == KanBanState.AddNewTaskState
        ? _buildInputTask()
        : _buildAddTaskButton();
  }

  Widget _buildAddTaskButton() {
    return Container(
      color: AppColor.stageColor,
      child: ListTile(
        onTap: () {},
        title: Row(
          children: <Widget>[
            Icon(Icons.add, color: AppColor.lightBlueTextColor),
            Text(
              " Thêm thẻ",
              style: TextStyle(color: AppColor.lightBlueTextColor),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInputTask() {
    return TextField(
      controller: taskController,
    );
  }
}

enum StageState {
  AddingStageState,
  NormalState,
}
