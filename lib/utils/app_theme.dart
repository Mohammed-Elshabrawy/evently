import 'package:evently/utils/app_colors.dart';
import 'package:flutter/material.dart';

import 'app_text_styles.dart';

class AppTheme {
 static final ThemeData lightTheme =ThemeData(
   textTheme: TextTheme(
     headlineMedium: AppTextStyles.sB20.copyWith(
       color: AppColors.mainTextColor,
     ),
     headlineSmall:AppTextStyles.m18.copyWith(
       color: AppColors.mainColor,
     ),
     bodyMedium: AppTextStyles.r16.copyWith(
       color: AppColors.secTextColor,
     )
   ),
    scaffoldBackgroundColor: AppColors.bgColor
  );
 static final ThemeData darkTheme =ThemeData(
     textTheme: TextTheme(
         headlineMedium: AppTextStyles.sB20.copyWith(
           color: AppColors.whiteColor,
         ),
         headlineSmall:AppTextStyles.m18.copyWith(
           color: AppColors.whiteColor,
         ),
         bodyMedium: AppTextStyles.r16.copyWith(
           color: AppColors.darkSecTextColor,
         )
     ),
    scaffoldBackgroundColor: AppColors.darkBGColor
  );

}