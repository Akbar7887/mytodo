import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:mytodo/controller/Controller.dart';
import 'package:mytodo/models/Task.dart';
import 'package:mytodo/widgets/home.dart';

import '../generated/l10n.dart';
import '../services/task_helper.dart';

final _titleController = TextEditingController();
final _descriptionController = TextEditingController();
final _keyform = GlobalKey<FormState>();
final Controller _controller = Get.find();

class AddTask extends StatelessWidget {
  const AddTask({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (_controller.task.value.id != null) {
      _titleController.text = _controller.task.value.title!;
      _descriptionController.text = _controller.task.value.description!;
      // _titleController.selection = TextSelection.collapsed(offset: _titleController.text.length);
    } else {
      _titleController.clear();
      _descriptionController.clear();
    }

    return Scaffold(
        backgroundColor: Colors.indigo,
        appBar: AppBar(),
        body: Padding(
            padding: EdgeInsets.all(20),
            child: Form(
              key: _keyform,
              child: Column(
                children: [
                  Container(
                    child: Text(
                      S.of(context).addyourtasks,
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                      child: TextFormField(
                    controller: _titleController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return S.of(context).pleasefillinthefield;
                      }
                    },
                    cursorColor: Colors.white,
                    style: TextStyle(fontSize: 20, color: Colors.white),
                    decoration: InputDecoration(
                        fillColor: Colors.white,
                        //Theme.of(context).backgroundColor,
                        labelText: S.of(context).title,
                        labelStyle:
                            TextStyle(color: Colors.white70, fontSize: 20),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide:
                                BorderSide(width: 0.5, color: Colors.white)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide:
                                BorderSide(width: 0.5, color: Colors.white))),
                  )),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                      child: TextFormField(
                    maxLines: 5,
                    controller: _descriptionController,
                    // validator: (value) {
                    //   if (value == null || value.isEmpty) {
                    //     return S.of(context).pleasefillinthefield;
                    //   }
                    // },
                    cursorColor: Colors.white,
                    style: TextStyle(fontSize: 20, color: Colors.white),
                    decoration: InputDecoration(
                        fillColor: Colors.white,
                        //Theme.of(context).backgroundColor,
                        labelText: S.of(context).description,
                        labelStyle:
                            TextStyle(color: Colors.white70, fontSize: 20),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide:
                                BorderSide(width: 0.5, color: Colors.white)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide:
                                BorderSide(width: 0.5, color: Colors.white))),
                  )),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width / 2,
                    height: 100,
                    child: ElevatedButton(
                      style: ButtonStyle(
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      side: BorderSide(
                                          color: Colors.white, width: 1)))),
                      onPressed: () async {
                        if (!_keyform.currentState!.validate()) {
                          return;
                        }

                        _controller.task.value.title = _titleController.text;
                        _controller.task.value.description =
                            _descriptionController.text;
                        _controller.task.value.createdate =
                            DateTime.now().toString();
                        _controller.task.value.execute = 0;
                        if (_controller.task.value.id == null) {
                          await TaskHelper.addTask(_controller.task.value)
                              .then((value) {
                            TaskHelper.getAllTaskAll().then((list) {
                              _controller.tasks.value = list!;
                              // _controller.tasks.refresh();

                              // Navigator.push(
                              //     context,
                              //     MaterialPageRoute(
                              //         builder: (context) => Home()));
                              Navigator.pop(context);
                            });
                          });
                        } else {
                          await TaskHelper.updateTask(_controller.task.value)
                              .then((value) {
                            TaskHelper.getAllTaskAll().then((list) {
                              _controller.tasks.value = list!;
                              // _controller.tasks.refresh();

                              // Navigator.push(
                              //     context,
                              //     MaterialPageRoute(
                              //         builder: (context) => Home()));
                              // Get.to(Home());
                              Navigator.pop(context);
                            });
                          });
                        }
                      },
                      child: Text(
                        S.of(context).add,
                        style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
            )));
  }
}
