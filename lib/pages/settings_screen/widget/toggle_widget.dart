import 'package:easy_localization/easy_localization.dart';
import 'package:evently/providers/app_setting_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/app_text_styles.dart';
import '../../../utils/responsive.dart';

class ToggleWidget extends StatefulWidget {
  const ToggleWidget({
    super.key,
    required this.isEnabled,
    required this.isLang,
  });
  final bool isEnabled;
  final bool isLang;

  @override
  State<ToggleWidget> createState() => _ToggleWidgetState();
}

class _ToggleWidgetState extends State<ToggleWidget> {
  late bool isEnabled = widget.isEnabled;
  late bool isLang = widget.isLang;

  @override
  Widget build(BuildContext context) {
    var appSettingsProvider = Provider.of<AppSettingProvider>(context);
    return Row(
      children: [
        Text(
          isLang ? "language".tr() : "theme".tr(),
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        Spacer(),
        InkWell(
          onTap: () {
            if (isLang && !isEnabled) {
              appSettingsProvider.changeLangToEnglish(context);
              isEnabled = !isEnabled;
            } else if (!isLang && !isEnabled) {
              appSettingsProvider.changeTheme();
              isEnabled = !isEnabled;
            }
          },
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: 16 * context.screenWidthRatio,
              vertical: 5.5 * context.screenHeightRatio,
            ),
            decoration: BoxDecoration(
              color: isEnabled
                  ? appSettingsProvider.isLight
                        ? AppColors.mainColor
                        : AppColors.darkMainColor
                  : appSettingsProvider.isLight
                  ? AppColors.whiteColor
                  : AppColors.darkStrokeColor,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                width: 2,
                color: isEnabled
                    ? AppColors.transparentColor
                    : appSettingsProvider.isLight
                    ? AppColors.strokeColor
                    : AppColors.darkStrokeColor,
              ),
            ),
            child: isLang
                ? Text(
                    "english".tr(),
                    style: AppTextStyles.sB14.copyWith(
                      color: isEnabled
                          ? appSettingsProvider.isLight
                                ? AppColors.whiteColor
                                : AppColors.whiteColor
                          : appSettingsProvider.isLight
                          ? AppColors.mainColor
                          : AppColors.whiteColor,
                    ),
                  )
                : Icon(
                    !isEnabled ? Icons.light_mode_outlined : Icons.light_mode,
                    color: AppColors.whiteColor,
                  ),
          ),
        ),
        SizedBox(width: 8 * context.screenWidthRatio),
        InkWell(
          onTap: () {
            if (isEnabled && isLang) {
              isEnabled = !isEnabled;
              appSettingsProvider.changeLangToArabic(context);
            } else if (!isLang && isEnabled) {
              appSettingsProvider.changeTheme();
              isEnabled = !isEnabled;
            }
          },
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: 16 * context.screenWidthRatio,
              vertical: 5.5 * context.screenHeightRatio,
            ),
            decoration: BoxDecoration(
              color: !isEnabled
                  ? appSettingsProvider.isLight
                        ? AppColors.mainColor
                        : AppColors.darkMainColor
                  : appSettingsProvider.isLight
                  ? AppColors.whiteColor
                  : AppColors.darkStrokeColor,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                width: 2,
                color: isEnabled
                    ? AppColors.transparentColor
                    : appSettingsProvider.isLight
                    ? AppColors.strokeColor
                    : AppColors.darkStrokeColor,
              ),
            ),
            child: isLang
                ? Text(
                    "arabic".tr(),
                    style: AppTextStyles.sB14.copyWith(
                      color: !isEnabled
                          ? appSettingsProvider.isLight
                                ? AppColors.whiteColor
                                : AppColors.whiteColor
                          : appSettingsProvider.isLight
                          ? AppColors.mainColor
                          : AppColors.whiteColor,
                    ),
                  )
                : Icon(
                    isEnabled ? Icons.dark_mode_outlined : Icons.dark_mode,
                    color: appSettingsProvider.isLight
                        ? AppColors.mainColor
                        : AppColors.whiteColor,
                  ),
          ),
        ),
      ],
    );
  }
}
