import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:to_do_my/screens/routes.dart';
import 'package:to_do_my/utils/colors/app_colors.dart';
import 'package:to_do_my/utils/images/app_images.dart';
import 'package:to_do_my/utils/styles/app_text_style.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.c_121212,
      body: Column(
        children: [
          SizedBox(height: 57.h),
          Center(
            child: Text(
              "Profile",
              style: AppTextStyle.interMedium.copyWith(
                  fontSize: 20.sp, color: AppColors.white.withOpacity(.87)),
            ),
          ),
          IconButton(
              onPressed: () {
                Navigator.pushNamed(context, RouteNames.addCategory,
                    arguments: () {
                  setState(() {});
                });
              },
              icon: Icon(
                Icons.add_card_rounded,
                color: AppColors.white,
              ))
        ],
      ),
    );
  }
}
