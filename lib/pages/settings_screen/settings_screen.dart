import 'package:easy_localization/easy_localization.dart';
import 'package:evently/pages/settings_screen/widget/toggle_widget.dart';
import 'package:evently/providers/app_setting_provider.dart';
import 'package:evently/utils/app_assets.dart';
import 'package:evently/utils/app_colors.dart';
import 'package:evently/utils/app_text_styles.dart';
import 'package:evently/utils/responsive.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  String _getImageByMode({
    required String light,
    required String dark,
    required bool isLight,
  }) {
    return isLight ? light : dark;
  }

  @override
  Widget build(BuildContext context) {
    var appSettingsProvider = Provider.of<AppSettingProvider>(context);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsetsGeometry.symmetric(
            horizontal: 16 * context.screenWidthRatio,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            spacing: 10 * context.screenHeightRatio,
            children: [
              SizedBox(height: 16 * context.screenHeightRatio),
              Image.asset(
                _getImageByMode(
                  light: AppAssets.logoLight,
                  dark: AppAssets.logoDark,
                  isLight: appSettingsProvider.isLight,
                ),
              ),
              SizedBox(height: 24 * context.screenHeightRatio),
              Image.asset(
                _getImageByMode(
                  light: AppAssets.settingsLight,
                  dark: AppAssets.settingsDark,
                  isLight: appSettingsProvider.isLight,
                ),
              ),
              Text(
                context.tr('personalize_your_experience'),
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              Text(
                context.tr('choose'),
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              ToggleWidget(
                isEnabled: appSettingsProvider.isEnglish,
                isLang: true,
              ),
              ToggleWidget(
                isEnabled: appSettingsProvider.isLight,
                isLang: false,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
