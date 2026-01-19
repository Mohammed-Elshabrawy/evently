import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../providers/app_setting_provider.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/app_text_styles.dart';

class CustomDivider extends StatelessWidget {
  const CustomDivider({super.key});

  @override
  Widget build(BuildContext context) {
    var appSettingsProvider = Provider.of<AppSettingProvider>(context);

    return Stack(
      alignment: Alignment.center,
      children: [
        Divider(
          color: appSettingsProvider.isLight
              ? AppColors.strokeColor
              : AppColors.darkStrokeColor,
          thickness: 1,
        ),
        Container(
          color: appSettingsProvider.isLight
              ? AppColors.bgColor
              : AppColors.darkBGColor,
          child: Text(
            "or".tr(),
            style: AppTextStyles.m16.copyWith(
              color: appSettingsProvider.isLight
                  ? AppColors.mainColor
                  : AppColors.darkMainColor,
            ),
          ),
        ),
      ],
    );
  }
}
