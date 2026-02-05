import 'package:easy_localization/easy_localization.dart';
import 'package:evently/pages/auth/widget/custom_divider.dart';
import 'package:evently/widget/custom_elevated_button.dart';
import 'package:evently/utils/app_assets.dart';
import 'package:evently/utils/app_colors.dart';
import 'package:evently/utils/responsive.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../firebase_utils.dart';
import '../../../functions/get_image/get_image.dart';
import '../../../providers/app_setting_provider.dart';
import '../../../providers/user_provider.dart';
import '../../../utils/app_routes.dart';
import '../../../utils/app_text_styles.dart';
import '../../../utils/snack_bar_utils.dart';
import '../../../widget/custom_text_button.dart';
import '../../../widget/custom_text_form_filed.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController(
    text: 'mohammed@gmail.com',
  );

  TextEditingController passwordController = TextEditingController(
    text: '123456',
  );
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  bool isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    var appSettingsProvider = Provider.of<AppSettingProvider>(context);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsetsGeometry.symmetric(
            horizontal: 15 * context.screenWidthRatio,
          ),
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                spacing: 20 * context.screenHeightRatio,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Image.asset(
                    getImageByMode(
                      light: AppAssets.logoLight,
                      dark: AppAssets.logoDark,
                      isLight: appSettingsProvider.isLight,
                    ),
                  ),
                  Text(
                    "login_to_your_account".tr(),
                    style: AppTextStyles.sB24.copyWith(
                      color: appSettingsProvider.isLight
                          ? AppColors.mainColor
                          : AppColors.whiteColor,
                    ),
                  ),
                  CustomTextFormFiled(
                    textInputAction: TextInputAction.next,
                    controller: emailController,
                    prefix: Icons.email_outlined,
                    hintText: "enter_your_email".tr(),
                    keyboardType: TextInputType.emailAddress,
                    validator: (email) {
                      if (email == null || email.trim().isEmpty) {
                        return 'please_enter_email'.tr();
                      } else if (!RegExp(
                        r'^[\w-.]+@([\w-]+\.)+[\w-]{2,4}$',
                      ).hasMatch(email)) {
                        return 'please_enter_valid_email'.tr();
                      }
                      return null;
                    },
                  ),
                  CustomTextFormFiled(
                    maxLines: 1,
                    obscureText: !isPasswordVisible,
                    textInputAction: TextInputAction.done,
                    controller: passwordController,
                    prefix: Icons.lock_outline_rounded,
                    hintText: "enter_your_password".tr(),
                    keyboardType: TextInputType.text,
                    suffix: isPasswordVisible
                        ? Icons.visibility_outlined
                        : Icons.visibility_off_outlined,
                    onSuffixPressed: () {
                      setState(() {
                        isPasswordVisible = !isPasswordVisible;
                      });
                    },
                    validator: (password) {
                      if (password == null || password.trim().isEmpty) {
                        return 'please_enter_password'.tr();
                      } else if (password.length < 6) {
                        return 'password_must_be_at_least_6_characters'.tr();
                      } else {
                        return null;
                      }
                    },
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: CustomTextButton(
                      onPressed: () {
                        Navigator.pushNamed(
                          context,
                          AppRoutes.forgotPasswordRoute,
                        );
                      },
                      text: 'forget_password? ',
                    ),
                  ),
                  SizedBox(height: 30 * context.screenHeightRatio),
                  CustomElevatedButton(
                    text: "login",
                    onButtonPressed: () {
                      login(appSettingsProvider);
                    },
                    /*  Navigator.pushReplacementNamed(
                        context,
                        AppRoutes.homeLayoutRoute,
                      );*/
                  ),
                  SizedBox(height: 30 * context.screenHeightRatio),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "don’t_have_an_account ?".tr(),
                        style: AppTextStyles.r14.copyWith(
                          color: appSettingsProvider.isLight
                              ? AppColors.secTextColor
                              : AppColors.darkSecTextColor,
                        ),
                      ),
                      CustomTextButton(
                        onPressed: () {
                          Navigator.pushReplacementNamed(
                            context,
                            AppRoutes.signupRoute,
                          );
                        },
                        text: 'signup',
                      ),
                    ],
                  ),
                  CustomDivider(),
                  CustomElevatedButton(
                    text: 'login_with_Google',
                    onButtonPressed: () {},
                    isGoogle: true,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void login(AppSettingProvider appSettingsProvider) async {
    if (formKey.currentState!.validate()) {
      SnackBarUtils.showSnackBarLoading(
        context: context,
        appSettingsProvider: appSettingsProvider,
      );
      try {
        final credential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(
              email: emailController.text,
              password: passwordController.text,
            );
        var user = await FirebaseUtils.readUserFromFireStore(
          credential.user!.uid,
        );
        var userProvider = Provider.of<UserProvider>(context, listen: false);
        userProvider.updateUser(user!);
        Navigator.pushReplacementNamed(context, AppRoutes.homeLayoutRoute);
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
        SnackBarUtils.showSnackBar(
          context: context,
          appSettingsProvider: appSettingsProvider,
          message: "logged_in_successfully",
        );
      } on FirebaseAuthException catch (e) {
        if (e.code == 'invalid-credential') {
          SnackBarUtils.showSnackBar(
            context: context,
            appSettingsProvider: appSettingsProvider,
            message: "wrong_email_or_password",
            isError: true,
          );
        }
      } catch (e) {
        SnackBarUtils.showSnackBar(
          context: context,
          appSettingsProvider: appSettingsProvider,
          message: e.toString(),
          isError: true,
        );
      }
    }
  }
}
