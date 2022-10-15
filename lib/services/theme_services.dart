import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ThemeServices {
  final GetStorage _box = GetStorage();
  final _key = ' ';

  saveThemeFromBox(bool isdarkmode) => _box.write(_key, isdarkmode);

  bool loadThemeFromBox() => _box.read(_key) ?? false;

  ThemeMode get theme => loadThemeFromBox() ? ThemeMode.dark : ThemeMode.light;

  void SwitchTheme() {
    Get.changeThemeMode(loadThemeFromBox() ? ThemeMode.light : ThemeMode.dark);
    saveThemeFromBox(!loadThemeFromBox());
  }
}
