import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:to_do_my/screens/on_boarding/on_boarding_screen.dart';
import 'package:to_do_my/utils/constants/storage_keys.dart';
import 'package:to_do_my/utils/images/app_images.dart';
import 'package:to_do_my/utils/local/storage_repository.dart';

import '../../utils/colors/app_colors.dart';
import '../../utils/size/size_utils.dart';
import '../../utils/styles/app_text_style.dart';
import '../routes.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {

    bool isEnteredBefore =
        StorageRepository.getBool(key: StorageKeys.onBoardingState);

    Future.delayed(const Duration(seconds: 1), () {
      if (isEnteredBefore) {
        Navigator.pushNamed(context, RouteNames.tabBox);
      } else {
        Navigator.pushNamed(context, RouteNames.onBoarding);
      }


    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    width  = MediaQuery.of(context).size.width;
    height  = MediaQuery.of(context).size.height;
    return AnnotatedRegion(
      value: SystemUiOverlayStyle(statusBarColor: AppColors.transparent),
      child: Scaffold(
        backgroundColor: AppColors.black,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: SvgPicture.asset(AppImages.uptodo),
            )
          ],
        ),
      ),
    );
  }
}
