import 'package:easy_localization/easy_localization.dart';
import 'package:evently/utils/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/app_setting_provider.dart';
import '../utils/app_colors.dart';
import '../utils/responsive.dart';

class TabWidget extends StatelessWidget {
  const TabWidget({
    super.key,
    required this.title,
    required this.icon,
    required this.isSelected,
  });
  final String title;
  final IconData icon;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    var appSettingsProvider = Provider.of<AppSettingProvider>(context);
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 16 * context.screenWidthRatio,
        vertical: 8 * context.screenHeightRatio,
      ),
      decoration: BoxDecoration(
        color: isSelected
            ? appSettingsProvider.isLight
                  ? AppColors.mainColor
                  : AppColors.darkMainColor
            : appSettingsProvider.isLight
            ? AppColors.whiteColor
            : AppColors.inputsColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isSelected
              ? AppColors.transparentColor
              : appSettingsProvider.isLight
              ? AppColors.strokeColor
              : AppColors.darkStrokeColor,
        ),
      ),
      child: Row(
        spacing: 8*context.screenWidthRatio,
        children: [
          Icon(
            icon,
            color: isSelected
                ? AppColors.whiteColor
                : appSettingsProvider.isLight
                ? AppColors.mainColor
                : AppColors.darkMainColor,
          ),
          Text(
            title.tr(),
            style: AppTextStyles.m16.copyWith(
              color: isSelected
                  ? AppColors.whiteColor
                  : appSettingsProvider.isLight
                  ? AppColors.mainTextColor
                  : AppColors.whiteColor,
            ),
          ),
        ],
      ),
    );
  }
}
