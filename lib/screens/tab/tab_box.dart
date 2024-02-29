import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:to_do_my/screens/tab/profile/profile_screen.dart';
import 'package:to_do_my/utils/colors/app_colors.dart';
import 'package:to_do_my/utils/images/app_images.dart';
import 'package:to_do_my/utils/styles/app_text_style.dart';

import '../../data/local/local_database.dart';
import '../../data/my_category.dart';
import '../../data/task_model.dart';
import 'calendar/calendar_screen.dart';
import 'home/home_screen.dart';
import 'home/widget/dialog/add_task_dialog.dart';

class TabBox extends StatefulWidget {
  const TabBox({Key? key}) : super(key: key);

  @override
  State<TabBox> createState() => _TabBoxState();
}

class _TabBoxState extends State<TabBox> {
  StreamController<bool> streamController = StreamController<bool>();
  List<Widget> screens = [
    HomeScreen(),
    CalendarScreen(),
    ProfileScreen(),
  ];

  TaskModel taskModel = TaskModel.initialValue;
  List<TaskModel> tasks = [];

  _init() async {

    screens = [
      HomeScreen(stream: streamController.stream.asBroadcastStream()),
      CalendarScreen(),
      ProfileScreen(),
    ];
    setState(() {

    });

    tasks = await LocalDatabase.getAllTasks();
    setState(() {});
  }

  Future<void> changeCategory() async {
    categories = await LocalDatabase.getAllCategory();
    setState(() {});
  }

  _searchQuery(String q) async {
    tasks = await LocalDatabase.searchTasks(q);
    setState(() {});
  }



  int activeIndex = 0;

  @override
  void initState() {


    taskModel.canAddTaskToDatabase();
    changeCategory();

    _init();
    super.initState();
  }

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
          items: [
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
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            // _showAddItemDialog(context);
            addTaskDialog(
              context: context,
              taskModelChanged: (task) async {
                await LocalDatabase.insertTask(task);
streamController.add(true);
              },
            );
          },
          child: Icon(Icons.add),
          backgroundColor: AppColors.c_8875FF,
        ));
  }
}
