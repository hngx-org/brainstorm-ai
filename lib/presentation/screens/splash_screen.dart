import 'package:ai_brainstorm/common/constants/app_color.dart';
import 'package:ai_brainstorm/common/constants/assets_constants.dart';
import 'package:ai_brainstorm/common/constants/reusables/custom_background.dart';
import 'package:ai_brainstorm/common/constants/route_constant.dart';
import 'package:ai_brainstorm/core/config/router_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool _showingLogo = false;
  bool _showingHi = false;
  bool _showingWelcome = false;
  bool _showingTitle = false;

  @override
  void initState() {
    super.initState();
    _showWidgets();
  }
  Future<void> _showWidgets() async {
    await Future.delayed(const Duration(seconds: 4));
    setState(() {
      _showingLogo = true;
    });

    await Future.delayed(const Duration(seconds: 1));
    setState(() {
      _showingTitle = true;
    });

    await Future.delayed(const Duration(seconds: 2));
    setState(() {
      _showingHi = true;
      _showingTitle = false;
      _showingLogo = false;
    });

    await Future.delayed(const Duration(seconds: 2));
    setState(() {
      _showingHi = false;
      _showingWelcome = true;
    });

    // Navigate to the main screen
    await Future.delayed(const Duration(seconds: 2));
    while (routerConfig.canPop() == true) {
      routerConfig.pop();
    }
    routerConfig.pushReplacement(RoutesPath.landing);
  }

  Widget _fadeInWidget(Widget widget, bool isVisible) {
    return AnimatedOpacity(
      opacity: isVisible ? 1.0 : 0.0,
      duration: const Duration(seconds: 2),
      child: widget,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const CustomBackground(),
        Scaffold(
          backgroundColor: AppColor.transparent,
          body: Center(
              child: Stack(
            alignment: Alignment.center,
            children: [
              _fadeInWidget(
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      Assets.logo,
                      width: MediaQuery.of(context).size.width * 0.45,
                    ),
                    _showingTitle ? Text(
                      'Ai-BrainStorm',
                      style: GoogleFonts.fahkwang(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ) : const SizedBox(),
                  ],
                ),
                _showingLogo,
              ),
              _fadeInWidget(
                Text(
                  'Hi',
                  style: GoogleFonts.fahkwang(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: AppColor.whiteOpacity6,
                  ),
                ),
                _showingHi,
              ),
              _fadeInWidget(
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Text(
                    'Welcome\nto Brainstorm-Ai',
                    style: GoogleFonts.fahkwang(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: AppColor.whiteOpacity6,
                    ),
                    textAlign: TextAlign.center,
                    maxLines: 2,
                  ),
                ),
                _showingWelcome,
              ),
            ],
          )),
        ),
      ],
    );
  }
}
