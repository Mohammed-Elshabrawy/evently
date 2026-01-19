import 'package:easy_localization/easy_localization.dart';
import 'package:evently/pages/home_layout/tabs/home_tab/widget/custom_app_bar.dart';
import 'package:evently/pages/home_layout/tabs/home_tab/widget/event_item.dart';
import 'package:evently/pages/home_layout/tabs/home_tab/widget/tab_widget.dart';
import 'package:evently/utils/app_colors.dart';
import 'package:evently/utils/app_text_styles.dart';
import 'package:evently/utils/responsive.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../providers/app_setting_provider.dart';

class HomeTab extends StatelessWidget {
  const HomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    var appSettingsProvider = Provider.of<AppSettingProvider>(context);
    return Scaffold(
      appBar: CustomAppBar(),
      body: ListView.builder(
        padding: EdgeInsets.zero,
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) => EventItem(),
        itemCount: 10,
      ),
    );
  }
}
