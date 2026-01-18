import 'package:easy_localization/easy_localization.dart';
import 'package:evently/pages/home_screen/home_screen.dart';
import 'package:evently/pages/onboarding/onboarding.dart';
import 'package:evently/pages/settings_screen/settings_screen.dart';
import 'package:evently/providers/app_setting_provider.dart';
import 'package:evently/utils/app_routes.dart';
import 'package:evently/utils/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  
  final appSettingProvider = AppSettingProvider();
  appSettingProvider.loadTheme();
  appSettingProvider.loadLang();

  runApp(
    ChangeNotifierProvider(
      create: (BuildContext context) => appSettingProvider,
      child: Consumer<AppSettingProvider>(
        builder: (context, provider, child) {
          return EasyLocalization(
            supportedLocales: const [Locale('en'), Locale('ar')],
            path: 'assets/translations',
            fallbackLocale: const Locale('en'),
            child: const MyApp(),
          );
        },
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    var appSettingsProvider = Provider.of<AppSettingProvider>(context);
    return MaterialApp(
      routes: {
        AppRoutes.settingsRoute: (context) => const SettingsScreen(),
        AppRoutes.onBoardingRoute: (context) => const OnBoardingScreen(),
        AppRoutes.homeRoute: (context) => const HomeScreen(),
      },
      initialRoute: AppRoutes.settingsRoute,
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      debugShowCheckedModeBanner: false,
      locale: context.locale,
      themeMode: appSettingsProvider.isLight ? ThemeMode.light : ThemeMode.dark,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
    );
  }
}
