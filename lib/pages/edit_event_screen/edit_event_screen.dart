import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../firebase_utils.dart';
import '../../models/event_model.dart';
import '../../providers/app_setting_provider.dart';
import '../../providers/user_provider.dart';
import '../../utils/app_assets.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_text_styles.dart';
import '../../utils/responsive.dart';
import '../../widget/custom_elevated_button.dart';
import '../../widget/custom_text_form_filed.dart';
import '../../widget/leading_icon.dart';
import '../../widget/tab_widget.dart';
import '../add_event_screen/widget/event_date_and_time.dart';

class EditEventScreen extends StatefulWidget {
  const EditEventScreen({super.key});

  @override
  State<EditEventScreen> createState() => _EditEventScreenState();
}

class _EditEventScreenState extends State<EditEventScreen> {
  late Event event;
  late DateTime selectedDate;
  late TimeOfDay selectedTime;
  late int selectedIndex;
  late TextEditingController titleController;
  late TextEditingController descriptionController;
  bool isInitialized = false;

  static const List<String> categories = [
    "sport",
    "book_club",
    "birthday",
    "meeting",
    "exhibition",
  ];

  final List<IconData> icons = [
    Icons.directions_bike_outlined,
    Icons.book_outlined,
    Icons.cake_outlined,
    Icons.group_outlined,
    Icons.data_exploration_outlined,
  ];

  final List<int> index = [0, 1, 2, 3, 4];

  final List<String> imagesLight = [
    AppAssets.sportLight,
    AppAssets.bookClubLight,
    AppAssets.birthdayLight,
    AppAssets.meetingLight,
    AppAssets.exhibitionLight,
  ];
  final List<String> imagesDark = [
    AppAssets.sportDark,
    AppAssets.bookClubDark,
    AppAssets.birthdayDark,
    AppAssets.meetingDark,
    AppAssets.exhibitionDark,
  ];

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  bool isDateErrorSeen = false;
  bool isTimeErrorSeen = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!isInitialized) {
      event = ModalRoute.of(context)!.settings.arguments as Event;
      selectedDate = event.date;
      final format = DateFormat.Hm();
      final dateTime = format.parse(event.time);
      selectedTime = TimeOfDay.fromDateTime(dateTime);
      selectedIndex = categories.indexOf(event.name);
      titleController = TextEditingController(text: event.title);
      descriptionController = TextEditingController(text: event.description);
      isInitialized = true;
    }
  }

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  void chooseDate() async {
    var date = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );
    if (date != null) {
      setState(() {
        selectedDate = date;
      });
    }
  }

  void chooseTime() async {
    var time = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );
    if (time != null) {
      setState(() {
        selectedTime = time;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var appSettingsProvider = Provider.of<AppSettingProvider>(context);
    var userProvider = Provider.of<UserProvider>(context);

    return Scaffold(
      appBar: AppBar(
        leading: AppBarCustomIcon(
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'edit_event'.tr(),
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
          child: Form(
            key: formKey,
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
                Text(
                  'title'.tr(),
                  style: AppTextStyles.m16.copyWith(
                    color: appSettingsProvider.isLight
                        ? AppColors.mainTextColor
                        : AppColors.whiteColor,
                  ),
                ),
                CustomTextFormFiled(
                  textInputAction: TextInputAction.next,
                  hintText: 'event_title'.tr(),
                  keyboardType: TextInputType.text,
                  controller: titleController,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'please_enter_title'.tr();
                    }
                    return null;
                  },
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
                  textInputAction: TextInputAction.done,
                  maxLines: 5,
                  hintText: 'event_description'.tr(),
                  keyboardType: TextInputType.text,
                  controller: descriptionController,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'please_enter_description'.tr();
                    }
                    return null;
                  },
                ),
                EventDateAndTime(
                  isEdit: true,
                  isDateOrTimeErrorSeen: isDateErrorSeen,
                  isDate: true,
                  onPressed: chooseDate,
                  selectedDateOrTime: DateFormat(
                    'MMM d,y',
                  ).format(selectedDate),
                ),
                EventDateAndTime(
                  isEdit: true,
                  isDateOrTimeErrorSeen: isTimeErrorSeen,
                  isDate: false,
                  onPressed: chooseTime,
                  selectedDateOrTime: selectedTime.format(context),
                ),
                SizedBox(height: 20 * context.screenHeightRatio),
                CustomElevatedButton(
                  text: 'update_event',
                  onButtonPressed: () {
                    setState(() {
                      isDateErrorSeen = false;
                      isTimeErrorSeen = false;
                    });
                    if (formKey.currentState!.validate()) {
                      Event newEvent = Event(
                        id: event.id,
                        isFavorite: event.isFavorite,
                        image: appSettingsProvider.isLight
                            ? imagesLight[selectedIndex]
                            : imagesDark[selectedIndex],
                        name: categories[selectedIndex],
                        title: titleController.text,
                        description: descriptionController.text,
                        time: selectedTime.format(context),
                        date: selectedDate,
                      );
                      FirebaseUtils.updateEvent(
                        event: newEvent,
                        eventId: event.id,
                        context: context,
                        appSettingsProvider: appSettingsProvider,
                        uId: userProvider.currentUser!.id,
                      );
                      /*  Navigator.pushNamedAndRemoveUntil(
                        context,
                        AppRoutes.homeLayoutRoute,
                        (predicate) => false,
                      );*/
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
