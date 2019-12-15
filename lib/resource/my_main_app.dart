import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/bloc/project_bloc.dart';
import 'package:flutter_app/model/project_item_model.dart';
import 'package:flutter_app/model/task_item_model.dart';
import 'package:flutter_app/resource/create_project_page.dart';
import 'package:flutter_app/resource/kanban_board/kan_ban_page.dart';

var borderRadius2 = BorderRadius.all(
  Radius.circular(10),
);

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  FirebaseUser user;
  ProjectBloc bloc = new ProjectBloc();

  @override
  void initState() {
    FirebaseAuth.instance.currentUser().then((indexUser) {
      user = indexUser;
      setState(() {});
    });
    bloc.getProject();
    super.initState();
  }

  @override
  void dispose() {
    bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(),
      floatingActionButton: _buildFloatingActionButton(),
      drawer: _buildDrawer(),
    );
  }

  Widget _myTopBar() {
    var title = Text("${user?.displayName}");
    var subtitle = Text(
      "${user?.email}",
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
    var avatar = Container(
      height: 45,
      width: 45,
      decoration: BoxDecoration(
        color: Colors.grey,
        borderRadius: borderRadius2,
      ),
      child: user == null ? Container() : Image.network("${user?.photoUrl}"),
    );
    return ListTile(
      leading: avatar,
      title: title,
      subtitle: subtitle,
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

  Widget _buildBody() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            height: 40,
          ),
          _myTopBar(),
          Divider(),
          Padding(
            padding: const EdgeInsets.only(top: 8, left: 8),
            child: Text("Projects"),
          ),
          _buildListProject(),
        ],
      ),
    );
  }

  Widget _buildFloatingActionButton() {
    return FloatingActionButton(
      child: Icon(Icons.add),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) => CreateProjectPage(bloc),
          ),
        );
      },
    );
  }

  Widget _buildDrawer() {
    var imageUrl =
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT4NWO61pCCzLTe6L0FXeVgkdT3bsHjnOVAAqo-0TA6UeG-eoLg&s";
    var avatar = Container(
      height: 50,
      width: 50,
      child: user == null
          ? Container()
          : Image.network(user?.photoUrl ?? imageUrl),
    );
    return Drawer(
      child: Column(
        children: <Widget>[
          DrawerHeader(
            child: ListTile(
              leading: avatar,
              title: Text("${user?.displayName}"),
              subtitle: Text("${user?.email}"),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildListProject() {
    return StreamBuilder(
      stream: bloc.projectController.stream,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<Project> list = snapshot.data;
          return list.isEmpty
              ? Text("you dont have project... please create project")
              : Column(
                  children: list
                      .map(
                        (project) => _buildProjectItem(project),
                      )
                      .toList(),
                );
        } else {
          return CircularProgressIndicator();
        }
      },
    );
  }

  Widget _buildProjectItem(Project project) {
    return Card(
      child: ListTile(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) {
                return KanBanPage(project);
              },
            ),
          );
        },
        title: Text(project.projectName),
        subtitle: Text(project.createDate.toString()),
        leading: Icon(Icons.book),
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
                    Text(task.toString()),
                    SizedBox(
                      width: 15,
                    ),
                    Icon(
                      Icons.format_list_bulleted,
                      size: 18,
                      color: Colors.grey.shade500,
                    ),
                    Text(task.toString()),
                    SizedBox(
                      width: 15,
                    ),
                    Icon(
                      Icons.calendar_today,
                      size: 18,
                      color: Colors.grey.shade400,
                    ),
                    Text("${task.createDate}"),
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
