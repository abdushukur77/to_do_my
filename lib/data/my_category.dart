import 'dart:ui';

import '../utils/images/app_images.dart';
import 'local/category/category_model.dart';

class CategoryModell{
  String icon;
  String title;
  Color color;

  CategoryModell({
    required this.color,
    required this.title,
    required this.icon
  });
}




List<CategoryModel>categories= [

  CategoryModel(color: Color(0xffCCFF80), name: "Grocery", iconPath: AppImages.grocery),
  CategoryModel(color: Color(0xffFF9680), name: "Work", iconPath: AppImages.work),
  CategoryModel(color: Color(0xff80FFFF), name: "Sport", iconPath: AppImages.sport),
  CategoryModel(color: Color(0xff80FFD9), name: "Design", iconPath: AppImages.design),
  CategoryModel(color: Color(0xff809CFF), name: "University", iconPath: AppImages.university),
  CategoryModel(color: Color(0xffFF80EB), name: "Social", iconPath: AppImages.social),
  CategoryModel(color: Color(0xffFC80FF), name: "Music", iconPath: AppImages.music),
  CategoryModel(color: Color(0xff80FFA3), name: "Health", iconPath: AppImages.health),
  CategoryModel(color: Color(0xff80D1FF), name: "Movie", iconPath: AppImages.movie),
  CategoryModel(color: Color(0xffFFCC80), name: "Home", iconPath: AppImages.homes),
  CategoryModel(color: Color(0xff80FFD1), name: "Create New", iconPath: AppImages.create_new),

];

List<CategoryModel>myCategories= [

  CategoryModel(color: Color(0xffCCFF80), name: "Grocery", iconPath: AppImages.grocery),
  CategoryModel(color: Color(0xffFF9680), name: "Work", iconPath: AppImages.work),
  CategoryModel(color: Color(0xff80FFFF), name: "Sport", iconPath: AppImages.sport),
  CategoryModel(color: Color(0xff80FFD9), name: "Design", iconPath: AppImages.design),
  CategoryModel(color: Color(0xff809CFF), name: "University", iconPath: AppImages.university),
  CategoryModel(color: Color(0xffFF80EB), name: "Social", iconPath: AppImages.social),
  CategoryModel(color: Color(0xffFC80FF), name: "Music", iconPath: AppImages.music),
  CategoryModel(color: Color(0xff80FFA3), name: "Health", iconPath: AppImages.health),
  CategoryModel(color: Color(0xff80D1FF), name: "Movie", iconPath: AppImages.movie),
  CategoryModel(color: Color(0xffFFCC80), name: "Home", iconPath: AppImages.homes),
  CategoryModel(color: Color(0xff80FFD1), name: "Create New", iconPath: AppImages.create_new),

];
