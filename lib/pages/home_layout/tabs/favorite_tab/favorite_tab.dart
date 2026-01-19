import 'package:easy_localization/easy_localization.dart';
import 'package:evently/pages/auth/widget/custom_text_form_filed.dart';
import 'package:evently/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../providers/app_setting_provider.dart'
    show AppSettingProvider;
import '../home_tab/widget/event_item.dart';

class FavoriteTab extends StatelessWidget {
  const FavoriteTab({super.key});

  @override
  Widget build(BuildContext context) {
    var appSettingsProvider = Provider.of<AppSettingProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: CustomTextFormFiled(
          hintText: "search_for_event".tr(),
          keyboardType: TextInputType.text,
          suffix: Icons.search,
          suffixColor: appSettingsProvider.isLight
              ? AppColors.mainColor
              : AppColors.darkMainColor,
        ),
      ),
      body: ListView.builder(
        padding: EdgeInsets.zero,
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) => EventItem(),
        itemCount: 10,
      ),
    );
  }
}
