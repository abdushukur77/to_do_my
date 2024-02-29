import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:to_do_my/screens/on_boarding/pages/screen_item.dart';
import 'package:to_do_my/utils/constants/storage_keys.dart';
import 'package:to_do_my/utils/local/storage_repository.dart';

import '../../data/page_data_model.dart';
import '../../utils/colors/app_colors.dart';
import '../../utils/styles/app_text_style.dart';
import '../routes.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final PageController pageController = PageController();
  int activeIndex = 0;

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
      value: SystemUiOverlayStyle(statusBarColor: AppColors.transparent),
      child: Scaffold(
        backgroundColor: AppColors.black,
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 47.h),
              Expanded(
                child: PageView(
                  physics: NeverScrollableScrollPhysics(),
                  controller: pageController,
                  children: [
                    ...List.generate(pages.length,
                            (index) => ScreenItem(pageDataModel: pages[index]))
                  ],
                ),
              ),
              SizedBox(height: 20.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ...List.generate(
                    pages.length,
                        (index) =>
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 5),
                          height: 4.h,
                          width: 26.w,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4.r),
                              color: (activeIndex == index)
                                  ? AppColors.white
                                  : Colors.blueGrey),
                        ),
                  )
                ],
              ),
              SizedBox(height: 20.h),
              Row(

                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () {
                      if (activeIndex < pages.length - 1) {
                        activeIndex--;
                        setState(() {});
                        pageController.jumpToPage(activeIndex);
                      }
                    },
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.symmetric(
                          horizontal: 24.w, vertical: 12.h),


                    ),
                    child: Text(
                      "BACK",
                      style: AppTextStyle.interSemiBold
                          .copyWith(color: AppColors.white.withOpacity(.44),
                          fontSize: 16.sp),
                    ),
                  ),
                  TextButton(
                    onPressed: ()async {
                      if (activeIndex < pages.length-1) {
                        activeIndex++;
                        setState(() {});
                        pageController.jumpToPage(activeIndex);
                      }else{
                        await StorageRepository.setBool(
                            key: StorageKeys.onBoardingState, value: true);


                        Navigator.pushNamed(context, RouteNames.tabBox);

                      };
                      if (activeIndex == pages.length) {
                        setState(() {});
                        StorageRepository.setBool(
                          key: StorageKeys.onBoardingState, value: true);


                        Navigator.pushNamed(context, RouteNames.tabBox);
                      };
                    },
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.symmetric(
                          horizontal: 24.w, vertical: 12.h),
                      backgroundColor: AppColors.c_8875FF,


                    ),
                    child: (activeIndex != pages.length - 1) ? Text(
                      "Next",
                      style: AppTextStyle.interSemiBold
                          .copyWith(color: AppColors.white, fontSize: 16.sp),

                    ) : Text(
                      "GET STARTED",
                      style: AppTextStyle.interSemiBold
                          .copyWith(color: AppColors.white, fontSize: 16.sp),
                    ),
                  ),


                ],),
              SizedBox(height: 62.h),
            ],
          ),
        ),
      ),
    );
  }
}
