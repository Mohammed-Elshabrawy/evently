import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import '../../utils/app_assets.dart';
import '../../utils/responsive.dart';

class OnBoardingPage extends StatefulWidget {
  const OnBoardingPage({super.key});

  @override
  OnBoardingPageState createState() => OnBoardingPageState();
}

class OnBoardingPageState extends State<OnBoardingPage> {
  final introKey = GlobalKey<IntroductionScreenState>();

  void _onIntroEnd(BuildContext context) {
    /* Navigator.of(
      context,
    ).pushReplacement(MaterialPageRoute(builder: (_) => const HomeScreen()));*/
  }

  Widget _buildImage(String assetName) {
    return Image.asset(assetName);
  }

  @override
  Widget build(BuildContext context) {
    final pageDecoration = PageDecoration(
      titlePadding: EdgeInsets.only(top: 20 * (context.screenHeightRatio)),
      titleTextStyle: const TextStyle(
        fontSize: 24.0,
        fontWeight: FontWeight.bold,
        // color: AppColors.goldColor,
      ),
      bodyTextStyle: const TextStyle(
        fontSize: 20.0,
        //color: AppColors.goldColor,
        fontWeight: FontWeight.bold,
      ),
      bodyPadding: EdgeInsets.fromLTRB(
        16.0 * context.screenWidthRatio,
        16.0 * context.screenHeightRatio,
        16.0 * context.screenWidthRatio,
        0.0,
      ),
      imageAlignment: Alignment.bottomCenter,
      imageFlex: 4,
      //  pageColor: AppColors.blackColor,
      imagePadding: EdgeInsets.only(
        left: 16 * context.screenWidthRatio,
        right: 16 * context.screenWidthRatio,
        top: 40 * context.screenHeightRatio,
      ),
    );

    return IntroductionScreen(
      key: introKey,
      //globalBackgroundColor: AppColors.blackColor,
      allowImplicitScrolling: true,
      autoScrollDuration: 3000,
      globalHeader: Align(
        alignment: Alignment.center,
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.only(
              top: 16 * context.screenHeightRatio,
              right: 16 * context.screenWidthRatio,
            ),
            child: _buildImage(
              Theme.of(context).brightness == Brightness.light
                  ? AppAssets.logoLight
                  : AppAssets.logoDark,
            ),
          ),
        ),
      ),
      pages: [
        PageViewModel(
          title: "Welcome To Islami App",
          body: "",
          // image: _buildImage(AppAssets.appOnboarding1),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Welcome To Islami",
          body: "We Are Very Excited To Have You In Our Community",
          // image: _buildImage(AppAssets.appOnboarding2),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Reading the Quran",
          body: "Read, and your Lord is the Most Generous",
          // image: _buildImage(AppAssets.appOnboarding3),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Bearish",
          body: "Praise the name of your Lord, the Most High",
          //  image: _buildImage(AppAssets.appOnboarding4),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Holy Quran Radio",
          body:
              "You can listen to the Holy Quran Radio through the application for free and easily",
          // image: _buildImage(AppAssets.appOnboarding5),
          decoration: pageDecoration,
        ),
      ],
      onDone: () => _onIntroEnd(context),
      showSkipButton: false,
      skipOrBackFlex: 0,
      nextFlex: 0,
      showBackButton: true,
      back: const Text("Back", style: TextStyle()),
      next: const Text("Next", style: TextStyle()),
      done: const Text(
        'Finish',
        style: TextStyle(
          fontWeight: FontWeight.w600,
          //color: AppColors.goldColor,
        ),
      ),
      curve: Curves.fastLinearToSlowEaseIn,
      controlsMargin: EdgeInsets.all(16 * context.ratio),
      controlsPadding: EdgeInsets.symmetric(
        horizontal: 8.0 * context.screenWidthRatio,
        vertical: 4.0 * context.screenHeightRatio,
      ),
      dotsDecorator: DotsDecorator(
        size: Size(
          10.0 * context.screenWidthRatio,
          10.0 * context.screenHeightRatio,
        ),
        color: Color(0xFFBDBDBD),
        activeSize: Size(
          22.0 * context.screenWidthRatio,
          10.0 * context.screenHeightRatio,
        ),
        //activeColor: AppColors.goldColor,
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25.0)),
        ),
      ),
      dotsContainerDecorator: const ShapeDecoration(
        color: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
        ),
      ),
    );
  }
}
