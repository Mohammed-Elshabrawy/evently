import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:evently/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../firebase_utils.dart';
import '../../../../models/event_model.dart';
import '../../../../providers/app_setting_provider.dart';
import '../../../../utils/app_text_styles.dart';
import '../../../../widget/custom_text_form_filed.dart';
import '../home_tab/widget/event_item.dart';

class FavoriteTab extends StatefulWidget {
  const FavoriteTab({super.key});

  @override
  State<FavoriteTab> createState() => _FavoriteTabState();
}

class _FavoriteTabState extends State<FavoriteTab> {
  final TextEditingController searchController = .new();

  Stream<QuerySnapshot<Event>>? searchStream =
      FirebaseUtils.getEventsCollection()
          .where('isFavorite', isEqualTo: true)
          .snapshots();

  @override
  Widget build(BuildContext context) {
    var appSettingsProvider = Provider.of<AppSettingProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: CustomTextFormFiled(
          controller: searchController,
          textInputAction: TextInputAction.search,
          onChanged: (value) {
            searchStream = FirebaseUtils.getEventsCollection()
                .where('title', isGreaterThanOrEqualTo: value)
                .where('isFavorite', isEqualTo: true)
                .snapshots();
            setState(() {});
          },
          hintText: "search_for_event".tr(),
          keyboardType: TextInputType.text,
          suffix: Icons.search,
          suffixColor: appSettingsProvider.isLight
              ? AppColors.mainColor
              : AppColors.darkMainColor,
        ),
      ),
      body: StreamBuilder<QuerySnapshot<Event>>(
        stream: searchController.text.trim().isEmpty
            ? FirebaseUtils.getEventsCollection()
                  .where('isFavorite', isEqualTo: true)
                  .snapshots()
            : searchStream,
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
