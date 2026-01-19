import 'package:easy_localization/easy_localization.dart';
import 'package:evently/pages/home_layout/tabs/home_tab/widget/tab_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../providers/app_setting_provider.dart';
import '../../../../../utils/app_colors.dart';
import '../../../../../utils/app_text_styles.dart';
import '../../../../../utils/responsive.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(100);
}

class _CustomAppBarState extends State<CustomAppBar> {
  List<String> categories = [
    "all",
    "sport",
    "birthday",
    "book_club",
    "meeting",
  ];

  List<IconData> icons = [
    Icons.border_all_outlined,
    Icons.directions_bike_outlined,
    Icons.cake_outlined,
    Icons.book_outlined,
    Icons.group_outlined,
  ];

  List<int> index = [0, 1, 2, 3, 4];

  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    var appSettingsProvider = Provider.of<AppSettingProvider>(context);

    return AppBar(
      toolbarHeight: 100 * context.screenHeightRatio,
      title: Column(
        spacing: 10 * context.screenHeightRatio,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            spacing: 8 * context.screenWidthRatio,
            children: [
              Column(
                spacing: 5 * context.screenHeightRatio,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "welcome_back".tr(),
                    style: AppTextStyles.r14.copyWith(
                      color: appSettingsProvider.isLight
                          ? AppColors.secTextColor
                          : AppColors.darkSecTextColor,
                    ),
                  ),
                  Text(
                    "mohammed Elshabrawy",
                    style: AppTextStyles.m20.copyWith(
                      color: appSettingsProvider.isLight
                          ? AppColors.mainTextColor
                          : AppColors.whiteColor,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              Icon(
                appSettingsProvider.isLight
                    ? Icons.light_mode_outlined
                    : Icons.dark_mode_outlined,
                color: appSettingsProvider.isLight
                    ? AppColors.mainColor
                    : AppColors.darkMainColor,
              ),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 8 * context.screenWidthRatio,
                  vertical: 6 * context.screenHeightRatio,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: appSettingsProvider.isLight
                      ? AppColors.mainColor
                      : AppColors.darkMainColor,
                ),
                child: Text(
                  appSettingsProvider.isEnglish ? 'EN' : 'AR',
                  style: AppTextStyles.sB14.copyWith(
                    color: AppColors.whiteColor,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 40 * context.screenHeightRatio,
            child: DefaultTabController(
              initialIndex: selectedIndex,
              length: index.length,
              child: TabBar(
                tabs: index.map((index) {
                  return TabWidget(
                    title: categories[index],
                    icon: icons[index],
                    isSelected: index == selectedIndex,
                  );
                }).toList(),
                isScrollable: true,
                onTap: (index) {
                  setState(() {
                    selectedIndex = index;
                  });
                },
                indicatorColor: AppColors.transparentColor,
                dividerColor: AppColors.transparentColor,
                tabAlignment: TabAlignment.start,
                labelPadding: EdgeInsets.symmetric(
                  horizontal: 4 * context.screenWidthRatio,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
