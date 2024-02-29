import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:to_do_my/screens/routes.dart';
import 'package:to_do_my/utils/colors/app_colors.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';
import 'dart:ui';

import '../../../../../data/my_category.dart';
import '../../../../../utils/size/size_utils.dart';
import '../../../../../utils/styles/app_text_style.dart';
import '../../utils/images/app_images.dart';

addShowCategorySelectDialog({
  required BuildContext context,
  required ValueChanged<String> categoryNameSelection,
  required String category,
}) {
  String selectedCategory = category;
  int activeIndex=0;


  List<String>myIcon = [
    AppImages.grocery,
    AppImages.work,
    AppImages.sport,
    AppImages.design,
    AppImages.university,
    AppImages.social,
    AppImages.music,
    AppImages.health,
    AppImages.movie,
    AppImages.homes,
  ];




  showDialog(
    context: context,
    builder: (context) {
      return StatefulBuilder(
        builder: (context, setState) {
          return Container(
            color: AppColors.c_363636,
            width: double.infinity,
            margin: EdgeInsets.symmetric(vertical: 30.h),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text("Select Category",
                    style: AppTextStyle.interSemiBold.copyWith(
                        color: AppColors.white.withOpacity(.87),
                        fontSize: 20.sp)),
                SizedBox(height: 20.h),
                SizedBox(
                  height: 607.h,
                  child: SizedBox(
                    height: 200.h,
                    child:
                        ListView(scrollDirection: Axis.horizontal, children: [
                      ...List.generate(myIcon.length, (index) {
                        return ZoomTapAnimation(
                          onTap: () {
                            setState(() {
                              selectedCategory = myIcon[index];
                              activeIndex;

                            });
                          },
                          child:   Container(
                            padding:EdgeInsets.symmetric(horizontal: 16.w,vertical:16.h
                            ),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4.r),
                                color: (index==activeIndex)?AppColors.white:Colors.black

                            ),
                            child:SvgPicture.asset(myIcon[index],width:32.h,height:32.h.h,),
                          ),
                        );
                      }),
                    ]),
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text("CANCEL"),
                      ),
                    ),
                    Expanded(
                      child: TextButton(
                        onPressed: () {
                          categoryNameSelection.call(selectedCategory);
                          Navigator.pop(context);
                        },
                        child: Text("SAVE"),
                      ),
                    )
                  ],
                )
              ],
            ),
          );
        },
      );
    },
  );
}
