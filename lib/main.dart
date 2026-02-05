import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:evently/pages/add_event_screen/add_event_screen.dart';
import 'package:evently/pages/auth/forgot_password_screen/forgot_password_screen.dart';
import 'package:evently/pages/auth/login_screen/login_screen.dart';
import 'package:evently/pages/auth/signup_screen/signup_screen.dart';
import 'package:evently/pages/edit_event_screen/edit_event_screen.dart';
import 'package:evently/pages/event_details_screen/event_details_screen.dart';
import 'package:evently/pages/home_layout/home_layout.dart';
import 'package:evently/pages/onboarding/onboarding.dart';
import 'package:evently/pages/settings_screen/settings_screen.dart';
import 'package:evently/providers/app_setting_provider.dart';
import 'package:evently/providers/user_provider.dart';
import 'package:evently/utils/app_routes.dart';
import 'package:evently/utils/app_theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
  );
  await FirebaseFirestore.instance.enableNetwork();
  await EasyLocalization.ensureInitialized();

  final appSettingProvider = AppSettingProvider();
  final userProvider = UserProvider();

  appSettingProvider.loadTheme();
  appSettingProvider.loadLang();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => appSettingProvider),
        ChangeNotifierProvider(create: (context) => userProvider),
      ],
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
        AppRoutes.homeLayoutRoute: (context) => HomeLayout(),
        AppRoutes.loginRoute: (context) => const LoginScreen(),
        AppRoutes.signupRoute: (context) => const SignUpScreen(),
        AppRoutes.forgotPasswordRoute: (context) =>
            const ForgotPasswordScreen(),
        AppRoutes.addEventRoute: (context) => const AppEventScreen(),
        AppRoutes.eventDetailsScreen: (context) => EventDetailsScreen(),
        AppRoutes.editEventScreen: (context) => EditEventScreen(),
      },
      initialRoute: AppRoutes.loginRoute,
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
