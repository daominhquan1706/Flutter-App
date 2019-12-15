import 'package:flutter/material.dart';
import 'package:flutter_app/model/stage_item_model.dart';

class StageItemPage extends StatelessWidget {
  final Stage stage;

  const StageItemPage({Key key, this.stage}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Scaffold(
          appBar: AppBar(
            title: Text("Stage name"),
            automaticallyImplyLeading: false,
          ),
        ),
      ),
    );
  }
}
