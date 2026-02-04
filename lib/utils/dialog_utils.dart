import 'package:easy_localization/easy_localization.dart';
import 'package:evently/widget/custom_elevated_button.dart';
import 'package:flutter/material.dart';
import '../providers/app_setting_provider.dart';
import 'app_colors.dart';
import 'app_text_styles.dart';

class DialogUtils {
  static void showDeleteDialog({
    required BuildContext context,
    required AppSettingProvider appSettingsProvider,
    required void Function() positiveAction,
    void Function()? negativeAction,
  }) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: appSettingsProvider.isLight
              ? AppColors.whiteColor
              : AppColors.inputsColor,
          title: Text(
            'delete_event'.tr(),
            style: AppTextStyles.sB20.copyWith(
              color: appSettingsProvider.isLight
                  ? AppColors.mainTextColor
                  : AppColors.whiteColor,
            ),
          ),
          content: Text(
            'are_you_sure_to_delete'.tr(),
            style: AppTextStyles.sB16.copyWith(
              color: appSettingsProvider.isLight
                  ? AppColors.mainTextColor
                  : AppColors.whiteColor,
            ),
          ),
          actions: [
            CustomElevatedButton(
              text: "no",
              onButtonPressed:
                  negativeAction ??
                  () {
                    Navigator.pop(context);
                  },
            ),
            CustomElevatedButton(
              text: "yes",
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
