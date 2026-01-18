import 'package:evently/utils/responsive.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../providers/app_setting_provider.dart';
import '../../../utils/app_colors.dart';

class DotsRow extends StatelessWidget {
  const DotsRow({super.key, required this.index});
  final int index;
  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 10*context.screenWidthRatio,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Dot(index: 0, currentIndex: index),
        Dot(index: 1, currentIndex: index),
        Dot(index: 2, currentIndex: index),
      ],
    );
  }
}

class Dot extends StatelessWidget {
  const Dot({super.key, required this.index, required this.currentIndex});
  final int index;
  final int currentIndex;
  @override
  Widget build(BuildContext context) {
    var appSettingsProvider = Provider.of<AppSettingProvider>(context);

    return Container(
      width: index == currentIndex ? 20 : 8,
      height: 8 * context.screenHeightRatio,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(36),
        color: index == currentIndex
            ? appSettingsProvider.isLight
                  ? AppColors.mainColor
                  : AppColors.darkMainColor
            : appSettingsProvider.isLight
            ? AppColors.disableColor
            : AppColors.bgColor,
      ),
    );
  }
}
