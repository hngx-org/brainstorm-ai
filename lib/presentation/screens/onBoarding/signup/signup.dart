import 'package:ai_brainstorm/common/constants/app_color.dart';
import 'package:ai_brainstorm/common/constants/assets_constants.dart';
import 'package:ai_brainstorm/common/constants/custom_error_dialog.dart';
import 'package:ai_brainstorm/common/constants/reusables/text.dart';
import 'package:hng_authentication/authentication.dart';
import 'package:ai_brainstorm/common/constants/reusables/button.dart';
import 'package:ai_brainstorm/common/constants/reusables/textfield.dart';
import 'package:ai_brainstorm/common/constants/route_constant.dart';
import 'package:ai_brainstorm/core/config/router_config.dart';
import 'package:ai_brainstorm/core/providers/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';


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
  String emailError = '';
  String passError = '';
  bool isLoading = false;
  final GlobalKey<ScaffoldMessengerState> _scaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();

  bool validateEmailFormat(String email) {
    final emailRegex = RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$');
    return emailRegex.hasMatch(email);
  }

  Future<void> submit (_showSnackBar) async {
    final firstName = firstNameController.text.trim();
    final lastName = lastNameController.text.trim();
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    if (firstName.isEmpty ||
        lastName.isEmpty ||
        email.isEmpty ||
        password.isEmpty) {
      _showSnackBar(
          'All fields are required.', Colors.red);
      return;
    }

    // Check email format
    if (!validateEmailFormat(email)) {
      _showSnackBar(
          'Invalid email format.', Colors.red);
      return;
    }

    // Check password format
    if (!validatePasswordFormat(password)) {
      _showSnackBar(
          'Invalid password format.', Colors.red);
      return;
    }

    setState(() {
      isLoading = true;
    });

    final internetConnectionChecker = InternetConnectionChecker();

    if (await internetConnectionChecker.hasConnection) {
      // If all validations pass, sign up logic here
      String name = '$firstName $lastName';

      final response = await Authentication()
          .signUp(email, name, password);

      print('$response');
      try {
        if (response['message'] ==
            'User Created Succesfully') {
          final userData = response['data'];

          SharedPreferencesManager.prefs
              .setString('id', userData['id']);
          SharedPreferencesManager.prefs
              .setString('email', userData['email']);
          SharedPreferencesManager.prefs
              .setString('password', userData['password']);
          SharedPreferencesManager.prefs
              .setInt('credits', userData['credits']);
          SharedPreferencesManager.prefs
              .setString('name', userData['name']);

          final loginResponse = await Authentication().signIn(email, password);

          if (loginResponse != null) {
            final responseData = loginResponse['data'];
            final message = loginResponse['message'];

            if (message == 'success') {
              print("Sign-in was successful. User data: $responseData");
              _showSnackBar('seccess!', AppColor.lightgreen.withOpacity(0.8));
              routerConfig.pushReplacement(RoutesPath.home, extra: {'name': name});

            } else {
              // Sign-in failed, handle the error
              print("Sign-in failed. Message: $message");

            }

            setState(() {
              isLoading = false;
            });
          }

        }
        else {
          CustomDialog().showCustomDialog(
            context: context,
            header: 'User sign up failed',
            body: response['message'],
            buttonText: 'Ok',
          );
        }
      } catch (error) {
        print(
            'Error signing up: $error'); // Print the error to the console
        _showSnackBar(
            'An error occurred while signing up. $error',
            Colors.red);
      } finally {
        setState(() {
          isLoading = false;
        });
      }
    }
    else {
      // No internet connection, show dialog
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

  }

  bool validatePasswordFormat(String password) {
    // Password regex pattern that enforces at least:
    // - One uppercase letter (A-Z)
    // - One digit (0-9)
    // - One special character (e.g., !@#)
    final passwordRegex =
        RegExp(r'^(?=.*[A-Z])(?=.*\d)(?=.*[\W_])[A-Za-z\d\W_]+$');
    return passwordRegex.hasMatch(password);
  }

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

    void _showSnackBar(String message, Color color) {
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
        Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(Assets.bgImage), fit: BoxFit.cover)),
        ),
        ScaffoldMessenger(
          key: _scaffoldMessengerKey,
          child: Scaffold(
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
                                width: 1.0,
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
                              keyboardType: TextInputType.emailAddress,
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color:
                                        AppColor.borderColor.withOpacity(0.6)),
                              ),
                              prefix: Icon(Icons.email_outlined,
                                  color: AppColor.white.withOpacity(0.6)),
                              onChanged: (value) {
                                final email = value.trim();
                                if (email.isEmpty) {
                                  setState(() {
                                    emailError = 'Required field';
                                  });
                                } else if (!validateEmailFormat(email)) {
                                  setState(() {
                                    emailError = 'Invalid email format';
                                  });
                                } else {
                                  setState(() {
                                    emailError =
                                        ''; // Clear any previous error message
                                  });
                                }
                              },
                            ),
                            CustomText(
                              text: emailError,
                              fontSize: 15,
                              color: Colors.red,
                            ),
                            CustomAuthInput(
                              labelText: 'password',
                              controller: passwordController,
                              obscureText: true,
                              enabledBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.transparent),
                              ),
                              prefix: Icon(Icons.lock_outline,
                                  color: AppColor.white.withOpacity(0.6)),
                              onChanged: (value) {
                                final password = value.trim();
                                if (password.isEmpty) {
                                  setState(() {
                                    passError = 'Required field';
                                  });
                                } else if (!validatePasswordFormat(password)) {
                                  setState(() {
                                    passError = 'Invalid password format';
                                  });
                                } else {
                                  setState(() {
                                    passError = '';
                                  });
                                }
                              },
                            ),
                            CustomText(
                              text: passError,
                              fontSize: 15,
                              color: Colors.red,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  40.verticalSpace,
                  ButtonWidget(
                    buttonText: isLoading ? 'Signing Up...' : 'Sign Up',
                    fontSize: 22,
                    onPressed: isLoading
                        ? null // Disable the button when isLoading is true
                        : () {submit(_showSnackBar);},
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
        ),
      ],
    );
  }
}
