import 'package:flutter/material.dart';
import 'package:flutter_app/helper/color.dart';
import 'package:flutter_app/model/task_item_model.dart';

class TaskItem extends StatelessWidget {
  final Task task;

  const TaskItem({Key key, this.task}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColor.cardColor,
      child: ListTile(
        title: Text(
          task.title,
          style: TextStyle(
            color: AppColor.cardTextTitleColor,
          ),
        ),
        trailing: Icon(
          Icons.more_vert,
          color: AppColor.cardTextTitleColor,
        ),
      ),
    );
  }
}
