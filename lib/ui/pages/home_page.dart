import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:todo/controllers/task_controller.dart';
import 'package:todo/models/task.dart';
import 'package:todo/ui/pages/add_task_page.dart';
import 'package:todo/ui/size_config.dart';
import 'package:todo/ui/theme.dart';
import 'package:todo/ui/widgets/button.dart';
import 'package:todo/ui/widgets/task_tile.dart';

import '../../services/theme_services.dart';
import 'notification_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TaskController _taskController = Get.put(TaskController());
  DateTime _selectDate = DateTime.now();
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
        backgroundColor: context.theme.backgroundColor,
        appBar: _AppBar(),
        body: Column(
          children: [
            _addTaskBar(),
            _addDateBar(),
            _showTask(),
          ],
        ));
  }

  AppBar _AppBar() {
    return AppBar(
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
    );
  }

  _addTaskBar() {
    return Container(
      margin: const EdgeInsets.only(left: 20, right: 10, top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                DateFormat.yMMMMd().format(
                  DateTime.now(),
                ),
                style: subheadlinestyle,
              ),
              Text(
                'ToDay',
                style: headlinestyle,
              ),
            ],
          ),
          MyButton(
              labale: '+ Add Task',
              ontap: () async {
                await Get.to(const AddTaskPage());
                _taskController.getTask();
              })
        ],
      ),
    );
  }

  _addDateBar() {
    return Container(
      child: DatePicker(
        DateTime.now(),
        width: 70,
        height: 100,
        initialSelectedDate: DateTime.now(),
        selectionColor: primaryClr,
        selectedTextColor: Colors.white,
        onDateChange: (newdate) {
          setState(() {
            _selectDate = newdate;
          });
        },
        dayTextStyle: GoogleFonts.lato(
          textStyle: const TextStyle(
            color: Colors.grey,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        dateTextStyle: GoogleFonts.lato(
          textStyle: const TextStyle(
            color: Colors.grey,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        monthTextStyle: GoogleFonts.lato(
          textStyle: const TextStyle(
            color: Colors.grey,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  _showTask() {
    return Expanded(
      child: ListView.builder(
        itemCount: _taskController.taskList.length,
        itemBuilder: (BuildContext context, int index) {
          var task = _taskController.taskList[index];
          return GestureDetector(
            onTap: () {
              _showBottomSheet(context, task);
            },
            child: TaskTile(task),
          );
        },
      ),
    );
  }

  _noTask() {
    return Stack(
      children: [
        SingleChildScrollView(
          child: Wrap(
            direction: Axis.horizontal,
            alignment: WrapAlignment.center,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              SizeConfig.orientation == Orientation.landscape
                  ? const SizedBox(height: 6)
                  : const SizedBox(height: 220),
              SvgPicture.asset(
                'images/task.svg',
                height: 90,
                semanticsLabel: 'Task',
                color: primaryClr.withOpacity(.5),
              ),
              Padding(
                padding: const EdgeInsets.all(30.0),
                child: Text(
                  'you donot have any task yet \n add new task to make your day is helpful to our worled',
                  style: subheadlinestyle,
                  textAlign: TextAlign.center,
                ),
              )
            ],
          ),
        )
      ],
    );
  }

  _showBottomSheet(BuildContext context, Task task) {
    Get.bottomSheet(
      SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.only(top: 4),
          width: SizeConfig.screenWidth,
          height: (SizeConfig.orientation == Orientation.landscape)
              ? (task.isCompleted == 1
                  ? SizeConfig.screenHeight * 0.6
                  : SizeConfig.screenHeight * 0.8)
              : (task.isCompleted == 1
                  ? SizeConfig.screenHeight * 0.50
                  : SizeConfig.screenWidth * 0.59),
          color: Get.isDarkMode ? darkHeaderClr : Colors.white,
          child: Column(
            children: [
              Flexible(
                child: Container(
                  width: 120,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color:
                          Get.isDarkMode ? Colors.grey[600] : Colors.grey[300]),
                ),
              ),
              const SizedBox(height: 10),
              task.isCompleted == 1
                  ? Container()
                  : _buildBottomSheet(
                      lable: 'Task Completed',
                      ontap: () {
                        Get.back();
                      },
                      clr: primaryClr),
              _buildBottomSheet(
                lable: ' Delete Task ',
                ontap: () {
                  Get.back();
                },
                clr: primaryClr,
              ),
              Divider(
                color: Get.isDarkMode ? Colors.grey : darkGreyClr,
              ),
              _buildBottomSheet(
                lable: 'Cansel',
                ontap: () {
                  Get.back();
                },
                clr: primaryClr,
              ),
            ],
          ),
        ),
      ),
    );
  }

  _buildBottomSheet(
      {required String lable,
      required Function() ontap,
      required Color clr,
      bool isClose = false}) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4),
        height: 50,
        width: SizeConfig.screenWidth * 0.9,
        decoration: BoxDecoration(
            border: Border.all(
              width: 2,
              color: isClose
                  ? Get.isDarkMode
                      ? Colors.grey[600]!
                      : Colors.grey[300]!
                  : clr,
            ),
            borderRadius: BorderRadius.circular(20),
            color: isClose ? Colors.transparent : clr),
        child: Center(
          child: Text(
            lable,
            style: isClose
                ? tittlestyle
                : tittlestyle.copyWith(
                    color: Colors.white,
                  ),
          ),
        ),
      ),
    );
  }
}
