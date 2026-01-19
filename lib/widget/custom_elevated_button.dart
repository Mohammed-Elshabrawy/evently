import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:provider/provider.dart';
import '../providers/app_setting_provider.dart';
import '../utils/app_colors.dart';
import '../utils/app_text_styles.dart';
import '../utils/responsive.dart';

class CustomElevatedButton extends StatelessWidget {
  const CustomElevatedButton({
    super.key,
    required this.text,
    required this.onButtonPressed,
    this.isGoogle = false,
  });
  final String text;
  final VoidCallback onButtonPressed;
  final bool isGoogle;

  @override
  Widget build(BuildContext context) {
    var appSettingsProvider = Provider.of<AppSettingProvider>(context);
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.symmetric(vertical: 10 * context.screenHeightRatio),
        backgroundColor: isGoogle
            ? appSettingsProvider.isLight
                  ? AppColors.whiteColor
                  : AppColors.inputsColor
            : appSettingsProvider.isLight
            ? AppColors.mainColor
            : AppColors.darkMainColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        side: BorderSide(
          color: isGoogle
              ? appSettingsProvider.isLight
                    ? AppColors.strokeColor
                    : AppColors.darkStrokeColor
              : AppColors.transparentColor,
        ),
      ),
      onPressed: onButtonPressed,
      child: isGoogle
          ? Row(
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: 10 * context.screenWidthRatio,
              children: [
                Brand(Brands.google, size: 24 * context.screenHeightRatio),
                Text(
                  text.tr(),
                  style: AppTextStyles.m18.copyWith(
                    color: appSettingsProvider.isLight
                        ? AppColors.mainColor
                        : AppColors.darkMainColor,
                  ),
                ),
              ],
            )
          : Text(
              text.tr(),
              style: AppTextStyles.m20.copyWith(color: AppColors.whiteColor),
            ),
    );
  }
}
