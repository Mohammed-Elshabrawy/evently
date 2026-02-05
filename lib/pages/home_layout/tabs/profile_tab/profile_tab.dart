import 'package:evently/pages/home_layout/tabs/profile_tab/widget/lang_item.dart';
import 'package:evently/pages/home_layout/tabs/profile_tab/widget/settings_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../models/user_model.dart';
import '../../../../providers/app_setting_provider.dart';
import '../../../../providers/user_provider.dart';
import '../../../../utils/app_assets.dart';
import '../../../../utils/app_colors.dart';
import '../../../../utils/app_routes.dart';
import '../../../../utils/app_text_styles.dart';
import '../../../../utils/dialog_utils.dart';
import '../../../../utils/responsive.dart';

class ProfileTab extends StatelessWidget {
  const ProfileTab({super.key});

  @override
  Widget build(BuildContext context) {
    var appSettingsProvider = Provider.of<AppSettingProvider>(context);
    var userProvider = Provider.of<UserProvider>(context);

    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 16 * context.screenWidthRatio,
          vertical: 30 * context.screenHeightRatio,
        ),
        child: Column(
          spacing: 15 * context.screenHeightRatio,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CircleAvatar(
              radius: 50 * context.screenWidthRatio,
              child: ClipRRect(
                clipBehavior: Clip.antiAlias,
                borderRadius: BorderRadius.circular(100),
                child: Image.asset(
                  AppAssets.profile,
                  fit: BoxFit.fill,
                  height: 100 * context.screenHeightRatio,
                  width: 100 * context.screenWidthRatio,
                ),
              ),
            ),
            Text(
              textAlign: TextAlign.center,
              userProvider.currentUser!.name,
              style: AppTextStyles.sB20.copyWith(
                color: appSettingsProvider.isLight
                    ? AppColors.mainTextColor
                    : AppColors.whiteColor,
              ),
            ),
            Text(
              textAlign: TextAlign.center,
              userProvider.currentUser!.email,
              style: AppTextStyles.r14.copyWith(
                color: appSettingsProvider.isLight
                    ? AppColors.secTextColor
                    : AppColors.darkSecTextColor,
              ),
            ),
            SettingsItem(
              label: 'dark_mode',
              widget: Switch(
                activeThumbColor: AppColors.whiteColor,
                inactiveThumbColor: AppColors.whiteColor,
                activeTrackColor: AppColors.mainColor,
                inactiveTrackColor: Colors.grey[200],
                trackOutlineColor: WidgetStateProperty.resolveWith((
                  Set<WidgetState> states,
                ) {
                  return AppColors.transparentColor;
                }),
                value: !appSettingsProvider.isLight,
                onChanged: (value) {
                  appSettingsProvider.changeTheme();
                },
              ),
            ),
            SettingsItem(
              label: 'language',
              widget: IconButton(
                onPressed: () {
                  _showBottomSheet(context);
                },
                icon: Icon(
                  Icons.arrow_forward_ios_outlined,
                  color: appSettingsProvider.isLight
                      ? AppColors.mainColor
                      : AppColors.darkMainColor,
                ),
              ),
            ),
            SettingsItem(
              label: 'logout',
              widget: IconButton(
                onPressed: () {
                  DialogUtils.showEnsureDialog(
                    context: context,
                    appSettingsProvider: appSettingsProvider,
                    positiveAction: () {
                      logout(userProvider,context);
                    },
                    title: "logout",
                    content: "are_you_sure_to_logout",
                    positiveText: 'logout',
                    negativeText: 'cancel',
                  );
                },
                icon: Icon(Icons.logout_outlined, color: AppColors.redColor),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showBottomSheet(BuildContext context) {
    showModalBottomSheet<void>(
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      context: context,
      builder: (BuildContext context) {
        return Consumer<AppSettingProvider>(
          builder: (context, provider, child) {
            return Container(
              height: 400 * context.screenHeightRatio,
              decoration: BoxDecoration(
                color: provider.isLight
                    ? AppColors.bgColor
                    : AppColors.darkBGColor,
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(16),
                ),
              ),
              child: provider.isEnglish
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const SizedBox(height: 20),
                        LangItem(
                          currentIsEnglish: provider.isEnglish,
                          isEnglish: true,
                        ),
                        LangItem(
                          currentIsEnglish: provider.isEnglish,
                          isEnglish: false,
                        ),
                      ],
                    )
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const SizedBox(height: 20),
                        LangItem(
                          currentIsEnglish: provider.isEnglish,
                          isEnglish: false,
                        ),
                        LangItem(
                          currentIsEnglish: provider.isEnglish,
                          isEnglish: true,
                        ),
                      ],
                    ),
            );
          },
        );
      },
    );
  }

  void logout(UserProvider userProvider, BuildContext context) {
    userProvider.updateUser(MyUser(name: '', email: ''));
    Navigator.pushNamedAndRemoveUntil(
      context,
      AppRoutes.loginRoute,
      (route) => false,
    );
  }
}
