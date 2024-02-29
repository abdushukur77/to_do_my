import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import 'package:intl/intl.dart';
import 'package:to_do_my/screens/tab/home/widget/dialog/priority_select_dialog.dart';
import 'package:to_do_my/utils/colors/app_colors.dart';

import '../../../../../data/task_model.dart';
import '../../../../../utils/images/app_images.dart';
import '../../../../../utils/styles/app_text_style.dart';
import '../../../../../utils/utilities.dart';
import 'category_select_dialog.dart';

addTaskDialog({
  required BuildContext context,
  required ValueChanged<TaskModel> taskModelChanged,
}) {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  TaskModel taskModel = TaskModel.initialValue;

  DateTime? dateTime;
  TimeOfDay? timeOfDay;

  String category = "work";
  int priority = 1;

  final FocusNode focusNode1 = FocusNode();
  final FocusNode focusNode2 = FocusNode();

  showModalBottomSheet(
   isScrollControlled: true,
    scrollControlDisabledMaxHeightRatio: .80,
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topRight: Radius.circular(16),
        topLeft: Radius.circular(16),
      ),
    ),
    builder: (context) {
      return StatefulBuilder(builder: (context, setState) {
        return Container(
          color: AppColors.c_363636,
          padding: EdgeInsets.all(24),
          child: Padding(
            padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Add Task",
                  style: AppTextStyle.interSemiBold.copyWith(
                      fontSize: 20, color: AppColors.white.withOpacity(.87)),
                ),
                TextField(

                  maxLines: null,



                  textInputAction: TextInputAction.next,
                  focusNode: focusNode1,
                  controller: titleController,
                  style: AppTextStyle.interSemiBold.copyWith(
                    fontSize: 16,
                    color: AppColors.white.withOpacity(.87)
                  ),
                  onChanged: (v) {
                    taskModel = taskModel.copyWith(title: v);
                  },

                  decoration:
                      InputDecoration(


                        focusedBorder:OutlineInputBorder(
                            borderSide: BorderSide(
                                width: 1,
                                color: Colors.grey
                            )
                        ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              width: 1,
                              color: Colors.grey
                            )
                          ),
                          contentPadding: EdgeInsets.all(5.h)),
                ),
                SizedBox(height: 20),
                TextField(
                  maxLines: null,
                  textInputAction: TextInputAction.done,
                  focusNode: focusNode2,
                  onChanged: (v) {
                    taskModel = taskModel.copyWith(description: v);
                  },
                  controller: descriptionController,
                  style: AppTextStyle.interSemiBold.copyWith(
                    fontSize: 16,
                      color: AppColors.white.withOpacity(.87)
                  ),
                  decoration:  InputDecoration(


                      focusedBorder:OutlineInputBorder(
                          borderSide: BorderSide(
                              width: 1,
                              color: Colors.grey
                          )
                      ),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              width: 1,
                              color: Colors.grey
                          )
                      ),
                      contentPadding: EdgeInsets.all(5.h)),
                ),
                Row(
                  children: [
                    IconButton(
                      onPressed: () async {
                        dateTime = await showDatePicker(
                          cancelText: "Cancel",
                          confirmText: "Select",
                          barrierDismissible: false,
                          context: context,
                          firstDate: DateTime.now(),
                          lastDate: DateTime(2030),
                          currentDate: DateTime.now(),
                        );

                        if (dateTime != null) {
                          setState(() {
                            taskModel = taskModel.copyWith(deadline: dateTime);
                          });
                        }
                      },
                      icon: SvgPicture.asset(
                        AppImages.second,
                        height: 24.h,
                        width: 24.w,
                      ),
                    ),
                    IconButton(
                      onPressed: () async {
                        timeOfDay = await showTimePicker(
                          context: context,
                          initialEntryMode: TimePickerEntryMode.input,
                          initialTime: const TimeOfDay(hour: 8, minute: 0),
                          builder: (BuildContext context, Widget? child) {
                            return MediaQuery(
                              data: MediaQuery.of(context)
                                  .copyWith(alwaysUse24HourFormat: true),
                              child: child!,
                            );
                          },
                        );

                        if (timeOfDay != null) {
                          DateTime d = taskModel.deadline;
                          d.copyWith(
                            hour: timeOfDay!.hour,
                            minute: timeOfDay!.minute,
                          );
                          setState(() {
                            taskModel = taskModel.copyWith(deadline: d);
                          });
                        }
                      },
                      icon: SvgPicture.asset(
                        AppImages.flagg,
                        height: 24.h,
                        width: 24.w,
                      ),
                    ),
                    IconButton(
                      onPressed: () async {
                        showCategorySelectDialog(
                          context: context,
                          categorySelection: (selectedCategory) {
                            setState(() {
                              category = selectedCategory;
                            });
                            taskModel =
                                taskModel.copyWith(category: selectedCategory);
                          },
                          category: category,
                        );
                      },
                      icon: SvgPicture.asset(
                        AppImages.flag,
                        height: 24.h,
                        width: 24.w,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        showPrioritySelectDialog(

                          p: taskModel.priority,
                          context: context,
                          priority: (p) {
                            setState(() {
                              priority = p;
                            });
                            taskModel = taskModel.copyWith(priority: p);
                            if (taskModel.canAddTaskToDatabase()) {
                              print("SUCCESS");
                              showSuccessMessage("SUCCESS");
                              taskModelChanged.call(taskModel);
                              Navigator.pop(context);
                            } else {
                              showErrorMessage("ERROR");
                            }
                          },
                        );
                      },
                      icon: const Icon(Icons.flag),
                    ),
                    Expanded(
                      child: TextButton(
                        onPressed: () {},
                        child: SvgPicture.asset(
                          AppImages.send,
                          height: 24.h,
                          width: 24.w,
                        ),
                      ),
                    )
                  ],
                ),
                if (timeOfDay != null)
                  Row(
                    children: [
                      const Text("TIME: "),
                      Text("${timeOfDay!.hour}:${timeOfDay!.minute}"),
                    ],
                  ),
                if (dateTime != null)
                  Row(
                    children: [
                      const Text("DEADLINE: "),
                      Text(DateFormat.yMMMEd().format(dateTime!)),
                    ],
                  ),
                Row(
                  children: [
                    const Text("CATEGORY: "),
                    Text(category),
                  ],
                ),
              ],
            ),
          ),
        );
      });
    },
  );
}
