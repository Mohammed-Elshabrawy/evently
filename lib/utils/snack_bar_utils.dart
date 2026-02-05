import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../providers/app_setting_provider.dart';
import 'app_colors.dart';

class SnackBarUtils {
  static void showSnackBar({
    required BuildContext context,
    required AppSettingProvider appSettingsProvider,
    required String message,
    bool isError = false,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: Duration(seconds: 2),
        backgroundColor: isError
            ? AppColors.redColor
            : appSettingsProvider.isLight
            ? AppColors.mainColor
            : AppColors.darkMainColor,
        content: Text(message.tr()),
      ),
    );
  }

  static void showSnackBarLoading({
    required BuildContext context,
    required AppSettingProvider appSettingsProvider,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: Duration(seconds: 4),
        backgroundColor: appSettingsProvider.isLight
            ? AppColors.bgColor
            : AppColors.darkBGColor,
        content: LinearProgressIndicator(
          backgroundColor: appSettingsProvider.isLight
              ? AppColors.strokeColor
              : AppColors.darkStrokeColor,
          minHeight: 5,
          color: appSettingsProvider.isLight
              ? AppColors.mainColor
              : AppColors.darkMainColor,
        ),
      ),
    );
  }
}
