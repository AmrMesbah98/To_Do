import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo/ui/theme.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key, required this.payLoad}) : super(key: key);

  final String payLoad;

  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  String _payLoad = '';

  @override
  void initState() {
    super.initState();
    _payLoad = widget.payLoad;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _AppBar(context),
      body: Container(
        child: SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 10),
              Column(
                children: [
                  Text(
                    'Hellow Amr',
                    style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.w900,
                        color: Get.isDarkMode ? Colors.white : darkGreyClr),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    'You have new reminder',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w300,
                        color: Get.isDarkMode ? Colors.grey[100] : darkGreyClr),
                  )
                ],
              ),
              const SizedBox(height: 10),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  margin: const EdgeInsets.symmetric(horizontal: 30),
                  decoration: BoxDecoration(
                    color: primaryClr,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Row(
                          children: const [
                            Icon(
                              Icons.text_format_outlined,
                              size: 20,
                              color: Colors.white,
                            ),
                            SizedBox(width: 20),
                            Text(
                              'Tittle',
                              style: TextStyle(color: Colors.white),
                            )
                          ],
                        ),
                        const SizedBox(height: 10),
                        Text(
                          _payLoad.split('|')[0],
                          style: const TextStyle(color: Colors.white),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: const [
                            Icon(
                              Icons.description,
                              size: 20,
                              color: Colors.white,
                            ),
                            SizedBox(width: 20),
                            Text(
                              'Description',
                              style: TextStyle(color: Colors.white),
                            )
                          ],
                        ),
                        const SizedBox(height: 10),
                        Text(
                          _payLoad.split('|')[1],
                          style: const TextStyle(color: Colors.white),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: const [
                            Icon(
                              Icons.calendar_today_outlined,
                              size: 20,
                              color: Colors.white,
                            ),
                            SizedBox(width: 20),
                            Text(
                              'Time',
                              style: TextStyle(color: Colors.white),
                            )
                          ],
                        ),
                        const SizedBox(height: 10),
                        Text(
                          _payLoad.split('|')[2],
                          style: const TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }

  AppBar _AppBar(BuildContext context) {
    return AppBar(
      leading: IconButton(
        onPressed: () {
          Get.back();
        },
        icon: const Icon(Icons.arrow_back),
      ),
      backgroundColor: context.theme.backgroundColor,
      title: Text(
        _payLoad.split('|')[0],
        style: TextStyle(color: Get.isDarkMode ? Colors.white : darkGreyClr),
      ),
      actions: const [
        CircleAvatar(
          backgroundImage: AssetImage('images/person.jpeg'),
        ),
        SizedBox(width: 15)
      ],
    );
  }
}
