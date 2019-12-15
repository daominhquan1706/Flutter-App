import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/bloc/kanban_bloc.dart';
import 'package:flutter_app/helper/color.dart';
import 'package:flutter_app/helper/widget_helper.dart';
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
      backgroundColor: AppColor.backgroundColor,
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
              ...list
                  .map((stage) => StageItemPage(
                        state: currentState,
                        stage: stage,
                      ))
                  .toList(),
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
        ? _buildTextFieldAddStage()
        : Column(
            children: <Widget>[
              RaisedButton(
                elevation: 0,
                onPressed: () {
                  changeCurrentState(KanBanState.AddNewStageState);
                },
                color: AppColor.backgroundColor,
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Icon(
                      Icons.add,
                      color: AppColor.lightBlueTextColor,
                    ),
                    Text(
                      "Add new Stage",
                      style: TextStyle(color: AppColor.lightBlueTextColor),
                    ),
                  ],
                ),
              ),
            ],
          );
  }

  Widget _buildAppBar() {
    var data = project.projectName;
    var appbarColor = AppColor.backgroundColor;
    switch (currentState) {
      case KanBanState.AddNewStageState:
        return AppBar(
          backgroundColor: appbarColor,
          leading: IconButton(
            onPressed: () {
              changeCurrentState(KanBanState.NormalState);
            },
            icon: Icon(Icons.close),
          ),
          actions: <Widget>[
            IconButton(
              onPressed: _onAddStage,
              icon: Icon(Icons.check),
            )
          ],
          title: Text(data),
        );
      case KanBanState.AddNewTaskState:
        return AppBar(
          backgroundColor: appbarColor,
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
              },
              icon: Icon(Icons.check),
            )
          ],
          title: Text(data),
        );
      case KanBanState.NormalState:
        return AppBar(
          backgroundColor: appbarColor,
          title: Text(data),
        );
      default:
        return AppBar(
          backgroundColor: appbarColor,
          title: Text(data),
        );
    }
  }

  Widget _buildTextFieldAddStage() {
    return Padding(
      padding: EdgeInsets.only(top: 8),
      child: Column(
        children: <Widget>[
          MyCustomTextField(
            controller: textEditingStageController,
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
                  changeCurrentState(KanBanState.NormalState);
                },
                text: 'Hủy bỏ',
              ),
              SizedBox(
                width: 8,
              ),
              MyCustomButton(
                onPressed: _onAddStage,
                text: 'Thêm Cột',
                borderColor: Color(0xff49ED45),
                backgroundColor: Color(0xff49ED45).withOpacity(0.25),
                textColor: Color(0xff92B4AC),
              ),
            ],
          )
        ],
      ),
    );
  }

  Future<void> _onAddStage() async {
    changeCurrentState(KanBanState.NormalState);
    await bloc.addNewStage(textEditingStageController.text);
    changeCurrentState(KanBanState.NormalState);
    textEditingStageController.text = '';
  }
}

enum KanBanState {
  AddNewStageState,
  AddNewTaskState,
  NormalState,
}
