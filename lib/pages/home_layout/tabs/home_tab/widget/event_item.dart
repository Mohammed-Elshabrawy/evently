import 'package:easy_localization/easy_localization.dart';
import 'package:evently/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../../firebase_utils.dart';
import '../../../../../models/event_model.dart';
import '../../../../../providers/app_setting_provider.dart';
import '../../../../../utils/app_text_styles.dart';
import '../../../../../utils/responsive.dart';

class EventItem extends StatelessWidget {
  const EventItem({super.key, required this.event});
  final Event event;

  @override
  Widget build(BuildContext context) {
    var appSettingsProvider = Provider.of<AppSettingProvider>(context);
    return Container(
      height: 200 * context.screenHeightRatio,
      width: double.infinity,
      padding: EdgeInsets.all(16 * context.screenWidthRatio),
      margin: EdgeInsets.symmetric(
        horizontal: 16 * context.screenWidthRatio,
        vertical: 8 * context.screenHeightRatio,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: appSettingsProvider.isLight
              ? AppColors.strokeColor
              : AppColors.darkStrokeColor,
        ),
        image: DecorationImage(
          image: AssetImage(event.image),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: Container(
              decoration: BoxDecoration(
                color: appSettingsProvider.isLight
                    ? AppColors.bgColor
                    : AppColors.darkBGColor,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: appSettingsProvider.isLight
                      ? AppColors.strokeColor
                      : AppColors.darkStrokeColor,
                ),
              ),
              padding: EdgeInsets.all(8 * context.screenWidthRatio),
              child: Text(
                DateFormat('d MMM').format(event.date),
                style: AppTextStyles.sB16.copyWith(
                  color: appSettingsProvider.isLight
                      ? AppColors.mainColor
                      : AppColors.darkMainColor,
                ),
              ),
            ),
          ),
          Container(
            width: double.infinity,

            decoration: BoxDecoration(
              color: appSettingsProvider.isLight
                  ? AppColors.bgColor
                  : AppColors.darkBGColor,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: appSettingsProvider.isLight
                    ? AppColors.strokeColor
                    : AppColors.darkStrokeColor,
              ),
            ),
            padding: EdgeInsets.all(8 * context.screenWidthRatio),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  event.title,
                  style: AppTextStyles.m14.copyWith(
                    color: appSettingsProvider.isLight
                        ? AppColors.mainTextColor
                        : AppColors.whiteColor,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    FirebaseUtils.updateEventIsFavorite(
                      event,
                      context,
                      appSettingsProvider,
                    );
                  },
                  icon: Icon(
                    event.isFavorite ? Icons.favorite : Icons.favorite_border,
                    color: appSettingsProvider.isLight
                        ? AppColors.mainColor
                        : AppColors.darkMainColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
