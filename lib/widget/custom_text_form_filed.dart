import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/app_setting_provider.dart';
import '../utils/app_colors.dart';
import '../utils/app_text_styles.dart';

typedef Validator = String? Function(String?);
typedef OnChanged = void Function(String)?;

class CustomTextFormFiled extends StatelessWidget {
  const CustomTextFormFiled({
    super.key,
    this.prefix,
    required this.hintText,
    this.suffix,
    required this.keyboardType,
    this.suffixColor,
    this.maxLines,
    this.controller,
    this.validator,
    this.textInputAction,
    this.onChanged,
  });
  final TextEditingController? controller;
  final int? maxLines;
  final IconData? prefix;
  final String hintText;
  final IconData? suffix;
  final TextInputType keyboardType;
  final Color? suffixColor;
  final Validator? validator;
  final TextInputAction? textInputAction;
  final OnChanged? onChanged;

  @override
  Widget build(BuildContext context) {
    var appSettingsProvider = Provider.of<AppSettingProvider>(context);
    final InputBorder border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide(
        color: appSettingsProvider.isLight
            ? AppColors.strokeColor
            : AppColors.darkStrokeColor,
      ),
    );
    return TextFormField(
      onChanged: onChanged,
      textInputAction: textInputAction,
      controller: controller,
      validator: validator,
      maxLines: maxLines,
      style: AppTextStyles.r14.copyWith(
        color: appSettingsProvider.isLight
            ? AppColors.mainTextColor
            : AppColors.whiteColor,
      ),
      keyboardType: keyboardType,
      decoration: InputDecoration(
        prefixIcon: prefix != null
            ? Icon(prefix, color: AppColors.disableColor)
            : null,
        filled: true,
        fillColor: appSettingsProvider.isLight
            ? AppColors.whiteColor
            : AppColors.darkBGColor,
        hintText: hintText,
        hintStyle: AppTextStyles.r14.copyWith(
          color: appSettingsProvider.isLight
              ? AppColors.secTextColor
              : AppColors.darkSecTextColor,
        ),
        focusedBorder: border,
        disabledBorder: border,
        border: border,
        enabledBorder: border,
        suffixIcon: suffix != null
            ? InkWell(
                onTap: () {
                  //Todo: add password visibility
                },
                child: Icon(
                  suffix,
                  color: suffixColor ?? AppColors.disableColor,
                ),
              )
            : null,
      ),
    );
  }
}
