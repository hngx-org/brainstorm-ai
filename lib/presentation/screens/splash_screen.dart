import 'package:ai_brainstorm/common/constants/app_color.dart';
import 'package:ai_brainstorm/common/constants/assets_constants.dart';
import 'package:ai_brainstorm/common/constants/route_constant.dart';
import 'package:ai_brainstorm/core/config/router_config.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // _navigateToMainScreen();
  }

  Future<void> _navigateToMainScreen() async {
    await Future.delayed(const Duration(seconds: 3), () {
      while (routerConfig.canPop() == true) {
        routerConfig.pop();
      }
      routerConfig.pushReplacement(RoutesPath.landingScreen);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(Assets.bgImage), fit: BoxFit.cover)),
        ),
        Scaffold(
          backgroundColor: AppColor.transparent,
          body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                Assets.splashImagePath,
                width: MediaQuery.of(context).size.width * 0.45,
              ),
              Text('Ai-BrainStorm', style:GoogleFonts.fahkwang(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white))
            ],
          )),
        ),
      ],
    );
  }
}
