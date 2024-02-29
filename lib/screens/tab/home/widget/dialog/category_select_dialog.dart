import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:to_do_my/utils/colors/app_colors.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';
import 'dart:ui';

import '../../../../../data/category.dart';
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
                Text("Task Priority",style: AppTextStyle.interSemiBold.copyWith(
                  color: AppColors.white.withOpacity(.87),
                  fontSize: 20.sp
                )),
                SizedBox(height: 20.h),
                SizedBox(
                  height: 607.h,

                  child: GridView.count(crossAxisCount: 3,
                    children: [
                      ...List.generate(categories.length, (index){
                        return ZoomTapAnimation(
                          onTap: (){
                            setState((){
                              selectedCategory=categories[index].title;
                            });
                          },
                          child: Column(
                            children: [
                              Container(
                                padding:EdgeInsets.symmetric(horizontal: 16.w,vertical:16.h
                                ),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(4.r),
                                    color: (categories[index].title==selectedCategory)?AppColors.white:categories[index].color
                                ),
                                child:SvgPicture.asset(categories[index].icon,width:32.h,height:32.h.h,),
                              ),
                              SizedBox(height: 10),
                              Text(categories[index].title,style: AppTextStyle.interRegular.copyWith(
                                  color: AppColors.white.withOpacity(0.87),fontSize:14.sp
                              ),)
                            ],
                          ),
                        );
                      }),
                    ],),
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


