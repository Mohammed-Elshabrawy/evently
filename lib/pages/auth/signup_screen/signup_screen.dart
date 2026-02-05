import 'package:easy_localization/easy_localization.dart';
import 'package:evently/models/user_model.dart';
import 'package:evently/utils/app_assets.dart';
import 'package:evently/utils/snack_bar_utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../firebase_utils.dart';
import '../../../functions/get_image/get_image.dart';
import '../../../providers/app_setting_provider.dart';
import '../../../providers/user_provider.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/app_routes.dart';
import '../../../utils/app_text_styles.dart';
import '../../../utils/responsive.dart';
import '../../../widget/custom_elevated_button.dart';
import '../../../widget/custom_text_form_filed.dart';
import '../widget/custom_divider.dart';
import '../../../widget/custom_text_button.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController nameController = TextEditingController(
    text: "mohammed",
  );
  TextEditingController emailController = TextEditingController(
    text: "mohammed@gmail.com",
  );
  TextEditingController passwordController = TextEditingController(
    text: "123456",
  );
  TextEditingController confirmPasswordController = TextEditingController(
    text: "123456",
  );
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool isPasswordVisible = false;
  bool isConfirmPasswordVisible = false;

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
                    "create_your_account".tr(),
                    style: AppTextStyles.sB24.copyWith(
                      color: appSettingsProvider.isLight
                          ? AppColors.mainColor
                          : AppColors.whiteColor,
                    ),
                  ),
                  CustomTextFormFiled(
                    controller: nameController,
                    textInputAction: TextInputAction.next,
                    prefix: Icons.person_outline_outlined,
                    hintText: "enter_your_name".tr(),
                    keyboardType: TextInputType.name,
                    validator: (name) {
                      if (name == null || name.trim().isEmpty) {
                        return 'please_enter_name'.tr();
                      }
                      return null;
                    },
                  ),
                  CustomTextFormFiled(
                    controller: emailController,
                    textInputAction: TextInputAction.next,
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
                    onSuffixPressed: () {
                      setState(() {
                        isPasswordVisible = !isPasswordVisible;
                      });
                    },
                    obscureText: !isPasswordVisible,
                    maxLines: 1,
                    controller: passwordController,
                    textInputAction: TextInputAction.next,
                    prefix: Icons.lock_outline_rounded,
                    hintText: "enter_your_password".tr(),
                    keyboardType: TextInputType.text,
                    suffix: isPasswordVisible
                        ? Icons.visibility_outlined
                        : Icons.visibility_off_outlined,
                    validator: (password) {
                      if (password == null || password.trim().isEmpty) {
                        return 'please_enter_password'.tr();
                      } else if (password.length < 6) {
                        return 'password_must_be_at_least_6_characters'.tr();
                      }
                      return null;
                    },
                  ),
                  CustomTextFormFiled(
                    onSuffixPressed: () {
                      setState(() {
                        isConfirmPasswordVisible = !isConfirmPasswordVisible;
                      });
                    },
                    obscureText: !isConfirmPasswordVisible,
                    maxLines: 1,
                    controller: confirmPasswordController,
                    textInputAction: TextInputAction.done,
                    prefix: Icons.lock_outline_rounded,
                    hintText: "confirm_your_password".tr(),
                    keyboardType: TextInputType.text,
                    suffix: isConfirmPasswordVisible
                        ? Icons.visibility_outlined
                        : Icons.visibility_off_outlined,
                    validator: (confirmPassword) {
                      if (confirmPassword == null ||
                          confirmPassword.trim().isEmpty) {
                        return 'please_enter_confirm_password'.tr();
                      } else if (confirmPassword != passwordController.text) {
                        return 'passwords_do_not_match'.tr();
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 30 * context.screenHeightRatio),
                  CustomElevatedButton(
                    text: "signup",
                    onButtonPressed: () {
                      register(appSettingsProvider);
                    },
                    /*Navigator.pushNamedAndRemoveUntil(
                        context,
                        AppRoutes.forgotPasswordRoute,
                        (route) => false,
                      );*/
                  ),
                  SizedBox(height: 30 * context.screenHeightRatio),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "already_have_an_account?".tr(),
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
                            AppRoutes.loginRoute,
                          );
                        },
                        text: 'login',
                      ),
                    ],
                  ),
                  CustomDivider(),
                  CustomElevatedButton(
                    text: 'sign_up_with_Google',
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

  void register(AppSettingProvider appSettingsProvider) async {
    if (formKey.currentState!.validate()) {
      SnackBarUtils.showSnackBarLoading(
        context: context,
        appSettingsProvider: appSettingsProvider,
      );
      try {
        final credential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
              email: emailController.text.trim(),
              password: passwordController.text,
            );
        MyUser myUser = MyUser(
          id: credential.user!.uid,
          name: nameController.text.trim(),
          email: emailController.text.trim(),
        );
        await FirebaseUtils.addUserToFireStore(myUser);
        var userProvider = Provider.of<UserProvider>(context, listen: false);
        userProvider.updateUser(myUser);
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
        SnackBarUtils.showSnackBar(
          context: context,
          appSettingsProvider: appSettingsProvider,
          message: "success_register",
        );
        Navigator.pushReplacementNamed(context, AppRoutes.homeLayoutRoute);
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          SnackBarUtils.showSnackBar(
            context: context,
            appSettingsProvider: appSettingsProvider,
            message: "the_password_provided_is_too_weak.",
            isError: true,
          );
        } else if (e.code == 'email-already-in-use') {
          SnackBarUtils.showSnackBar(
            context: context,
            appSettingsProvider: appSettingsProvider,
            message: "the_account_already_exists_for_that_email.",
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
