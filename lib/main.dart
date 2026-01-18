import 'package:easy_localization/easy_localization.dart';
import 'package:evently/pages/settings_screen/settings_screen.dart';
import 'package:evently/providers/app_setting_provider.dart';
import 'package:evently/utils/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  final appSettingProvider = AppSettingProvider();
  appSettingProvider.loadTheme();
  runApp(
    ChangeNotifierProvider(
      create: (BuildContext context) => appSettingProvider..loadLang(context),
      child: Consumer<AppSettingProvider>(
        builder: (context, provider, child) {
          return EasyLocalization(
            startLocale: provider.isEnglish ? Locale('en') : Locale('ar'),
            saveLocale: false,
            supportedLocales: [Locale('en'), Locale('ar')],
            path: 'assets/translations',
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
      home: SettingsScreen(),
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
