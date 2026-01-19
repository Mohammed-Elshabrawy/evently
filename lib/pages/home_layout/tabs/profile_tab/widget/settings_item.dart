import 'package:easy_localization/easy_localization.dart';
import 'package:evently/utils/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../providers/app_setting_provider.dart';
import '../../../../../utils/app_colors.dart';
import '../../../../../utils/responsive.dart';

class SettingsItem extends StatelessWidget {
  const SettingsItem({super.key, required this.label, required this.widget});
  final String label;
  final Widget widget;

  @override
  Widget build(BuildContext context) {
    var appSettingsProvider = Provider.of<AppSettingProvider>(context);
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 16*context.screenWidthRatio,
      ),
      decoration: BoxDecoration(
        color: appSettingsProvider.isLight
            ? AppColors.whiteColor
            : AppColors.inputsColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: appSettingsProvider.isLight
              ? AppColors.strokeColor
              : AppColors.darkStrokeColor,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label.tr(),
            style: AppTextStyles.m16.copyWith(
              color: appSettingsProvider.isLight
                  ? AppColors.mainTextColor
                  : AppColors.whiteColor,
            ),
          ),
          widget,
        ],
      ),
    );
  }
}
