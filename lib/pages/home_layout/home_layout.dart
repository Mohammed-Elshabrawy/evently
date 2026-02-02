import 'package:easy_localization/easy_localization.dart';
import 'package:evently/pages/home_layout/tabs/favorite_tab/favorite_tab.dart';
import 'package:evently/pages/home_layout/tabs/home_tab/home_tab.dart';
import 'package:evently/pages/home_layout/tabs/profile_tab/profile_tab.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:provider/provider.dart';
import '../../providers/app_setting_provider.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_routes.dart';
import '../../utils/app_text_styles.dart';

class HomeLayout extends StatefulWidget {
  const HomeLayout({super.key});

  @override
  State<HomeLayout> createState() => _HomeLayoutState();
}

class _HomeLayoutState extends State<HomeLayout> {
  final List<Widget> tabs = [HomeTab(), FavoriteTab(), const ProfileTab()];

  int currentInex = 0;

  @override
  Widget build(BuildContext context) {
    var appSettingsProvider = Provider.of<AppSettingProvider>(context);
    return Scaffold(
      floatingActionButton: Visibility(
        visible: currentInex == 0,
        child: FloatingActionButton(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
          ),
          backgroundColor: appSettingsProvider.isLight
              ? AppColors.mainColor
              : AppColors.darkMainColor,
          onPressed: () {
            Navigator.pushNamed(context, AppRoutes.addEventRoute);
          },
          child: const Icon(Icons.add, color: AppColors.whiteColor),
        ),
      ),
      body: tabs[currentInex],
      bottomNavigationBar: BottomNavigationBar(
        selectedLabelStyle: AppTextStyles.r12.copyWith(
          fontStyle: FontStyle.italic,
        ),
        unselectedLabelStyle: AppTextStyles.r12.copyWith(
          fontStyle: FontStyle.italic,
        ),
        unselectedItemColor: AppColors.disableColor,
        selectedItemColor: appSettingsProvider.isLight
            ? AppColors.mainColor
            : AppColors.darkMainColor,
        backgroundColor: appSettingsProvider.isLight
            ? AppColors.whiteColor
            : AppColors.darkBGColor,
        currentIndex: currentInex,
        onTap: (index) {
          setState(() {
            currentInex = index;
          });
        },
        items: [
          getCustomBottomNavigationBarItem(
            icon: AntDesign.home_outline,
            iconFiled: AntDesign.home_fill,
            label: 'home',
            index: 0,
          ),
          getCustomBottomNavigationBarItem(
            icon: AntDesign.heart_outline,
            iconFiled: AntDesign.heart_fill,
            label: 'favorite',
            index: 1,
          ),
          getCustomBottomNavigationBarItem(
            icon: Bootstrap.person,
            iconFiled: Bootstrap.person_fill,
            label: 'profile',
            index: 2,
          ),
        ],
      ),
    );
  }

  BottomNavigationBarItem getCustomBottomNavigationBarItem({
    required IconData icon,
    required IconData iconFiled,
    required String label,
    required int index,
  }) {
    return BottomNavigationBarItem(
      icon: Icon(currentInex == index ? iconFiled : icon),
      label: label.tr(),
    );
  }
}
