import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:to_do_my/data/my_category.dart';
import 'package:to_do_my/data/local/local_database.dart';
import 'package:to_do_my/screens/tab/home/widget/dialog/add_task_dialog.dart';
import 'package:to_do_my/screens/tab/home/widget/dialog/update_task_dialog.dart';
import 'package:to_do_my/screens/tab/home/widget/task_item_view.dart';

import '../../../data/task_model.dart';
import '../../../utils/colors/app_colors.dart';
import '../../../utils/images/app_images.dart';
import '../../../utils/styles/app_text_style.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, this.stream});

  final Stream? stream;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TaskModel taskModel = TaskModel.initialValue;
  List<TaskModel> tasks = [];

  _init() async {
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

  DateTime? dateTime;
  TimeOfDay? timeOfDay;

  @override
  void initState() {
    if (widget.stream != null) {
      _init();
    }
    taskModel.canAddTaskToDatabase();
    changeCategory();

    _init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
          onPressed: () {},
          icon: SvgPicture.asset(AppImages.hamburger),
        ),
        title: Text("Index"),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {},
            icon: Image.asset(AppImages.boy),
          ),
        ],
        automaticallyImplyLeading: false,
      ),
      body: RefreshIndicator(
        backgroundColor: AppColors.white,
        onRefresh: () {
          _init();

          return Future<void>.delayed(Duration(seconds: 1));
        },
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: TextField(
                onChanged: _searchQuery,
                style:
                    AppTextStyle.interSemiBold.copyWith(color: AppColors.white),
                decoration: InputDecoration(
                    prefixIcon: Padding(
                      padding: EdgeInsets.all(10.h),
                      child: SvgPicture.asset(
                        AppImages.search,
                      ),
                    ),
                    hintText: "Search for your task...",
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: AppColors.white)),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: AppColors.white)),
                    hintStyle:
                        TextStyle(color: AppColors.white.withOpacity(.5)),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: AppColors.white),
                    )),
              ),
            ),
            Padding(
              padding:  EdgeInsets.only(left: 16.w),
              child: TextButton(
                  onPressed: () {},
                  child: Row(
                    children: [
                      Text(
                        "Today",
                        style: AppTextStyle.interMedium
                            .copyWith(color: AppColors.white.withOpacity(.7)),
                      ),
                      IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.keyboard_arrow_down_rounded,
                            color: Colors.white.withOpacity(.7),
                          ),
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.white.withOpacity(.21),


                      ),)
                    ],
                  )),
            ),
            Expanded(
              child: ListView(
                children: List.generate(
                  tasks.length,
                  (index) {
                    TaskModel taskModel = tasks[index];
                    debugPrint("${taskModel.title}");

                    return TaskItemView(
                      categoryModel: categories[index],
                      taskModel: taskModel,
                      onDelete: () async {
                        await LocalDatabase.deleteTask(taskModel.id!);
                        _init();
                      },
                      onUpdate: () {
                        updateTaskDialog(
                          context: context,
                          task: taskModel,
                          taskModelChanged: (updatedTask) async {
                            await LocalDatabase.updateTask(
                                updatedTask.copyWith(id: taskModel.id),
                                taskModel.id!);
                            _init();
                          },
                        );
                      },
                      onStatusUpdate: () async {
                        await LocalDatabase.updateTaskStatus(
                            newStatus: "done", taskId: taskModel.id!);
                        _init();
                      },
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
