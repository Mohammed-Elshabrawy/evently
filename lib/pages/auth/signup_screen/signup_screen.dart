import 'package:easy_localization/easy_localization.dart';
import 'package:evently/utils/app_assets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../functions/get_image/get_image.dart';
import '../../../providers/app_setting_provider.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/app_routes.dart';
import '../../../utils/app_text_styles.dart';
import '../../../utils/responsive.dart';
import '../../../widget/custom_elevated_button.dart';
import '../widget/custom_divider.dart';
import '../widget/custom_text_button.dart';
import '../widget/custom_text_form_filed.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var appSettingsProvider = Provider.of<AppSettingProvider>(context);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsetsGeometry.symmetric(
            horizontal: 15 * context.screenWidthRatio,
          ),
          child: Column(
            spacing: 20 * context.screenHeightRatio,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Image.asset(
                getImageByMode(
                  light: AppAssets.logoLight,
                  dark: AppAssets.logoDark,
                  isLight: appSettingsProvider.isLight,
                ),
              ),
              Text(
                "create_your_account".tr(),
                style: AppTextStyles.sB24.copyWith(
                  color: appSettingsProvider.isLight
                      ? AppColors.mainColor
                      : AppColors.whiteColor,
                ),
              ),
              CustomTextFormFiled(
                prefix: Icons.person_outline_outlined,
                hintText: "enter_your_name".tr(),
                keyboardType: TextInputType.name,
              ),
              CustomTextFormFiled(
                prefix: Icons.email_outlined,
                hintText: "enter_your_email".tr(),
                keyboardType: TextInputType.emailAddress,
              ),
              CustomTextFormFiled(
                prefix: Icons.lock_outline_rounded,
                hintText: "enter_your_password".tr(),
                keyboardType: TextInputType.text,
                suffix: Icons.visibility_outlined,
              ),
              CustomTextFormFiled(
                prefix: Icons.lock_outline_rounded,
                hintText: "confirm_your_password".tr(),
                keyboardType: TextInputType.text,
                suffix: Icons.visibility_outlined,
              ),
              SizedBox(height: 30 * context.screenHeightRatio),
              CustomElevatedButton(
                text: "signup",
                onButtonPressed: () {
                  //Todo: Navigate to home screen
                },
              ),
              SizedBox(height: 30 * context.screenHeightRatio),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "already_have_an_account?".tr(),
                    style: AppTextStyles.r14.copyWith(
                      color: appSettingsProvider.isLight
                          ? AppColors.secTextColor
                          : AppColors.darkSecTextColor,
                    ),
                  ),
                  CustomTextButton(
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, AppRoutes.loginRoute);
                    },
                    text: 'login',
                  ),
                ],
              ),
              CustomDivider(),
              CustomElevatedButton(
                text: 'sign_up_with_Google',
                onButtonPressed: () {},
                isGoogle: true,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
