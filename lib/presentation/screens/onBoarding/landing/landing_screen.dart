import 'dart:math';

import 'package:ai_brainstorm/common/constants/app_color.dart';
import 'package:ai_brainstorm/common/constants/assets_constants.dart';
import 'package:ai_brainstorm/common/constants/custom_error_dialog.dart';
import 'package:ai_brainstorm/common/constants/reusables/button.dart';
import 'package:ai_brainstorm/common/constants/reusables/custom_background.dart';
import 'package:ai_brainstorm/common/constants/reusables/textfield.dart';
import 'package:ai_brainstorm/common/constants/route_constant.dart';
import 'package:ai_brainstorm/core/config/router_config.dart';
import 'package:ai_brainstorm/core/providers/shared_preferences.dart';
import 'package:ai_brainstorm/data/others/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hng_authentication/authentication.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class LandingScreen extends StatefulWidget {
  const LandingScreen({Key? key}) : super(key: key);

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<ScaffoldMessengerState> _scaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size;

    void showSnackBar(String message, Color color) {
      _scaffoldMessengerKey.currentState?.showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: color,
          behavior: SnackBarBehavior.floating,
          margin: EdgeInsets.only(bottom: mediaQuery.height * 0.9),
        ),
      );
    }

    return Stack(
      alignment: Alignment.center,
      children: [
        CustomBackground(),
        ScaffoldMessenger(
          key: _scaffoldMessengerKey,
          child: Scaffold(
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
                          controller: emailController,
                          keyboardType: TextInputType.emailAddress,
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
                          obscureText: true,
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.transparent),
                          ),
                          prefix: Icon(Icons.lock_outline,
                              color: AppColor.white.withOpacity(0.6)),
                        )
                      ],
                    ),
                  ),
                  40.verticalSpace,
                  ButtonWidget(
                    buttonText: isLoading ? '' : 'Continue',
                    fontSize: 18,
                    onPressed: isLoading
                        ? null
                        : () async {
                            final email = emailController.text.trim();
                            final password = passwordController.text.trim();

                            if (email.isEmpty || password.isEmpty) {
                              print('intered');
                              showSnackBar(
                                  'All fields are required.', Colors.red);
                              return;
                            }

                            setState(() {
                              isLoading = true;
                            });
                            final internetConnectionChecker =
                                InternetConnectionChecker();

                            if (await internetConnectionChecker.hasConnection) {
                              try {
                              final loginResponse = await Authentication().signIn(email, password);
                              print(' cookie: ${loginResponse.cookie}');

                                  if (loginResponse != null && loginResponse.id != null) {
                                    // Extract the session value from the cookie
                                    String sessionValue = Utils.extractSessionValue(loginResponse.cookie);

                                    SharedPreferencesManager.prefs.setString('id', loginResponse.id);
                                    SharedPreferencesManager.prefs.setString('email', loginResponse.email);
                                    SharedPreferencesManager.prefs.setString('session', 'session=$sessionValue');
                                    SharedPreferencesManager.prefs.setInt('credits', loginResponse.credits);
                                    SharedPreferencesManager.prefs.setString('name', loginResponse.name);

                                    print('User: ${loginResponse.id}, ${loginResponse.name}, ${loginResponse.email}, session=$sessionValue}');

                                    showSnackBar('Welcome Back!', Colors.lightGreen.withOpacity(0.8));

                                    routerConfig.pushReplacement(RoutesPath.nav, extra: {'name' : loginResponse.name});
                                  }
                                  else {
                                    // Sign-in failed, handle the error
                                    print("Sign-in failed. Message: could not sign in user)");
                                    CustomDialog().showCustomDialog(
                                      context: context,
                                      header: 'Failed to Log in',
                                      body: loginResponse,
                                      buttonText: 'Ok',
                                    );
                                    setState(() {
                                      isLoading = false;
                                    });
                                    return;
                                  }
                              } catch (error) {
                                print('Error logging in: $error');
                                showSnackBar('Incorrect email or password', Colors.red);
                              } finally {
                                setState(() {
                                  isLoading = false;
                                });
                              }
                            }
                            else {
                              CustomDialog().showCustomDialog(
                                context: context,
                                header: 'No internet connection',
                                body: 'Please check your network and try again',
                                buttonText: 'Ok',
                              );
                              setState(() {
                                isLoading = false;
                              });
                            }
                          },
                    isLoading: isLoading,
                  )
                ],
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 12,
          child: Row(
            children: [
              Text(
                'Create new Account? ',
                style: GoogleFonts.cabin(
                    fontSize: 18,
                    fontWeight: FontWeight.normal,
                    color: AppColor.whiteOpacity6,
                    decoration: TextDecoration.none),
              ),
              GestureDetector(
                onTap: () {
                  while (routerConfig.canPop() == true) {
                    routerConfig.pop();
                  }
                  routerConfig.pushReplacement(RoutesPath.signup);
                },
                child: Container(
                  child: Text(
                    'SignUp',
                    style: GoogleFonts.cabin(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        decoration: TextDecoration.none),
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
