import 'package:easy_localization/easy_localization.dart';
import 'package:evently/utils/app_colors.dart';
import 'package:evently/utils/app_text_styles.dart';
import 'package:evently/utils/responsive.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../providers/app_setting_provider.dart';

class HomeTab extends StatelessWidget {
  const HomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    var appSettingsProvider = Provider.of<AppSettingProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Row(
          spacing: 8*context.screenWidthRatio,
          children: [
            Column(
              spacing: 5*context.screenHeightRatio,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "welcome_back".tr(),
                  style: AppTextStyles.r14.copyWith(
                    color: appSettingsProvider.isLight
                        ? AppColors.secTextColor
                        : AppColors.darkSecTextColor,
                  ),
                ),
                Text(
                  "mohammed Elshabrawy",
                  style: AppTextStyles.m20.copyWith(
                    color: appSettingsProvider.isLight
                        ? AppColors.mainTextColor
                        : AppColors.whiteColor,
                  ),
                ),
              ],
            ),
            const Spacer(),
            Icon(
              appSettingsProvider.isLight
                  ? Icons.light_mode_outlined
                  : Icons.dark_mode_outlined,
              color: appSettingsProvider.isLight
                  ? AppColors.mainColor
                  : AppColors.darkMainColor,
            ),
            Container(
              padding: EdgeInsetsGeometry.symmetric(
                horizontal: 8 * context.screenWidthRatio,
                vertical: 6 * context.screenHeightRatio,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: appSettingsProvider.isLight
                    ? AppColors.mainColor
                    : AppColors.darkMainColor,
              ),
              child: Text(
                appSettingsProvider.isEnglish ? 'EN' : 'AR',
                style: AppTextStyles.sB14.copyWith(color: AppColors.whiteColor),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
