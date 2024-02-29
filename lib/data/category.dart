import 'dart:ui';

import '../utils/images/app_images.dart';

class CategoryModel{
  String icon;
  String title;
  Color color;

  CategoryModel({
    required this.color,
    required this.title,
    required this.icon
  });
}


List<CategoryModel>categories= [
  
  CategoryModel(color: Color(0xffCCFF80), title: "Grocery", icon: AppImages.grocery),
  CategoryModel(color: Color(0xffFF9680), title: "Work", icon: AppImages.work),
  CategoryModel(color: Color(0xff80FFFF), title: "Sport", icon: AppImages.sport),
  CategoryModel(color: Color(0xff80FFD9), title: "Design", icon: AppImages.design),
  CategoryModel(color: Color(0xff809CFF), title: "University", icon: AppImages.university),
  CategoryModel(color: Color(0xffFF80EB), title: "Social", icon: AppImages.social),
  CategoryModel(color: Color(0xffFC80FF), title: "Music", icon: AppImages.music),
  CategoryModel(color: Color(0xff80FFA3), title: "Health", icon: AppImages.health),
  CategoryModel(color: Color(0xff80D1FF), title: "Movie", icon: AppImages.movie),
  CategoryModel(color: Color(0xffFFCC80), title: "Home", icon: AppImages.homes),
  CategoryModel(color: Color(0xff80FFD1), title: "Create New", icon: AppImages.create_new),

];