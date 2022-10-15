import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:todo/controllers/task_controller.dart';
import 'package:todo/models/task.dart';
import 'package:todo/services/theme_services.dart';
import 'package:todo/ui/theme.dart';
import 'package:todo/ui/widgets/button.dart';

import '../widgets/input_field.dart';

class AddTaskPage extends StatefulWidget {
  const AddTaskPage({Key? key}) : super(key: key);

  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  final TaskController _taskController = Get.put(TaskController());

  final TextEditingController _titlecontroller = TextEditingController();
  final TextEditingController _notecontroller = TextEditingController();

  DateTime selectDate = DateTime.now();
  String startTime = DateFormat('hh:mm:a').format(DateTime.now()).toString();
  String endTime = DateFormat('hh:mm:a')
      .format(
        DateTime.now().add(
          const Duration(minutes: 15),
        ),
      )
      .toString();

  int selectremind = 5;
  List remindList = [5, 10, 15, 20];
  String selectRepet = 'none';
  List repetList = ['None', 'Daily', 'Weekly', 'Monthly'];

  int selectColor = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.backgroundColor,
      appBar: _AppBar(),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text(
                'Add Task',
                style: tittlestyle,
              ),
              InputField(
                tittle: 'title',
                hint: 'Enter your text',
                controller: _titlecontroller,
              ),
              InputField(
                tittle: 'Note',
                hint: 'Enter your Note',
                controller: _notecontroller,
              ),
              InputField(
                tittle: 'Date',
                hint: DateFormat.yMd().format(selectDate),
                widget: IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.calendar_today_outlined,
                    color: Colors.grey,
                  ),
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: InputField(
                      tittle: 'Start Time',
                      hint: startTime,
                      widget: const Icon(
                        Icons.access_time_filled_rounded,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: InputField(
                      tittle: 'End Time',
                      hint: endTime,
                      widget: const Icon(
                        Icons.access_time_filled_rounded,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ],
              ),
              InputField(
                tittle: 'Remind',
                hint: '$selectremind minutes early',
                widget: DropdownButton(
                  borderRadius: BorderRadius.circular(10),
                  dropdownColor: Colors.blueGrey,
                  items: remindList
                      .map(
                        (value) => DropdownMenuItem(
                          value: value,
                          child: Text(
                            '$value',
                            style: const TextStyle(color: Colors.grey),
                          ),
                        ),
                      )
                      .toList(),
                  onChanged: (newvalue) {
                    setState(
                      () {
                        selectremind = newvalue as int;
                      },
                    );
                  },
                  icon: const Icon(
                    Icons.keyboard_arrow_down,
                    color: Colors.grey,
                    size: 30,
                  ),
                  elevation: 4,
                  style: tittlestyle,
                  underline: Container(
                    height: 0,
                  ),
                ),
              ),
              InputField(
                tittle: 'Repet',
                hint: selectRepet,
                widget: DropdownButton(
                  borderRadius: BorderRadius.circular(10),
                  dropdownColor: Colors.blueGrey,
                  items: repetList
                      .map(
                        (value) => DropdownMenuItem(
                          value: value,
                          child: Text(
                            value,
                            style: const TextStyle(color: Colors.grey),
                          ),
                        ),
                      )
                      .toList(),
                  onChanged: (newvalue) {
                    setState(
                      () {
                        selectRepet = newvalue as String;
                      },
                    );
                  },
                  icon: const Icon(
                    Icons.keyboard_arrow_down,
                    color: Colors.grey,
                    size: 30,
                  ),
                  elevation: 4,
                  style: tittlestyle,
                  underline: Container(
                    height: 0,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  palata(),
                  MyButton(
                    labale: 'Creat Task',
                    ontap: () {
                      valediateDate();
                    },
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  AppBar _AppBar() {
    return AppBar(
      backgroundColor: context.theme.backgroundColor,
      leading: IconButton(
        onPressed: () {
          setState(() {
            ThemeServices().SwitchTheme();
          });
        },
        icon: Get.isDarkMode
            ? const Icon(Icons.wb_sunny_rounded)
            : const Icon(Icons.nightlight_outlined),
        color: Get.isDarkMode ? Colors.white : Colors.black,
      ),
      actions: const [
        CircleAvatar(
          backgroundImage: AssetImage('images/person.jpeg'),
        ),
        SizedBox(width: 15)
      ],
      elevation: 0,
    );
  }

  valediateDate() {
    if (_titlecontroller.text.isNotEmpty && _notecontroller.text.isNotEmpty) {
      addtaskstoDB();
      Get.back();
    } else if (_titlecontroller.text.isNotEmpty ||
        _notecontroller.text.isNotEmpty) {
      Get.snackbar('Required', 'ALL FILEDS ARE REQUIRED',
          snackPosition: SnackPosition.BOTTOM,
          colorText: pinkClr,
          icon: const Icon(
            Icons.warning_amber_rounded,
            color: Colors.red,
          ));
    } else {
      print('SOME THING BAD HAPPEND');
    }
  }

  addtaskstoDB() async {
    int value = await _taskController.addTask(
        task: Task(
      title: _titlecontroller.text,
      note: _notecontroller.text,
      isCompleted: 0,
      date: DateFormat.yMd().format(selectDate),
      startTime: startTime,
      endTime: endTime,
      color: selectColor,
      remind: selectremind,
      repeat: selectRepet,
    ));
    print('$value');
  }

  Column palata() {
    return Column(
      children: [
        Text(
          'Color',
          style: tittlestyle,
        ),
        const SizedBox(height: 4),
        Row(
          children: [
            ...List.generate(
              3,
              (index) => GestureDetector(
                onTap: () {
                  setState(() {
                    selectColor = index;
                    print(selectColor);
                  });
                },
                child: Container(
                  margin: const EdgeInsets.only(right: 8),
                  child: CircleAvatar(
                    child: selectColor == index
                        ? const Icon(
                            Icons.done,
                            size: 16,
                          )
                        : null,
                    backgroundColor: index == 0
                        ? primaryClr
                        : index == 1
                            ? pinkClr
                            : orangeClr,
                    radius: 14,
                  ),
                ),
              ),
            )
          ],
        )
      ],
    );
  }
}
