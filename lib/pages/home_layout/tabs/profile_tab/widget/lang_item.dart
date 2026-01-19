import 'package:easy_localization/easy_localization.dart';
import 'package:evently/utils/app_colors.dart';
import 'package:evently/utils/responsive.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../../providers/app_setting_provider.dart';
import '../../../../../utils/app_text_styles.dart';

class LangItem extends StatelessWidget {
  const LangItem({
    super.key,
    required this.currentIsEnglish,
    required this.isEnglish,
  });
  final bool currentIsEnglish;
  final bool isEnglish;

  @override
  Widget build(BuildContext context) {
    var appSettingsProvider = Provider.of<AppSettingProvider>(context);
    return InkWell(
      onTap: () {
        if (isEnglish && !currentIsEnglish) {
          appSettingsProvider.changeLangToEnglish(context);
        } else if (!isEnglish && currentIsEnglish) {
          appSettingsProvider.changeLangToArabic(context);
        }
      },
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 15 * context.screenWidthRatio,
          vertical: 10 * context.screenHeightRatio,
        ),
        margin: EdgeInsets.symmetric(
          horizontal: 10 * context.screenWidthRatio,
          vertical: 5 * context.screenHeightRatio,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: appSettingsProvider.isLight
              ? AppColors.whiteColor
              : AppColors.inputsColor,
          border: Border.all(
            color: appSettingsProvider.isLight
                ? AppColors.strokeColor
                : AppColors.darkStrokeColor,
          ),
        ),
        child: Row(
          children: [
            Text(
              isEnglish ? 'english'.tr() : 'arabic'.tr(),
              style: AppTextStyles.sB14,
            ),
            const Spacer(),
            Visibility(
              visible: currentIsEnglish == isEnglish,
              child: Icon(
                Icons.check_outlined,
                color: appSettingsProvider.isLight
                    ? AppColors.mainColor
                    : AppColors.darkMainColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
