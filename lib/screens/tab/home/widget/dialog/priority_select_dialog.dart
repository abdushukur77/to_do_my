import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:to_do_my/utils/images/app_images.dart';
import 'package:to_do_my/utils/styles/app_text_style.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

import '../../../../../data/my_category.dart';
import '../../../../../utils/colors/app_colors.dart';
import '../../../../../utils/size/size_utils.dart';

showPrioritySelectDialog({
  required BuildContext context,
  required ValueChanged<int> priority,
  required int p,
}) {
  int pr = p;

  showDialog(
    context: context,
    builder: (context) {
      return StatefulBuilder(
        builder: (context, setState) {
          return Container(
            color: AppColors.c_363636,
            width: double.infinity,
            margin: EdgeInsets.symmetric(vertical: height / 4),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text("Task Priority",
                    style: AppTextStyle.interSemiBold
                        .copyWith(color: AppColors.white.withOpacity(.87))),
                const SizedBox(height: 20),
                Expanded(
                  child: GridView.count(
                    crossAxisCount: 4,
                    children: List.generate(priorities.length, (index) {
                      return Column(
                        children: [
                          ZoomTapAnimation(
                            onTap: () {
                              setState(() {
                                pr = index + 1;
                              });
                            },
                            child: Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 27.w, vertical: 10.h),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4.r),
                                  color: (index + 1) == pr
                                      ? AppColors.c_8687E7
                                      : AppColors.c_272727,
                                ),
                                child: Column(
                                  children: [
                                    GestureDetector(
                                        onTap: () {},
                                        child: SvgPicture.asset(
                                          AppImages.flag,
                                        )),
                                    SizedBox(height: 7.h),
                                    Text(
                                      (index + 1).toString(),
                                      style: AppTextStyle.interMedium.copyWith(
                                          color:
                                              AppColors.white.withOpacity(.87)),
                                    ),
                                  ],
                                )),
                          ),
                        ],
                      );
                    }),
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text("CANCEL"),
                      ),
                    ),
                    Expanded(
                      child: TextButton(
                        onPressed: () {
                          priority.call(pr);
                          Navigator.pop(context);
                        },
                        child: const Text("SAVE"),
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

List<int> priorities=[1,2,3,4,5,6,7,8,9,10];