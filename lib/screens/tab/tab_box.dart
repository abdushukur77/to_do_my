import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:to_do_my/screens/tab/profile/profile_screen.dart';
import 'package:to_do_my/utils/colors/app_colors.dart';
import 'package:to_do_my/utils/images/app_images.dart';
import 'package:to_do_my/utils/styles/app_text_style.dart';

import 'calendar/calendar_screen.dart';
import 'home/home_screen.dart';

class TabBox extends StatefulWidget {
  const TabBox({Key? key}) : super(key: key);

  @override
  State<TabBox> createState() => _TabBoxState();
}

class _TabBoxState extends State<TabBox> {
  List<Widget> screens = [HomeScreen(), CalendarScreen(), ProfileScreen()];

  int activeIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[activeIndex],

      // floatingActionButtonLocation: FloatingActionButtonLocation.miniCenterDocked,
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: AppColors.c_363636,
        currentIndex: activeIndex,
        onTap: (index) {
          setState(() {
            activeIndex = index;
          });
        },
        selectedItemColor: AppColors.white,
        unselectedItemColor: AppColors.white.withOpacity(.5),
        items:  [
          BottomNavigationBarItem(
            icon: SvgPicture.asset(AppImages.index),

            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(AppImages.calendar),
            label: "Calendar",
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(AppImages.profile),
            label: "Profile",
          ),


        ],
      ),
    );
  }


}
