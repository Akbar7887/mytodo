import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:mytodo/models/Task.dart';
import 'package:mytodo/widgets/addTask.dart';
import 'package:mytodo/widgets/history_widget.dart';
import 'package:mytodo/widgets/task_widget.dart';

import '../controller/Controller.dart';
import '../generated/l10n.dart';

final Controller _controller = Get.find();

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          backgroundColor: Colors.indigo,
          appBar: AppBar(
            bottom: TabBar(
                labelStyle: TextStyle(fontWeight: FontWeight.bold),
                tabs: [
                  Tab(
                    text: S.of(context).topical,
                  ),
                  Tab(
                    text: S.of(context).history,
                  )
                ]),
          ),
          body: TabBarView(children: [TaskWidget(), HistoryWidget()]),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              // Navigator.pop(context);
              addTask(context);
            },
            elevation: 5,
            splashColor: Colors.white,
            shape: RoundedRectangleBorder(
                side: BorderSide(color: Colors.white, width: 1),
                borderRadius: BorderRadius.circular(40)),
            // backgroundColor: Colors.white,
            hoverColor: Colors.white,
            tooltip: 'Increment',
            child: const Icon(Icons.add),
          ), // This ,),
        ));
  }

  void addTask(BuildContext context) {
    _controller.task.value = Task();
    Get.to(AddTask());
    //Navigator.pushNamed(context, '/addtask');
  }
}
