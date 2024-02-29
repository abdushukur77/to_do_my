import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:to_do_my/data/category.dart';
import 'package:to_do_my/data/local/local_database.dart';
import 'package:to_do_my/screens/tab/home/widget/dialog/add_task_dialog.dart';
import 'package:to_do_my/screens/tab/home/widget/dialog/update_task_dialog.dart';
import 'package:to_do_my/screens/tab/home/widget/task_item_view.dart';

import '../../../data/task_model.dart';
import '../../../utils/colors/app_colors.dart';
import '../../../utils/images/app_images.dart';
import '../../../utils/styles/app_text_style.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

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

  _searchQuery(String q) async {
    tasks = await LocalDatabase.searchTasks(q);
    setState(() {});
  }

  DateTime? dateTime;
  TimeOfDay? timeOfDay;

  @override
  void initState() {
    taskModel.canAddTaskToDatabase();

    _init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.black,
        appBar: AppBar(),
        body: Column(children: [


          TextField(
            onChanged: _searchQuery,
            style: AppTextStyle.interSemiBold.copyWith(
              color: AppColors.white
            ),
         
            decoration: InputDecoration(
                hintText: "Seacrh",
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: AppColors.white)),
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: AppColors.white)),
                hintStyle: TextStyle(color: AppColors.white),
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: AppColors.white),
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

        ],),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            // _showAddItemDialog(context);
            addTaskDialog(
              context: context,
              taskModelChanged: (task) async {
                await LocalDatabase.insertTask(task);
                _init();
              },
            );
          },
          child: Icon(Icons.add),
          backgroundColor: AppColors.c_8875FF,
        ));
  }
}
