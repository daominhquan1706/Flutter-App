import 'package:flutter/material.dart';
import 'package:flutter_app/bloc/kanban_bloc.dart';
import 'package:flutter_app/model/project_item_model.dart';
import 'package:flutter_app/model/stage_item_model.dart';
import 'package:flutter_app/resource/kanban_board/stage_item_page.dart';

class KanBanPage extends StatefulWidget {
  final Project project;
  KanBanPage(this.project);

  @override
  _KanBanPageState createState() => _KanBanPageState(this.project);
}

class _KanBanPageState extends State<KanBanPage> {
  PageController pageController;
  KanBanBloc bloc;
  KanBanState currentState = KanBanState.NormalState;
  final Project project;

  _KanBanPageState(this.project);
  @override
  void initState() {
    bloc = new KanBanBloc.fromProject(project);
    pageController = new PageController(
      initialPage: 0,
      viewportFraction: 0.8,
      keepPage: true,
    );
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
      appBar: _buildAppBar(),
      backgroundColor: Colors.grey.shade400,
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return StreamBuilder<List<Stage>>(
      stream: bloc.listStageController.stream,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<Stage> list = snapshot.data;
          return PageView(
            controller: pageController,
            children: [
              ...list.map((stage) => StageItemPage(stage: stage)).toList(),
              _buildAddNewStageButton(),
            ],
          );
        }
        return CircularProgressIndicator();
      },
    );
  }

  void changeCurrentState(KanBanState state) {
    currentState = state;
    setState(() {});
  }

  TextEditingController textEditingStageController =
      new TextEditingController();
  Widget _buildAddNewStageButton() {
    return currentState == KanBanState.AddNewStageState
        ? TextField(
            controller: textEditingStageController,
            decoration: InputDecoration(labelText: "Stage name"),
          )
        : Column(
            children: <Widget>[
              RaisedButton(
                onPressed: () {
                  changeCurrentState(KanBanState.AddNewStageState);
                },
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Icon(Icons.add),
                    Text("Add new Stage"),
                  ],
                ),
              ),
            ],
          );
  }

  Widget _buildAppBar() {
    switch (currentState) {
      case KanBanState.AddNewStageState:
        return AppBar(
          leading: IconButton(
            onPressed: () {
              changeCurrentState(KanBanState.NormalState);
            },
            icon: Icon(Icons.close),
          ),
          actions: <Widget>[
            IconButton(
              onPressed: () {
                changeCurrentState(KanBanState.NormalState);
                bloc.addNewStage(textEditingStageController.text);
              },
              icon: Icon(Icons.check),
            )
          ],
          title: Text("Project title"),
        );
      case KanBanState.AddNewTaskState:
        return AppBar(
          title: Text("Project title"),
        );
      case KanBanState.NormalState:
        return AppBar(
          title: Text("Project title"),
        );
      default:
        return AppBar(
          title: Text("Project title"),
        );
    }
  }
}

enum KanBanState {
  AddNewStageState,
  AddNewTaskState,
  NormalState,
}
