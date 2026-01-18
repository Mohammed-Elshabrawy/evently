import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../providers/app_setting_provider.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/app_text_styles.dart';
import '../../../utils/responsive.dart';

class CustomElevatedButton extends StatelessWidget {
  const CustomElevatedButton({
    super.key,
    required this.text,
    required this.onButtonPressed,
  });
  final String text;
  final VoidCallback onButtonPressed;

  @override
  Widget build(BuildContext context) {
    var appSettingsProvider = Provider.of<AppSettingProvider>(context);
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.symmetric(vertical: 10 * context.screenHeightRatio),
        backgroundColor: appSettingsProvider.isLight
            ? AppColors.mainColor
            : AppColors.darkMainColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
      onPressed: onButtonPressed,
      child: Text(
        text,
        style: AppTextStyles.m20.copyWith(color: AppColors.whiteColor),
      ),
    );
  }
}
