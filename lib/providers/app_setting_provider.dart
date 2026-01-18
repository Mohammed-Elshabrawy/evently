import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class AppSettingProvider extends ChangeNotifier {
  bool isEnglish = true;
  bool isLight = true;
  void changeLangToEnglish(BuildContext context) {
    context.setLocale(Locale("en"));
    isEnglish = true;
    notifyListeners();
  }

  void changeLangToArabic(BuildContext context) {
    context.setLocale(Locale("ar"));
    isEnglish = false;
    notifyListeners();
  }
  void changeTheme(){
    isLight =!isLight;
    notifyListeners();
  }
}
