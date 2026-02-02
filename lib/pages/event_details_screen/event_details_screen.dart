import 'package:easy_localization/easy_localization.dart';
import 'package:evently/models/event_model.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:provider/provider.dart';
import '../../firebase_utils.dart';
import '../../providers/app_setting_provider.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_routes.dart';
import '../../utils/app_text_styles.dart';
import '../../utils/responsive.dart';
import '../../widget/leading_icon.dart';

class EventDetailsScreen extends StatelessWidget {
  EventDetailsScreen({super.key});
  late Event event;

  @override
  Widget build(BuildContext context) {
    event = ModalRoute.of(context)!.settings.arguments as Event;
    final format = DateFormat.Hm();
    final dateTime = format.parse(event.time);

    var appSettingsProvider = Provider.of<AppSettingProvider>(context);
    return Scaffold(
      appBar: AppBar(
        actionsPadding: EdgeInsets.symmetric(
          horizontal: 16 * context.screenWidthRatio,
        ),
        leading: AppBarCustomIcon(
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'event_details'.tr(),
          style: AppTextStyles.m18.copyWith(
            color: appSettingsProvider.isLight
                ? AppColors.mainTextColor
                : AppColors.whiteColor,
          ),
        ),
        centerTitle: true,
        actions: [
          AppBarCustomIcon(
            isLeading: false,
            onPressed: () {
              Navigator.pushNamed(
                context,
                AppRoutes.editEventScreen,
                arguments: event,
              );
            },
            icon: Icon(
              Icons.edit_outlined,
              color: appSettingsProvider.isLight
                  ? AppColors.mainColor
                  : AppColors.darkMainColor,
            ),
          ),
          SizedBox(width: 8 * context.screenWidthRatio),
          AppBarCustomIcon(
            icon: Icon(
              Icons.delete_outline_outlined,
              color: AppColors.redColor,
            ),
            isLeading: false,
            onPressed: () {
              ///todo:delete event
              FirebaseUtils.deleteEvent(event.id, context, appSettingsProvider);
            },
          ),
        ],
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
                  child: Image.asset(event.image, fit: BoxFit.cover),
                ),
              ),
              Text(
                event.title,
                style: AppTextStyles.m18.copyWith(
                  color: appSettingsProvider.isLight
                      ? AppColors.mainTextColor
                      : AppColors.whiteColor,
                ),
              ),
              Container(
                padding: EdgeInsets.all(16 * context.screenWidthRatio),
                decoration: BoxDecoration(
                  color: appSettingsProvider.isLight
                      ? AppColors.whiteColor
                      : AppColors.inputsColor,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: appSettingsProvider.isLight
                        ? AppColors.strokeColor
                        : AppColors.darkStrokeColor,
                  ),
                ),
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(10 * context.screenWidthRatio),
                      decoration: BoxDecoration(
                        color: appSettingsProvider.isLight
                            ? AppColors.bgColor
                            : AppColors.inputsColor,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: appSettingsProvider.isLight
                              ? AppColors.strokeColor
                              : AppColors.darkStrokeColor,
                        ),
                      ),
                      child: Icon(
                        Bootstrap.calendar_check,
                        color: appSettingsProvider.isLight
                            ? AppColors.mainColor
                            : AppColors.darkMainColor,
                      ),
                    ),
                    SizedBox(width: 10 * context.screenWidthRatio),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          DateFormat('d MMMM').format(event.date),
                          style: AppTextStyles.m16.copyWith(
                            color: appSettingsProvider.isLight
                                ? AppColors.mainTextColor
                                : AppColors.whiteColor,
                          ),
                        ),
                        Text(
                          TimeOfDay.fromDateTime(dateTime).format(context),
                          style: AppTextStyles.m16.copyWith(
                            color: appSettingsProvider.isLight
                                ? AppColors.disableColor
                                : AppColors.darkSecTextColor,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Text(
                'description'.tr(),
                style: AppTextStyles.m18.copyWith(
                  color: appSettingsProvider.isLight
                      ? AppColors.mainTextColor
                      : AppColors.whiteColor,
                ),
              ),
              Container(
                constraints: BoxConstraints(
                  minHeight: 180 * context.screenHeightRatio,
                ),
                padding: EdgeInsets.all(16 * context.screenWidthRatio),
                decoration: BoxDecoration(
                  color: appSettingsProvider.isLight
                      ? AppColors.whiteColor
                      : AppColors.inputsColor,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: appSettingsProvider.isLight
                        ? AppColors.strokeColor
                        : AppColors.darkStrokeColor,
                  ),
                ),
                child: Text(
                  event.description,
                  style: AppTextStyles.m16.copyWith(
                    color: appSettingsProvider.isLight
                        ? AppColors.mainTextColor
                        : AppColors.whiteColor,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
