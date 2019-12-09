import 'package:flutter/material.dart';
import 'package:flutter_app/model/task.dart';

var borderRadius2 = BorderRadius.all(
  Radius.circular(10),
);

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 50,
            ),
            _myTopBar(),
            ...Task.getLists(1).map((f) {
              return TaskItem(
                task: f,
              );
            }).toList(),
            ...Task.getLists(1).map((f) {
              return TaskItem(
                task: f,
              );
            }).toList(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {},
      ),
    );
  }

  Widget _myTopBar() {
    return ListTile(
      leading: Container(
        height: 45,
        width: 45,
        decoration:
            BoxDecoration(color: Colors.grey, borderRadius: borderRadius2),
      ),
      title: Text("Đào Minh Quân"),
      subtitle: Text("project manager"),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Icon(
            Icons.sort,
          ),
          SizedBox(
            width: 10,
          ),
          Icon(
            Icons.search,
          ),
        ],
      ),
    );
  }
}

class TaskItem extends StatelessWidget {
  final Task task;

  const TaskItem({Key key, this.task}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0, left: 12, right: 12),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: borderRadius2, color: Colors.grey.shade300),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListTile(
            title: Container(
                decoration: BoxDecoration(
                  border: Border(
                    left: BorderSide(color: Colors.green, width: 3),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text(task.title),
                )),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: 10,
                ),
                Text(task.content),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: <Widget>[
                    Icon(
                      Icons.insert_drive_file,
                      size: 16,
                      color: Colors.grey.shade400,
                    ),
                    Text(task.documentAmount.toString()),
                    SizedBox(
                      width: 15,
                    ),
                    Icon(
                      Icons.format_list_bulleted,
                      size: 18,
                      color: Colors.grey.shade500,
                    ),
                    Text(task.documentAmount.toString()),
                    SizedBox(
                      width: 15,
                    ),
                    Icon(
                      Icons.calendar_today,
                      size: 18,
                      color: Colors.grey.shade400,
                    ),
                    Text(task.date),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
