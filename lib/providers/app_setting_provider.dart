import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppSettingProvider extends ChangeNotifier {
  late bool isEnglish;
  late bool isLight;
  void changeLangToEnglish(BuildContext context) {
    context.setLocale(Locale("en"));
    isEnglish = true;
    saveLang(isEnglish);
    notifyListeners();
  }

  void changeLangToArabic(BuildContext context) {
    context.setLocale(Locale("ar"));
    isEnglish = false;
    saveLang(isEnglish);
    notifyListeners();
  }

  void changeTheme() {
    isLight = !isLight;
    saveTheme(isLight);
    notifyListeners();
  }

  Future<void> saveTheme(bool newIsLight) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLight', newIsLight);
    print("new isLight =$newIsLight");
    notifyListeners();
  }

  Future<void> saveLang(bool newIsEnglish) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isEnglish', newIsEnglish);
    print("new isEnglish =$newIsEnglish");

    notifyListeners();
  }

  void loadTheme() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    isLight = prefs.getBool('isLight') ?? true;
    print(prefs.getBool('isLight'));

    notifyListeners();
  }

  void loadLang(BuildContext context) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    isEnglish = prefs.getBool('isEnglish') ?? Platform.localeName == 'en'
        ? true
        : false;
   await prefs.getBool('isEnglish') == true
        ? context.setLocale(Locale("en"))
        : context.setLocale(Locale("ar"));

    print("lange ${prefs.getBool('isEnglish')}");

    notifyListeners();
  }
}
