import 'package:ai_brainstorm/common/constants/app_color.dart';
import 'package:ai_brainstorm/common/constants/assets_constants.dart';
import 'package:ai_brainstorm/common/constants/reusables/back_icon.dart';
import 'package:ai_brainstorm/common/constants/reusables/button.dart';
import 'package:ai_brainstorm/common/constants/reusables/textfield.dart';
import 'package:ai_brainstorm/common/constants/route_constant.dart';
import 'package:ai_brainstorm/core/config/router_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}
class _SignUpScreenState extends State<SignUpScreen> {
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
        Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(Assets.bgImage), fit: BoxFit.cover)),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          resizeToAvoidBottomInset: false,
          body: Container(
            width: mediaQuery.width,
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(horizontal: 50),
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
                  'Create your account',
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
                      Container(
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              width:
                                  1.0,
                              color: AppColor.borderColor.withOpacity(0.2),
                            ),
                          ),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: CustomAuthInput(
                                labelText: 'First Name',
                                controller: firstNameController,
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: AppColor.borderColor
                                          .withOpacity(0.6)),
                                ),
                              ),
                            ),
                            Expanded(
                              child: CustomAuthInput(
                                labelText: 'Last Name',
                                controller: lastNameController,
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: AppColor.borderColor
                                          .withOpacity(0.6)),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Column(
                        children: [
                          CustomAuthInput(
                            labelText: 'email',
                            controller: emailController,
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: AppColor.borderColor.withOpacity(0.6)),
                            ),
                            prefix: Icon(Icons.email_outlined,
                                color: AppColor.white.withOpacity(0.6)),
                          ),
                          CustomAuthInput(
                            labelText: 'password',
                            controller: passwordController,
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.transparent),
                            ),
                            prefix: Icon(Icons.lock_outline,
                                color: AppColor.white.withOpacity(0.6)),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                40.verticalSpace,
                ButtonWidget(
                  buttonText: 'Continue',
                  fontSize: 18,
                  onPressed: () {
                    routerConfig.pushReplacement(RoutesPath.nav, extra: {
                      'first_name': firstNameController.text.trim(),
                      'last_name': lastNameController.text.trim()
                    });
                  },
                )
              ],
            ),
          ),
        ),
        Positioned(
          bottom: 12,
          child: Row(
            children: [
              Text(
                'Already Have An Account? ',
                style: GoogleFonts.cabin(
                    fontSize: 18,
                    fontWeight: FontWeight.normal,
                    color: AppColor.whiteOpacity6,
                    decoration: TextDecoration.none),
              ),
              GestureDetector(
                onTap: () {
                  routerConfig.pushReplacement(RoutesPath.landing);
                },
                child: Text(
                  'Log In',
                  style: GoogleFonts.cabin(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      decoration: TextDecoration.none),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
