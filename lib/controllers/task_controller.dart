import 'package:get/get.dart';

import '../models/task.dart';

class TaskController extends GetxController {
  final taskList = [
    Task(
      title: 'title 1',
      note: 'no thing',
      isCompleted: 1,
      startTime: '8:18',
      endTime: '2:40',
      color: 1,
    ),
    Task(
      title: 'title 2',
      note: 'no thing',
      isCompleted: 0,
      startTime: '8:18',
      endTime: '2:40',
      color: 0,
    ),
    Task(
      title: 'title 3',
      note: 'no thing',
      isCompleted: 1,
      startTime: '8:18',
      endTime: '2:40',
      color: 2,
    ),
  ];

  addTask({Task? task}) {}

  getTask() {}
}
