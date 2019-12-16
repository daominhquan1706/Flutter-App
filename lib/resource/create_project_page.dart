import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/bloc/project_bloc.dart';
import 'package:flutter_app/helper/color.dart';
import 'package:flutter_app/helper/widget_helper.dart';
import 'package:flutter_app/model/project_item_model.dart';

class CreateProjectPage extends StatefulWidget {
  final ProjectBloc bloc;

  CreateProjectPage(this.bloc);

  @override
  _CreateProjectPageState createState() => _CreateProjectPageState(bloc);
}

class _CreateProjectPageState extends State<CreateProjectPage> {
  final ProjectBloc bloc;
  TextEditingController projectController = new TextEditingController();
  _CreateProjectPageState(this.bloc);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text("Tạo bảng"),
      ),
      body: _buildBody(),
      floatingActionButton: _buildFloatActionButton(),
    );
  }

  Widget _buildBody() {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: MyCustomTextField(
              controller: projectController,
              hintText: 'Nhập tên của bảng',
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFloatActionButton() {
    return FloatingActionButton(
      onPressed: () async {
        var isSuccess = await bloc.createProject(
          Project()
            ..projectName = projectController.text
            ..createDate = Timestamp.now()
            ..userId = (await FirebaseAuth.instance.currentUser()).uid,
        );
        if (isSuccess) {
          Navigator.pop(context);
        }
      },
      child: Icon(Icons.save),
    );
  }
}
