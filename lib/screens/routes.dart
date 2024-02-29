import 'package:flutter/material.dart';
import 'package:to_do_my/screens/add_category/add_category_screen.dart';
import 'package:to_do_my/screens/on_boarding/on_boarding_screen.dart';
import 'package:to_do_my/screens/splash/splash_screen.dart';
import 'package:to_do_my/screens/tab/home/home_screen.dart';
import 'package:to_do_my/screens/tab/tab_box.dart';

class AppRoutes {
  static Route generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteNames.splash:
        return navigate(const SplashScreen());
      case RouteNames.tabBox:
        return navigate(const TabBox());
      case RouteNames.onBoarding:
        return navigate(OnBoardingScreen());
      case RouteNames.home:
        return navigate(HomeScreen());
      case RouteNames.addCategory:{
        VoidCallback voidCallback = settings.arguments as VoidCallback;
        return navigate(AddCategoryScreen(onSet: voidCallback,));

      }

      default:
        return navigate(
          const Scaffold(
            body: Center(
              child: Text("This kind of rout does not exist!"),
            ),
          ),
        );
    }
  }

  static navigate(Widget widget) {
    return MaterialPageRoute(builder: (context) => widget);
  }
}

class RouteNames {
  static const String splash = "/";
  static const String tabBox = "/tab_route";
  static const String onBoarding = "/on_boarding_screen";
  static const String home = "/home_screen";
  static const String addCategory = "/add_category";
}
