
import '../utils/images/app_images.dart';

class PageDataModel {
  final String iconPath;
  final String title;
  final String subtitle;


  PageDataModel(
      {required this.iconPath, required this.title, required this.subtitle, });
}

List<PageDataModel> pages = [
  PageDataModel(
    iconPath: AppImages.clock,
    title: "Manage your tasks",
    subtitle:"You can easily manage all of your daily tasks in DoMe for free"



  ),
  PageDataModel(
    iconPath: AppImages.daily,
    title: "Create daily routine",
      subtitle:"You can easily manage all of your daily tasks in DoMe for free"


  ),
  PageDataModel(
    iconPath: AppImages.task,
    title: "Orgonaize your tasks",
      subtitle:"You can easily manage all of your daily tasks in DoMe for free"

  ),



];
