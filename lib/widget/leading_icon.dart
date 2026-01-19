import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/app_setting_provider.dart';
import '../utils/app_colors.dart';
import '../utils/responsive.dart';

class LeadingIcon extends StatelessWidget {
  const LeadingIcon({super.key, required this.onPressed});
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    var appSettingsProvider = Provider.of<AppSettingProvider>(context);
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: 16 * context.screenWidthRatio,
        vertical: 2 * context.screenHeightRatio,
      ),
      padding: EdgeInsets.all(4 * context.screenWidthRatio),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: appSettingsProvider.isLight
            ? AppColors.whiteColor
            : AppColors.inputsColor,
        border: Border.all(
          color: appSettingsProvider.isLight
              ? AppColors.strokeColor
              : AppColors.darkStrokeColor,
          width: 1,
        ),
      ),
      child: IconButton(
        onPressed: onPressed,
        icon: Icon(
          Icons.arrow_back_ios_new_outlined,
          color: appSettingsProvider.isLight
              ? AppColors.mainColor
              : AppColors.whiteColor,
        ),
      ),
    );
  }
}
