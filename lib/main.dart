import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:watch_app/pages/splash_page.dart';
import 'package:provider/provider.dart';
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

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 360),
      minTextAdapt: true,
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          home: SplashPage(),
        );
      },
    );
  }
}
