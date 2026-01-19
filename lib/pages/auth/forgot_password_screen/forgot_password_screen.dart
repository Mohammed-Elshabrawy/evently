import 'package:easy_localization/easy_localization.dart';
import 'package:evently/functions/get_image/get_image.dart';
import 'package:evently/utils/app_assets.dart';
import 'package:evently/utils/app_text_styles.dart';
import 'package:evently/widget/custom_elevated_button.dart';
import 'package:evently/widget/leading_icon.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../providers/app_setting_provider.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/responsive.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var appSettingsProvider = Provider.of<AppSettingProvider>(context);
    return Scaffold(
      appBar: AppBar(
        leading: LeadingIcon(
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'forget_password'.tr(),
          style: AppTextStyles.m18.copyWith(
            color: appSettingsProvider.isLight
                ? AppColors.mainTextColor
                : AppColors.whiteColor,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 16 * context.screenWidthRatio,
          vertical: 30 * context.screenHeightRatio,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          spacing: 50 * context.screenHeightRatio,
          children: [
            Image.asset(
              getImageByMode(
                light: AppAssets.authLight,
                dark: AppAssets.authDark,
                isLight: appSettingsProvider.isLight,
              ),
            ),
            CustomElevatedButton(text: 'reset_password', onButtonPressed: () {
              //TODO: Reset password
            }),
          ],
        ),
      ),
    );
  }
}
