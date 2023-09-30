import 'package:ai_brainstorm/common/constants/app_color.dart';
import 'package:ai_brainstorm/common/constants/assets_constants.dart';
import 'package:ai_brainstorm/common/constants/reusables/button.dart';
import 'package:ai_brainstorm/common/constants/reusables/custom_background.dart';
import 'package:ai_brainstorm/common/constants/reusables/textfield.dart';
import 'package:ai_brainstorm/common/constants/route_constant.dart';
import 'package:ai_brainstorm/core/config/router_config.dart';
import 'package:ai_brainstorm/core/providers/shared_preferences.dart';
import 'package:ai_brainstorm/presentation/screens/onBoarding/signup/signup.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class LandingScreen extends StatefulWidget {
  const LandingScreen({Key? key}) : super(key: key);

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size;
    return Stack(
      alignment: Alignment.center,
      children: [
        CustomBackground(),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: Container(
            height: mediaQuery.height,
            width: mediaQuery.width,
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 50),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                60.verticalSpace,
                Image.asset(
                  Assets.logo,
                  width: mediaQuery.width * 0.25,
                ),
                40.verticalSpace,
                Text(
                  'Let\'s Get Started',
                  style: GoogleFonts.cabin(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.white.withOpacity(0.8),
                  ),
                ),
                40.verticalSpace,
                //text fields
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 9),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                          width: 1,
                          color: AppColor.borderColor.withOpacity(0.6))),
                  child: Column(
                    children: [
                      CustomAuthInput(
                        labelText: 'email',
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: AppColor.borderColor.withOpacity(0.6)),
                        ),
                        prefix: Icon(Icons.email_outlined, color: AppColor.white.withOpacity(0.6)),
                      ),
                      CustomAuthInput(
                        labelText: 'password',
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.transparent),
                        ),
                        prefix: Icon(Icons.lock_outline, color: AppColor.white.withOpacity(0.6)
                      ),)
                    ],
                  ),
                ),
                40.verticalSpace,
                ButtonWidget(buttonText: 'Continue', fontSize: 18, onPressed: () {
                  SharedPreferencesManager.prefs.setString('first_name', 'Nameless');
                  SharedPreferencesManager.prefs.setString('last_name', 'User');

                  routerConfig.pushReplacement(RoutesPath.nav, extra: {'first_name': 'Nameless', 'last_name': 'User'});

                },)
              ],
            ),
          ),
        ),
        Positioned(
          bottom: 12,
          child: Row(
            children: [
              Text('Create new Account? ', style: GoogleFonts.cabin(
                fontSize: 18,
                fontWeight: FontWeight.normal,
                color: AppColor.whiteOpacity6, decoration: TextDecoration.none
              ), ),
              GestureDetector(
                onTap: () {
                  while (routerConfig.canPop() == true) {
                    routerConfig.pop();
                  }
                  routerConfig.pushReplacement(RoutesPath.signup);
                },
                child: Container(
                  child: Text('SignUp', style: GoogleFonts.cabin(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white, decoration: TextDecoration.none
                  ),),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
