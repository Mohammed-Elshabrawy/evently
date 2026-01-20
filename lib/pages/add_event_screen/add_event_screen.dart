import 'package:easy_localization/easy_localization.dart';
import 'package:evently/pages/add_event_screen/widget/event_date_and_time.dart';
import 'package:evently/utils/app_assets.dart';
import 'package:evently/utils/app_text_styles.dart';
import 'package:evently/widget/custom_elevated_button.dart';
import 'package:evently/widget/leading_icon.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/app_setting_provider.dart';
import '../../utils/app_colors.dart';
import '../../utils/responsive.dart';
import '../../widget/custom_text_form_filed.dart';
import '../../widget/tab_widget.dart';

class AppEventScreen extends StatefulWidget {
  const AppEventScreen({super.key});

  @override
  State<AppEventScreen> createState() => _AppEventScreenState();
}

class _AppEventScreenState extends State<AppEventScreen> {
  List<String> categories = [
    "sport",
    "book_club",
    "birthday",
    "meeting",
    "exhibition",
  ];

  List<IconData> icons = [
    Icons.directions_bike_outlined,
    Icons.book_outlined,
    Icons.cake_outlined,
    Icons.group_outlined,
    Icons.data_exploration_outlined,
  ];

  List<int> index = [0, 1, 2, 3, 4];

  List<String> imagesLight = [
    AppAssets.sportLight,
    AppAssets.bookClubLight,
    AppAssets.birthdayLight,
    AppAssets.meetingLight,
    AppAssets.exhibitionLight,
  ];
  List<String> imagesDark = [
    AppAssets.sportDark,
    AppAssets.bookClubDark,
    AppAssets.birthdayDark,
    AppAssets.meetingDark,
    AppAssets.exhibitionDark,
  ];

  int selectedIndex = 0;

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
          'add_event'.tr(),
          style: AppTextStyles.m18.copyWith(
            color: appSettingsProvider.isLight
                ? AppColors.mainTextColor
                : AppColors.whiteColor,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 16 * context.screenWidthRatio,
            vertical: 30 * context.screenHeightRatio,
          ),
          child: Column(
            spacing: 10 * context.screenHeightRatio,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: appSettingsProvider.isLight
                        ? AppColors.strokeColor
                        : AppColors.darkStrokeColor,
                  ),
                ),
                child: ClipRRect(
                  clipBehavior: Clip.hardEdge,
                  borderRadius: BorderRadius.circular(16),
                  child: Image.asset(
                    appSettingsProvider.isLight
                        ? imagesLight[selectedIndex]
                        : imagesDark[selectedIndex],
                    fit: BoxFit.cover,
                  ),
                ),
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
              Text(
                'title'.tr(),
                style: AppTextStyles.m16.copyWith(
                  color: appSettingsProvider.isLight
                      ? AppColors.mainTextColor
                      : AppColors.whiteColor,
                ),
              ),
              CustomTextFormFiled(
                hintText: 'event_title'.tr(),
                keyboardType: TextInputType.text,
              ),
              Text(
                'description'.tr(),
                style: AppTextStyles.m16.copyWith(
                  color: appSettingsProvider.isLight
                      ? AppColors.mainTextColor
                      : AppColors.whiteColor,
                ),
              ),
              CustomTextFormFiled(
                maxLines: 5,
                hintText: 'event_description'.tr(),
                keyboardType: TextInputType.text,
              ),
              EventDateAndTime(
                isDate: true,
                onPressed: () {
                  //todo: show date picker
                },
              ),
              EventDateAndTime(
                isDate: false,
                onPressed: () {
                  //todo: show time picker
                },
              ),
              SizedBox(height: 20 * context.screenHeightRatio),
              CustomElevatedButton(
                text: 'add_event',
                onButtonPressed: () {
                  //todo: add event
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
