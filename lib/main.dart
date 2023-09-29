import 'package:ai_brainstorm/common/constants/app_color.dart';
import 'package:ai_brainstorm/core/config/router_config.dart';
import 'package:flutter/material.dart';
import 'package:ai_brainstorm/core/providers/shared_preferences.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPreferencesManager.init();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarBrightness: Brightness.light,
      statusBarIconBrightness: Brightness.dark,
    ),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    MaterialColor buildMaterialColor(Color color) {
      List strengths = <double>[.05];
      Map<int, Color> swatch = {};
      final int r = color.red, g = color.green, b = color.blue;

      for (int i = 1; i < 10; i++) {
        strengths.add(0.1 * i);
      }
      for (var strength in strengths) {
        final double ds = 0.5 - strength;
        swatch[(strength * 1000).round()] = Color.fromRGBO(
          r + ((ds < 0 ? r : (255 - r)) * ds).round(),
          g + ((ds < 0 ? g : (255 - g)) * ds).round(),
          b + ((ds < 0 ? b : (255 - b)) * ds).round(),
          1,
        );
      }
      return MaterialColor(color.value, swatch);
    }

    return ScreenUtilInit(
        designSize: const Size(411.4, 868.6),
        minTextAdapt: true,
        builder: (context, child) {
          return MaterialApp.router(
            routerConfig: routerConfig,
            title: 'AI-Brainstorm',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              primaryColor: AppColor.appBrandColor,
              primarySwatch: buildMaterialColor(AppColor.appBrandColor),
              scaffoldBackgroundColor: AppColor.white,
              visualDensity: VisualDensity.adaptivePlatformDensity,
            ),
          );
        });
  }
}
