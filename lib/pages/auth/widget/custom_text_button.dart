import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../providers/app_setting_provider.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/app_text_styles.dart';

class CustomTextButton extends StatelessWidget {
  const CustomTextButton({
    super.key,
    required this.onPressed,
    required this.text,
    this.isGoogle = false,
  });
  final VoidCallback onPressed;
  final String text;
  final bool isGoogle;


  @override
  Widget build(BuildContext context) {
    var appSettingsProvider = Provider.of<AppSettingProvider>(context);
    return TextButton(
      style: TextButton.styleFrom(
        padding: EdgeInsets.zero,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        minimumSize: Size.zero,

      ),
      onPressed: onPressed,
      child: Text(
        text.tr(),
        style: AppTextStyles.sB14.copyWith(
          color: appSettingsProvider.isLight
              ? AppColors.mainColor
              : AppColors.darkMainColor,
          decoration: TextDecoration.underline,
        ),
      ),
    );
  }
}
