import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../controller/Controller.dart';
import '../generated/l10n.dart';
import '../models/Task.dart';
import '../models/Ui.dart';
import '../services/task_helper.dart';
import 'addTask.dart';

class HistoryWidget extends StatefulWidget {
  const HistoryWidget({Key? key}) : super(key: key);

  @override
  State<HistoryWidget> createState() => _HistoryWidgetState();
}

class _HistoryWidgetState extends State<HistoryWidget> {
  final Controller _controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            Expanded(
                child: Obx(() => ListView(
                      children: _controller.tasks.value
                          .where((element) => element.execute == 1)
                          .map((e) {
                        return Container(
                            padding: EdgeInsets.all(5),
                            height: MediaQuery.of(context).size.height / 9,
                            child: Card(
                              color: Colors.indigo[300],
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  side: BorderSide(
                                      color: Colors.white, width: 1)),
                              child: Row(
                                children: [
                                  Container(
                                    child: Column(children: [
                                      Container(
                                        // padding: EdgeInsets.all(10),
                                        child: Text(
                                          e.id.toString(),
                                          style: TextStyle(
                                              fontSize: 15,
                                              color: Colors.indigo),
                                        ),
                                      ),
                                      Container(
                                          child: Checkbox(
                                        value: e.execute == 0 ? false : true,
                                        onChanged: (bool? value) {
                                          setState(() {
                                            e.execute = value == true ? 1 : 0;
                                          });
                                          TaskHelper.updateTask(e)
                                              .then((ans) {});
                                        },
                                        side:
                                            MaterialStateBorderSide.resolveWith(
                                          (states) => BorderSide(
                                              width: 1.0, color: Colors.white),
                                        ),
                                      )),
                                    ]),
                                  ),
                                  Expanded(
                                      child: InkWell(
                                          onTap: () {
                                            _controller.task.value = e;
                                            Get.to(AddTask());
                                          },
                                          child: Padding(
                                              padding: EdgeInsets.all(10),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Container(
                                                    child: Text(
                                                      e.title!,
                                                      textAlign:
                                                          TextAlign.justify,
                                                      style: TextStyle(
                                                          fontSize: 20,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.white),
                                                    ),
                                                    alignment:
                                                        Alignment.centerLeft,
                                                  ),
                                                  Container(
                                                    child: Text(
                                                      Ui.dateFormat.format(
                                                          DateTime.parse(
                                                              e.createdate!)),
                                                      style: TextStyle(
                                                          fontSize: 10,
                                                          color: Colors.white),
                                                    ),
                                                    alignment:
                                                        Alignment.bottomRight,
                                                  )
                                                ],
                                              )))),
                                  Container(
                                      padding: EdgeInsets.all(10),
                                      child: ElevatedButton(
                                          onPressed: () async {
                                            await TaskHelper.deleteTask(e)
                                                .then((value) {
                                              TaskHelper.getAllTaskAll()
                                                  .then((value) {
                                                // setState(() {
                                                  _controller.tasks.value =
                                                      value!;
                                                  _controller.tasks.refresh();
                                                // });
                                              });
                                            });
                                          },
                                          style: ButtonStyle(
                                              shape: MaterialStateProperty.all<
                                                      RoundedRectangleBorder>(
                                                  RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              30),
                                                      side: BorderSide(
                                                          color: Colors.white,
                                                          width: 1)))),
                                          child: Text(
                                            S.of(context).delete,
                                            style: TextStyle(fontSize: 30),
                                          )))
                                ],
                              ),
                            ));
                      }).toList(),
                    )))
          ],
        ));
  }
}
