import 'package:carousel_slider/carousel_slider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:evently/pages/onboarding/widget/dots_row.dart';
import 'package:evently/widget/custom_elevated_button.dart';
import 'package:evently/utils/app_routes.dart';
import 'package:evently/utils/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../functions/get_image/get_image.dart';
import '../../providers/app_setting_provider.dart';
import '../../utils/app_assets.dart';
import '../../utils/app_colors.dart';
import '../../utils/responsive.dart';
import '../../widget/leading_icon.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  OnBoardingScreenState createState() => OnBoardingScreenState();
}

class OnBoardingScreenState extends State<OnBoardingScreen> {
  int currentIndex = 0;

  List<String> imagesLight = [
    AppAssets.onBoarding2light,
    AppAssets.onBoarding3light,
    AppAssets.onBoarding4light,
  ];
  List<String> imagesDark = [
    AppAssets.onBoarding2dark,
    AppAssets.onBoarding3dark,
    AppAssets.onBoarding4dark,
  ];
  List<String> titleText = ['find'.tr(), 'effortless'.tr(), 'connect'.tr()];
  List<String> bodyText = ['dive'.tr(), 'take'.tr(), 'make'.tr()];
  List<int> index = [0, 1, 2];
  CarouselSliderController carouselController = .new();

  @override
  Widget build(BuildContext context) {
    var appSettingsProvider = Provider.of<AppSettingProvider>(context);
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 85 * context.screenWidthRatio,
        backgroundColor: AppColors.transparentColor,
        actionsPadding: EdgeInsets.symmetric(
          horizontal: 16 * context.screenWidthRatio,
        ),
        centerTitle: true,
        leading: Visibility(
          visible: currentIndex != 0,
          child: LeadingIcon(
            onPressed: () {
              setState(() {
                carouselController.previousPage(
                  duration: Duration(milliseconds: 300),
                  curve: Curves.linear,
                );
              });
            },
          ),
        ),
        title: Image.asset(
          getImageByMode(
            light: AppAssets.logoLight,
            dark: AppAssets.logoDark,
            isLight: appSettingsProvider.isLight,
          ),
        ),
        actions: [
          Visibility(
            visible: currentIndex != 2,
            child: InkWell(
              onTap: () {
                Navigator.pushReplacementNamed(context, AppRoutes.homeRoute);
              },
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 16 * context.screenWidthRatio,
                  vertical: 8 * context.screenHeightRatio,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: appSettingsProvider.isLight
                      ? AppColors.whiteColor
                      : AppColors.inputsColor,
                  border: Border.all(
                    color: appSettingsProvider.isLight
                        ? AppColors.strokeColor
                        : AppColors.darkStrokeColor,
                    width: 1,
                  ),
                ),
                child: Text(
                  "skip".tr(),
                  style: AppTextStyles.sB14.copyWith(
                    color: appSettingsProvider.isLight
                        ? AppColors.mainColor
                        : AppColors.whiteColor,
                  ),
                ).tr(),
              ),
            ),
          ),
        ],
      ),
      body: CarouselSlider(
        carouselController: carouselController,
        items: index.map((i) {
          return Builder(
            builder: (context) {
              return Padding(
                padding: EdgeInsetsGeometry.symmetric(
                  horizontal: 16 * context.screenWidthRatio,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  spacing: 16 * context.screenHeightRatio,
                  children: [
                    Image.asset(
                      getImageByMode(
                        light: imagesLight[i],
                        dark: imagesDark[i],
                        isLight: appSettingsProvider.isLight,
                      ),
                    ),
                    DotsRow(index: i),
                    Text(
                      titleText[i],
                      style: AppTextStyles.sB20.copyWith(
                        color: appSettingsProvider.isLight
                            ? AppColors.mainTextColor
                            : AppColors.whiteColor,
                      ),
                    ),
                    Text(
                      bodyText[i],
                      style: AppTextStyles.r16.copyWith(
                        color: appSettingsProvider.isLight
                            ? AppColors.secTextColor
                            : AppColors.darkSecTextColor,
                      ),
                    ),
                    Spacer(),
                    CustomElevatedButton(
                      text: i != 2 ? 'next' : 'get_started',
                      onButtonPressed: () {
                        if (i != 2) {
                          setState(() {
                            carouselController.nextPage(
                              duration: Duration(milliseconds: 300),
                              curve: Curves.linear,
                            );
                          });
                        } else if (i == 2) {
                          Navigator.pushReplacementNamed(
                            context,
                            AppRoutes.homeRoute,
                          );
                        }
                      },
                    ),
                    SizedBox(height: 16 * context.screenHeightRatio),
                  ],
                ),
              );
            },
          );
        }).toList(),
        options: CarouselOptions(
          autoPlay: false,
          autoPlayInterval: Duration.zero,
          autoPlayAnimationDuration: Duration.zero,
          enableInfiniteScroll: false,
          height: double.infinity,

          viewportFraction: 1.0,
          enlargeCenterPage: false,
          onPageChanged: (index, reason) {
            setState(() {
              currentIndex = index;
            });
          },
        ),
      ),
    );
  }
}
