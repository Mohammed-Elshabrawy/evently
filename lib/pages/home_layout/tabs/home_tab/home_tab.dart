import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:evently/firebase_utils.dart';
import 'package:evently/models/event_model.dart';
import 'package:evently/pages/home_layout/tabs/home_tab/widget/event_item.dart';
import 'package:evently/utils/app_colors.dart';
import 'package:evently/utils/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../providers/app_setting_provider.dart';
import '../../../../providers/user_provider.dart';
import '../../../../utils/responsive.dart';
import '../../../../widget/tab_widget.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  final List<String> categories = [
    "all",
    "sport",
    "birthday",
    "book_club",
    "meeting",
    "exhibition",
  ];

  final List<IconData> icons = [
    Icons.border_all_outlined,
    Icons.directions_bike_outlined,
    Icons.cake_outlined,
    Icons.book_outlined,
    Icons.group_outlined,
    Icons.data_exploration_outlined,
  ];

  final List<int> index = [0, 1, 2, 3, 4, 5];

  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    var appSettingsProvider = Provider.of<AppSettingProvider>(context);
    var userProvider = Provider.of<UserProvider>(context);

    return Scaffold(
      appBar: AppBar(
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
                      userProvider.currentUser!.name,
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
                  splashBorderRadius: BorderRadius.circular(16),
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
      ),
      body: StreamBuilder<QuerySnapshot<Event>>(
        stream: selectedIndex == 0
            ? FirebaseUtils.getEventsCollection(
                userProvider.currentUser!.id,
              ).orderBy('date').snapshots()
            : FirebaseUtils.getEventsCollection(userProvider.currentUser!.id)
                  .orderBy('date')
                  .where('name', isEqualTo: categories[selectedIndex])
                  .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(
                color: appSettingsProvider.isLight
                    ? AppColors.mainColor
                    : AppColors.darkMainColor,
              ),
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Text("Something went wrong: ${snapshot.error}"),
            );
          }

          final events =
              snapshot.data?.docs.map((doc) => doc.data()).toList() ?? [];

          if (events.isEmpty) {
            return Center(
              child: Text(
                "no_events_found".tr(),
                style: AppTextStyles.sB20.copyWith(
                  color: appSettingsProvider.isLight
                      ? AppColors.mainTextColor
                      : AppColors.whiteColor,
                ),
              ),
            );
          }

          return ListView.builder(
            padding: EdgeInsets.zero,
            physics: const BouncingScrollPhysics(),
            itemCount: events.length,
            itemBuilder: (context, index) {
              return EventItem(event: events[index]);
            },
          );
        },
      ),
    );
  }
}
