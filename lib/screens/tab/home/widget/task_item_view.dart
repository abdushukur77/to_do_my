import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:to_do_my/data/local/category/category_model.dart';
import 'package:to_do_my/data/task_model.dart';

import '../../../../data/local/local_database.dart';
import '../../../../utils/colors/app_colors.dart';
import '../../../../utils/images/app_images.dart';
import '../../../../utils/styles/app_text_style.dart';

class TaskItemView extends StatelessWidget {
  const TaskItemView({
    super.key,
    required this.taskModel,
    required this.onDelete,
    required this.onUpdate,
    required this.onStatusUpdate,
    required this.categoryModel,
  });

  final TaskModel taskModel;
  final CategoryModel categoryModel;
  final VoidCallback onDelete;
  final VoidCallback onUpdate;
  final VoidCallback onStatusUpdate;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(24.w),
      decoration: BoxDecoration(
        color: AppColors.c_363636,
        borderRadius: BorderRadius.circular(4.r),
      ),
      padding: EdgeInsets.only(top: 12.h, bottom: 4.h, left: 10.w, right: 10.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            taskModel.description,
            style: AppTextStyle.interSemiBold.copyWith(
                fontSize: 20.sp, color: AppColors.white.withOpacity(.87)),
          ),
          SizedBox(height: 10.h),
          Row(
            children: [
              IconButton(
                  onPressed: onDelete,
                  icon: Icon(Icons.delete, color: Colors.red)),
              IconButton(
                  onPressed: onUpdate,
                  icon: Icon(Icons.edit, color: Colors.black)),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                taskModel.deadline.toString().substring(10, 16),
                style: AppTextStyle.interSemiBold.copyWith(
                    fontSize: 12.sp, color: AppColors.white.withOpacity(.87)),
              ),
              Row(
                children: [
                  Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 27.w, vertical: 10.h),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4.r),
                        color: categoryModel.color,
                      ),
                      child: Column(
                        children: [
                          SizedBox(height: 7.h),
                          Text(
                            categoryModel.name,
                            style: AppTextStyle.interSemiBold.copyWith(
                                fontSize: 12.sp,
                                color: AppColors.white.withOpacity(.87)),
                          ),
                        ],
                      )),
                  SizedBox(
                    width: 10.w,
                  ),
                  Container(
                    padding:
                    EdgeInsets.symmetric(horizontal: 27.w, vertical: 10.h),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4.r),
                      color: AppColors.c_272727,
                    ),
                    child: Row(
                      children: [
                        GestureDetector(
                            onTap: () {},
                            child: SvgPicture.asset(
                              AppImages.flag,
                            )),
                        SizedBox(height: 7.h),
                        Text(
                          taskModel.priority.toString(),
                          style: AppTextStyle.interMedium.copyWith(
                              color: AppColors.white.withOpacity(.87)),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),

          TextButton(
            onPressed: onStatusUpdate,
            child: Text(
              taskModel.status.name,
              style: AppTextStyle.interMedium
                  .copyWith(color: AppColors.white.withOpacity(.87)),
            ),
          ),
        ],
      ),
    );
  }
}
