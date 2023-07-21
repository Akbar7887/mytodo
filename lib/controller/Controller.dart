import 'package:get/get.dart';
import 'package:mytodo/services/task_helper.dart';

import '../models/Task.dart';

class Controller extends GetxController {
  Rx<Task> task = Task().obs;
  RxList<Task> tasks = <Task>[].obs;

  @override
  void onInit() {
    super.onInit();
  }

  Future<List<Task>?> getTasks(int noExecute) async {
    await TaskHelper.getAllTask(noExecute).then((value) {
      return value!;
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
