import 'package:easy_localization/easy_localization.dart';
import 'package:evently/widget/custom_text_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../providers/app_setting_provider.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/app_text_styles.dart';
import '../../../utils/responsive.dart';

class EventDateAndTime extends StatelessWidget {
  const EventDateAndTime({
    super.key,
    required this.isDate,
    required this.onPressed,
  });
  final bool isDate;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    var appSettingsProvider = Provider.of<AppSettingProvider>(context);
    return Row(
      children: [
        Icon(
          isDate ? Icons.date_range_outlined : Icons.access_time_outlined,
          color: appSettingsProvider.isLight
              ? AppColors.mainColor
              : AppColors.darkMainColor,
        ),
        SizedBox(width: 10 * context.screenWidthRatio),
        Text(
          isDate ? 'event_date'.tr() : 'event_time'.tr(),
          style: AppTextStyles.m16.copyWith(
            color: appSettingsProvider.isLight
                ? AppColors.mainTextColor
                : AppColors.whiteColor,
          ),
        ),
        Spacer(),
        CustomTextButton(
          onPressed: onPressed,
          text: isDate ? "choose_date".tr() : "choose_time".tr(),
        ),
      ],
    );
  }
}
