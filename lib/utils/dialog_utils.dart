import 'package:easy_localization/easy_localization.dart';
import 'package:evently/widget/custom_elevated_button.dart';
import 'package:flutter/material.dart';
import '../providers/app_setting_provider.dart';
import 'app_colors.dart';
import 'app_text_styles.dart';

class DialogUtils {
  static void showEnsureDialog({
    required BuildContext context,
    required AppSettingProvider appSettingsProvider,
    required void Function() positiveAction,
    void Function()? negativeAction,
    required String title,
    required String content,
    required String positiveText,
    required String negativeText,
  }) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          actionsAlignment: MainAxisAlignment.spaceBetween,
          backgroundColor: appSettingsProvider.isLight
              ? AppColors.whiteColor
              : AppColors.inputsColor,
          title: Text(
            title.tr(),
            style: AppTextStyles.sB20.copyWith(color: AppColors.redColor),
          ),
          content: Text(
            content.tr(),
            style: AppTextStyles.sB16.copyWith(
              color: appSettingsProvider.isLight
                  ? AppColors.mainTextColor
                  : AppColors.whiteColor,
            ),
          ),
          actions: [
            CustomElevatedButton(
              isInDialog: true,
              text: negativeText,
              onButtonPressed:
                  negativeAction ??
                  () {
                    Navigator.pop(context);
                  },
            ),
            CustomElevatedButton(
              isInDialog: true,
              text: positiveText,
              onButtonPressed: () {
                positiveAction();
              },
            ),
          ],
        );
      },
    );
  }
}
