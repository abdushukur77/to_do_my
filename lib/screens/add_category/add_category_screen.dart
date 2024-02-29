import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:to_do_my/data/local/category/category_model.dart';
import 'package:to_do_my/data/my_category.dart';
import 'package:to_do_my/screens/add_category/show_category.dart';
import 'package:to_do_my/screens/routes.dart';
import 'package:to_do_my/utils/colors/app_colors.dart';
import 'package:to_do_my/utils/images/app_images.dart';
import 'package:to_do_my/utils/styles/app_text_style.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

import '../../data/local/local_database.dart';
import '../tab/home/widget/dialog/category_select_dialog.dart';

class AddCategoryScreen extends StatefulWidget {
  const AddCategoryScreen({super.key, required this.onSet});

  final VoidCallback onSet;

  @override
  State<AddCategoryScreen> createState() => _AddCategoryScreenState();
}

final TextEditingController categoryController = TextEditingController();
final FocusNode focusNode = FocusNode();

String selectedIcon = AppImages.grocery;
String category = "Grocery";
int activeIconIndex = -1;
int activeColorIndex = -1;
int isVisibleIndex = -1;

List<Color> colors = [
  Color(0xff80FFD1),
  Color(0xffFFCC80),
  Color(0xff80D1FF),
  Color(0xff80FFA3),
  Color(0xffFC80FF),
  Color(0xff80FFD9),
  Color(0xff80FFFF),
  Color(0xffFF9680),
  Color(0xffCCFF80),
];
List<String> myIcon = [
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
  AppImages.create_new
];

List<String> categoriesTewxts = [
  "Grocery",
  "Work",
  "Design",
  "Create New",
  "University",
  "Social",
  "Music",
  "Health" "Movie",
  "Home",
  "Create New",
];

class _AddCategoryScreenState extends State<AddCategoryScreen> {
  @override
  void initState() {
    super.initState();
  }

  Future<void> initChange() async {
    categories.addAll(await LocalDatabase.getAllCategory());
    widget.onSet.call();
    Navigator.pop(context);
    setState(() {});
  }

  CategoryModel categoryModel = CategoryModel.initialValue;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.black,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 50.h,
          ),
          Text(
            "Create new category",
            style: AppTextStyle.interSemiBold
                .copyWith(color: AppColors.white, fontSize: 20.sp),
          ),
          SizedBox(
            height: 20.h,
          ),
          Text(
            "Category name :",
            style: AppTextStyle.interLight
                .copyWith(color: AppColors.white, fontSize: 20.sp),
          ),
          SizedBox(
            height: 20.h,
          ),
          TextField(
            style: AppTextStyle.interSemiBold.copyWith(color: AppColors.white),
            maxLines: null,
            textInputAction: TextInputAction.done,
            focusNode: focusNode,
            controller: categoryController,
            decoration: const InputDecoration(
                hintText: "Category name",
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: AppColors.white)),
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: AppColors.white)),
                hintStyle: TextStyle(color: AppColors.white),
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: AppColors.white),
                )),
          ),
          SizedBox(height: 20.h),
          Text(
            "Category icon :",
            style: AppTextStyle.interLight
                .copyWith(color: AppColors.white, fontSize: 20.sp),
          ),
          SizedBox(
            height: 20.h,
          ),
          SizedBox(
            height: 100,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                ...List.generate(
                    myIcon.length,
                    (index) => Row(
                          children: [
                            SizedBox(width: 10.w),
                            ZoomTapAnimation(
                                onTap: () {
                                  isVisibleIndex = index;
                                  categoryModel = categoryModel.copyWith(
                                      iconPath: myIcon[index]);
                                  setState(() {});
                                },
                                child: Stack(
                                  children: [
                                    Container(
                                      height: 50.h,
                                      width: 50.w,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                      ),
                                      child: SvgPicture.asset(myIcon[index]),
                                    ),
                                    (isVisibleIndex == index)
                                        ? Icon(
                                            Icons.check,
                                            color: Colors.green,
                                          )
                                        : Text(""),
                                  ],
                                )),
                          ],
                        ))
              ],
            ),
          ),
          Text(
            "Category color :",
            style: AppTextStyle.interLight
                .copyWith(color: AppColors.white, fontSize: 20.sp),
          ),
          SizedBox(height: 10.h),
          SizedBox(
            height: 100,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                ...List.generate(
                  colors.length,
                  (index) => Row(
                    children: [
                      SizedBox(width: 10.w),
                      Stack(children: [
                        ZoomTapAnimation(
                          onTap: () {
                            activeColorIndex = index;
                            categoryModel =
                                categoryModel.copyWith(color: colors[index]);
                            setState(() {});
                          },
                          child: Container(
                            height: 50.h,
                            width: 50.w,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: colors[index],
                            ),
                            child: (activeColorIndex == index)
                                ? Icon(
                                    Icons.check,
                                    color: Colors.green,
                                  )
                                : Text(""),
                          ),
                        ),
                      ]),
                    ],
                  ),
                ),
              ],
            ),
          ),
          TextButton(
              onPressed: () async {
                categoryModel =
                    categoryModel.copyWith(name: categoryController.text);
                // print(categoryModel.name);
                // print(categoryModel.iconPath);
                // print(categoryModel.color.value);
                if (categoryModel.canAddTaskToDatabase()) {
                  debugPrint("Buhoroo");
                  await LocalDatabase.insertCategory(categoryModel);
                  print("ID:_________${categoryModel.id}");
                  initChange();
                  Navigator.pushReplacementNamed(context, RouteNames.home);
                }
              },
              child: Text("Save")),
        ],
      ),
    );
  }
}
