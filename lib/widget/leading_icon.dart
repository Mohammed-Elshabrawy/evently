import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/app_setting_provider.dart';
import '../utils/app_colors.dart';
import '../utils/responsive.dart';

class AppBarCustomIcon extends StatelessWidget {
  const AppBarCustomIcon({
    super.key,
    required this.onPressed,
    this.isLeading = true,
    this.icon = const Icon(Icons.arrow_back_ios_new_outlined),
  });
  final VoidCallback onPressed;
  final bool isLeading;
  final Widget icon;

  @override
  Widget build(BuildContext context) {
    var appSettingsProvider = Provider.of<AppSettingProvider>(context);
    return Container(
      margin: isLeading
          ? EdgeInsets.symmetric(
              horizontal: 22 * context.screenWidthRatio,
              vertical: 6 * context.screenHeightRatio,
            )
          : EdgeInsets.zero,
      padding: EdgeInsets.all(8 * context.screenWidthRatio),
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
        style: const ButtonStyle(
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        ),
        padding: EdgeInsets.zero,
        constraints: BoxConstraints(),
        splashRadius: 20,
        onPressed: onPressed,
        icon: isLeading
            ? Icon(
                Icons.arrow_back_ios_new_outlined,
                color: appSettingsProvider.isLight
                    ? AppColors.mainColor
                    : AppColors.whiteColor,
              )
            : icon,
      ),
    );
  }
}
