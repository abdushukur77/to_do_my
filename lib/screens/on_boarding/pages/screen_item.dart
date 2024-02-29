import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:to_do_my/screens/routes.dart';

import '../../../data/page_data_model.dart';
import '../../../utils/colors/app_colors.dart';
import '../../../utils/styles/app_text_style.dart';

class ScreenItem extends StatefulWidget {
   ScreenItem({super.key, required this.pageDataModel});

  final PageDataModel pageDataModel;

  @override
  State<ScreenItem> createState() => _ScreenItemState();


}


class _ScreenItemState extends State<ScreenItem> {
  final PageController pageController =PageController();  int activeIndex = 0;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(


        children: [


          SizedBox(height: 25.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
          TextButton(
            onPressed: () {
              Navigator.pushNamed(context, RouteNames.home);
            },
            style: TextButton.styleFrom(
              padding: EdgeInsets.symmetric(horizontal: 0.w,vertical: 0.h),



            ),
            child: Text(
              "SKIP",
              style: AppTextStyle.interLight
                  .copyWith(color: AppColors.white.withOpacity(.44), fontSize: 18.sp),
            ),
          ),
        ],),

          SvgPicture.asset(
            widget.pageDataModel.iconPath,
            fit: BoxFit.cover,
          ),
          SizedBox(height: 105.h),

          Expanded(
            child: Text(
              widget.pageDataModel.title,
              style: AppTextStyle.interMedium
                  .copyWith(fontSize: 32.sp, color: AppColors.white),
            ),
          ),

          SizedBox(height: 10.h),

          Expanded(
            child: Text(
              widget.pageDataModel.subtitle,
              style: AppTextStyle.interMedium
                  .copyWith(fontSize: 16.sp, color: AppColors.white.withOpacity(.87)),
            ),
          ),




        ],
      ),
    );
  }
}
