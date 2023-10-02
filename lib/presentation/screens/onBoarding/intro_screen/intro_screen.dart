import 'package:ai_brainstorm/common/constants/app_color.dart';
import 'package:ai_brainstorm/common/constants/assets_constants.dart';
import 'package:ai_brainstorm/common/constants/reusables/back_icon.dart';
import 'package:ai_brainstorm/common/constants/reusables/button.dart';
import 'package:ai_brainstorm/common/constants/reusables/custom_background.dart';
import 'package:ai_brainstorm/common/constants/reusables/glow_logo.dart';
import 'package:ai_brainstorm/common/constants/reusables/textfield.dart';
import 'package:ai_brainstorm/common/constants/route_constant.dart';
import 'package:ai_brainstorm/core/config/router_config.dart';
import 'package:ai_brainstorm/core/providers/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({Key? key}) : super(key: key);

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size;
    return Stack(
      alignment: Alignment.center,
      children: [
        const CustomBackground(),
        Scaffold(
          backgroundColor: Colors.transparent,
          resizeToAvoidBottomInset: false,
          body: Container(
            width: mediaQuery.width,
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                60.verticalSpace,
                GlowingLogo(size: 100),
                20.verticalSpace,
                Text(
                  'Brainstorm-Ai: Your Academic AI Chat Companion',
                  style: GoogleFonts.cabin(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: AppColor.whiteOpacity8,
                  ),
                  textAlign: TextAlign.center,
                ),
                40.verticalSpace,
                Text(
                  '🌟 Effortless Research Assistance',
                  style: GoogleFonts.cabin(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: AppColor.whiteOpacity8,
                  ),
                  textAlign: TextAlign.center,
                ),
                20.verticalSpace,
                Text(
                  '💡 Unleash Creativity',
                  style: GoogleFonts.cabin(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: AppColor.whiteOpacity8,
                  ),
                  textAlign: TextAlign.center,
                ),
                20.verticalSpace,
                Text(
                  '📚 Navigate Academia with Ease',
                  style: GoogleFonts.cabin(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: AppColor.whiteOpacity8,
                  ),
                  textAlign: TextAlign.center,
                ),
                20.verticalSpace,
                Text(
                  '🌐 Connected to Tomorrow\'s Knowledge',
                  style: GoogleFonts.cabin(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: AppColor.whiteOpacity8,
                  ),
                  textAlign: TextAlign.center,
                ),
                40.verticalSpace,
                ButtonWidget(
                  buttonText: 'Continue',
                  fontSize: 22,
                  onPressed: (){
                    routerConfig.pushReplacement(RoutesPath.landing);
                  }, isLoading: false,
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
