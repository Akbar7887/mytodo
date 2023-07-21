import 'package:get/get.dart';
import 'package:mytodo/services/task_helper.dart';

import '../models/Task.dart';

class Controller extends GetxController {
  Rx<Task> task = Task().obs;
  RxList<Task> tasks = <Task>[].obs;

  @override
  void onInit() {
    getTasks();
    super.onInit();
  }

  Future<void> getTasks() async {
    await TaskHelper.getAllTaskAll().then((value) {
      tasks.value = value!;
      update();
    });

    return null;
  }
}

class HomeBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<Controller>(() => Controller());
  }
}
