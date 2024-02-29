import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:to_do_my/data/local/local_database.dart';
import 'package:to_do_my/screens/routes.dart';
import 'package:to_do_my/utils/colors/app_colors.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';
import 'dart:ui';

import '../../../../../data/my_category.dart';
import '../../../../../utils/images/app_images.dart';
import '../../../../../utils/size/size_utils.dart';
import '../../../../../utils/styles/app_text_style.dart';

showCategorySelectDialog({
  required BuildContext context,
  required ValueChanged<String> categorySelection,
  required String category,
}) {
  String selectedCategory = category;

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
                Text("Category",
                    style: AppTextStyle.interSemiBold.copyWith(
                        color: AppColors.white.withOpacity(.87),
                        fontSize: 20.sp)),
                SizedBox(height: 20.h),
                SizedBox(
                  height: 607.h,
                  child: GridView.count(
                    crossAxisCount: 3,
                    children: [
                      ...List.generate(myCategories.length, (index) {
                        return ZoomTapAnimation(

                          onTap: () {
                            setState(() {
                              selectedCategory = myCategories[index].name;
                            });
                            if (index == myCategories.length - 1) {
                              Navigator.pushNamed(
                                  context, RouteNames.addCategory,
                                  arguments: () {
                                setState(() {});
                              });
                            }
                          },
                          child: Column(
                            children: [
                              Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 16.w, vertical: 16.h),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(4.r),
                                    color: (myCategories[index].name ==
                                            selectedCategory)
                                        ? AppColors.white
                                        : myCategories[index].color),
                                child: SvgPicture.asset(
                                  myCategories[index].iconPath,
                                  width: 32.h,
                                  height: 32.h.h,
                                ),
                              ),
                              SizedBox(height: 10),
                              Text(
                                myCategories[index].name,
                                style: AppTextStyle.interRegular.copyWith(
                                    color: AppColors.white.withOpacity(0.87),
                                    fontSize: 14.sp),
                              )
                            ],
                          ),
                        );
                      }),
                      ...List.generate(categories.length, (index) {
                        return ZoomTapAnimation(
                          onLongTap: () {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return Padding(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 250.h, horizontal: 50.w),
                                    child: Container(
                                        padding: EdgeInsets.all(40.h),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                            BorderRadius.circular(24.r),
                                            color: AppColors.white),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Text(
                                              "O'chirishni hohlaysizmi ",
                                              style: AppTextStyle.interSemiBold
                                                  .copyWith(
                                                  color: AppColors.black
                                                      .withOpacity(.87),
                                                  fontSize: 20.sp),
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                              children: [
                                                TextButton(
                                                  onPressed: () async {
                                                    if(categories[index].id!=null){

                                                      LocalDatabase
                                                          .deleteCategory(
                                                          categories[index]
                                                              .id!);


                                                      inintCchnge();
                                                      setState((){});




                                                      Navigator.pop(context);

                                                    }
                                                  },
                                                  child: Text("Yes"),
                                                ),
                                                TextButton(
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                  child: Text("No"),
                                                ),
                                              ],
                                            )
                                          ],
                                        )),
                                  );
                                });
                          },
                          onTap: () {
                            setState(() {
                              selectedCategory = categories[index].name;
                            });
                            if (index == categories.length - 1) {
                              Navigator.pushNamed(
                                  context, RouteNames.addCategory,
                                  arguments: () {
                                    setState(() {});
                                  });
                            }
                          },
                          child: Column(
                            children: [
                              Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 16.w, vertical: 16.h),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(4.r),
                                    color: (categories[index].name ==
                                        selectedCategory)
                                        ? AppColors.white
                                        : categories[index].color),
                                child: SvgPicture.asset(
                                  categories[index].iconPath,
                                  width: 32.h,
                                  height: 32.h.h,
                                ),
                              ),
                              SizedBox(height: 10),
                              Text(
                                categories[index].name,
                                style: AppTextStyle.interRegular.copyWith(
                                    color: AppColors.white.withOpacity(0.87),
                                    fontSize: 14.sp),
                              )
                            ],
                          ),
                        );
                      }),
                    ],
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
                          categorySelection.call(selectedCategory);
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
Future<void> inintCchnge() async {
  categories = await LocalDatabase.getAllCategory();
}