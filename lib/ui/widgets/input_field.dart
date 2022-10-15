import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo/ui/size_config.dart';
import 'package:todo/ui/theme.dart';

class InputField extends StatelessWidget {
  const InputField({
    Key? key,
    required this.tittle,
    required this.hint,
    this.controller,
    this.widget,
  }) : super(key: key);

  final String tittle;
  final String hint;
  final TextEditingController? controller;
  final Widget? widget;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(top: 15),
          child: Text(tittle, style: tittlestyle),
        ),
        Container(
          margin: const EdgeInsets.only(top: 14),
          width: SizeConfig.screenWidth,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.grey),
          ),
          child: Row(
            children: [
              Expanded(
                child: TextFormField(
                  style: subtittlestyle,
                  readOnly: widget != null ? true : false,
                  cursorColor:
                      Get.isDarkMode ? Colors.grey[100] : Colors.grey[700],
                  controller: controller,
                  autofocus: false,
                  decoration: InputDecoration(
                    hintText: hint,
                    hintStyle: subtittlestyle,
                    enabledBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.grey,
                        width: 0,
                      ),
                    ),
                    focusedBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.grey,
                        width: 0,
                      ),
                    ),
                  ),
                ),
              ),
              widget ?? Container()
            ],
          ),
        )
      ],
    );
  }
}
