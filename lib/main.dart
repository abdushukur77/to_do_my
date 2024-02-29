import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:to_do_my/screens/routes.dart';
import 'package:to_do_my/utils/local/storage_repository.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await StorageRepository.init();





  
  runApp(App());
}

class App extends StatelessWidget {




  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
designSize: Size(375,812),
      builder: (context, child ) {
        return MaterialApp(
          initialRoute: RouteNames.splash,
          onGenerateRoute: AppRoutes.generateRoute,
          debugShowCheckedModeBanner: false,
          theme: ThemeData(useMaterial3: false),
        );
      },
      child: Text(RouteNames.onBoarding),
    );
  }
}
