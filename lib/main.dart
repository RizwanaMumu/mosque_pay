import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pay/ui/screens/home_screen.dart';
import 'package:pay/ui/screens/login_screen.dart';
import 'package:permission_handler/permission_handler.dart';

void main() async{
  runApp(const MyApp());
  await Permission.location.request();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});



  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return MaterialApp(
            //builder: EasyLoading.init(),
            debugShowCheckedModeBanner: false,
            home: LoginScreen(),
            //initialRoute: 'Splash Screen',
            //onGenerateRoute: RouteGenerate.generateRoute,
          );
        });
  }
}
