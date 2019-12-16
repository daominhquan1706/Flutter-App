import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/bloc/kanban_bloc.dart';
import 'package:flutter_app/helper/color.dart';
import 'package:flutter_app/helper/widget_helper.dart';
import 'package:flutter_app/model/stage_item_model.dart';
import 'package:flutter_app/model/task_item_model.dart';
import 'package:flutter_app/resource/kanban_board/kan_ban_page.dart';
import 'package:flutter_app/resource/kanban_board/task_item.dart';

class StageItemPage extends StatefulWidget {
  final Stage stage;
  final KanBanState state;
  final Function(KanBanState state) onChangeState;
  final bool isEditing;
  final KanBanBloc bloc;

  const StageItemPage({
    Key key,
    @required this.stage,
    @required this.state,
    @required this.onChangeState,
    @required this.isEditing,
    this.bloc,
  }) : super(key: key);

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
                return Container(
                  color: AppColor.stageColor,
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        _buildTopBar(list.length),
                        ...list.map((task) {
                          return TaskItem(
                            task: task,
                          );
                        }).toList(),
                        bottomStage(),
                      ],
                    ),
                  ),
                );
              }

              return bottomStage();
            },
          ),
        ),
      ),
    );
  }

  Widget bottomStage() {
    return widget.state == KanBanState.AddNewTaskState && widget.isEditing
        ? _buildInputTask()
        : _buildButtonAdd();
  }

  Widget _buildButtonAdd() {
    return Container(
      color: AppColor.stageColor,
      child: ListTile(
        onTap: () {
          widget.onChangeState(KanBanState.AddNewTaskState);
        },
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
    return Container(
      color: AppColor.stageColor,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            MyCustomTextField(
              controller: taskController,
              hintText: 'Nhập tên của cột...',
            ),
            SizedBox(
              height: 8,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                MyCustomButton(
                  onPressed: () {
                    widget.onChangeState(KanBanState.NormalState);
                  },
                  text: 'Hủy bỏ',
                ),
                SizedBox(
                  width: 8,
                ),
                MyCustomButton(
                  onPressed: _onAddTask,
                  text: 'Thêm Thẻ',
                  borderColor: Color(0xff49ED45),
                  backgroundColor: Color(0xff49ED45).withOpacity(0.25),
                  textColor: Color(0xff92B4AC),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildTopBar(int length) {
    return Container(
      color: AppColor.stageColor,
      child: ListTile(
        title: Text(
          widget.stage.stageName,
          style: TextStyle(color: AppColor.titleTextColor),
        ),
        subtitle: Text(
          "$length thẻ",
          style: TextStyle(color: AppColor.subTitleTextColor),
        ),
      ),
    );
  }

  void _onAddTask() {
    print("add task");

    widget.bloc.addNewTask(widget.stage, taskController.text);
    taskController = new TextEditingController();
    widget.onChangeState(KanBanState.NormalState);
    setState(() {});
  }
}

enum StageState {
  AddingStageState,
  NormalState,
}
