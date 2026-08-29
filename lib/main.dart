import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:watch_app/constants/app_colors.dart';
import 'package:watch_app/pages/splash_page.dart';
import 'package:watch_app/providers/watch_provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => WatchProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 800),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          title: 'Watch Store',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primaryColor: AppColors.primaryOrange,
            colorScheme: ColorScheme.fromSeed(
              seedColor: AppColors.primaryOrange,
              primary: AppColors.primaryOrange,
            ),
            scaffoldBackgroundColor: Colors.white,
            useMaterial3: true,
          ),
          home: const SplashPage(),
        );
      },
    );
  }
}
