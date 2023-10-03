import 'dart:async';

import 'package:ai_brainstorm/common/constants/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomDialog {
  showAlertDialog(
    BuildContext context,
    String type,
    String header,
    String body,
    String buttonText,
  ) {
    final alert = AlertDialog(
      backgroundColor: Colors.white,
      insetPadding: EdgeInsets.symmetric(
        horizontal: 5.w,
      ),
      actionsPadding: EdgeInsets.only(
        left: 15.w,
        right: 15.w,
        bottom: 20.h,
        top: 10.h,
      ),
      contentPadding: EdgeInsets.symmetric(
        vertical: 10.h,
        horizontal: 35.w,
      ),
      title: Text(
        header,
        textAlign: TextAlign.left,
        style: GoogleFonts.cabin(
          fontSize: 18.w,
          fontWeight: FontWeight.w500,
          color: type == 'success' ? Colors.green : Colors.red,
        ),
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: SizedBox(
                width: 25.w,
              ),
            ),
            InkWell(
              onTap: context.pop,
              child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: AppColor.appBrandColor,
                  borderRadius: BorderRadius.circular(5),
                ),
                width: 70.w,
                height: 40.h,
                child: Text(
                  buttonText,
                  style: GoogleFonts.cabin(
                    fontSize: 16.w,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
      content: Text(
        body,
        style: GoogleFonts.poppins(
          fontSize: 16.w,
          fontWeight: FontWeight.w400,
          color: AppColor.appBrandColor,
        ),
      ),
    );

    showGeneralDialog(
      barrierDismissible: false,
      context: context,
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        return SlideTransition(
          position: Tween(
            begin: const Offset(
              0,
              1,
            ),
            end: const Offset(
              0,
              0,
            ),
          ).animate(animation),
          child: child,
        );
      },
      transitionDuration: const Duration(
        milliseconds: 500,
      ),
      pageBuilder: (
        BuildContext context,
        Animation<double> animation,
        Animation<double> secondaryAnimation,
      ) {
        return alert;
      },
    );
  }

  showLoadDialog(BuildContext context) {
    final alert = WillPopScope(
      onWillPop: () => Future(() => false),
      child: Center(
        child: SizedBox(
          width: 50.w,
          height: 50.h,
          child: CircularProgressIndicator(
            color: AppColor.whiteOpacity8,
            strokeWidth: 2,
          ),
        ),
      ),
    );

    // Create a Completer to control when to close the dialog
    final completer = Completer<void>();

    showGeneralDialog(
      barrierDismissible: false,
      context: context,
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        return SlideTransition(
          position: Tween(
            begin: const Offset(
              0,
              1,
            ),
            end: const Offset(
              0,
              0,
            ),
          ).animate(animation),
          child: child,
        );
      },
      transitionDuration: const Duration(
        milliseconds: 500,
      ),
      pageBuilder: (
        BuildContext context,
        Animation<double> animation,
        Animation<double> secondaryAnimation,
      ) {
        return alert;
      },
    );

    const timeoutDuration =
        Duration(seconds: 15); // Adjust the timeout duration as needed
    Timer(timeoutDuration, () {
      if (!completer.isCompleted) {
        // Check if the Completer is completed to avoid closing twice
        completer.complete();
        Navigator.of(context).pop();
      }
    });
  }

  Future<void> showCustomDialog({
    required BuildContext context,
    required String header,
    required String body,
    required String buttonText,
  }) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            header,
            style: GoogleFonts.cabin(
              color: Colors.red,
              fontSize: 23.sp,
              fontWeight: FontWeight.w800,
            ),
          ),
          content: SingleChildScrollView(
            child: Text(
              body,
              style: GoogleFonts.cabin(
                color: AppColor.whiteOpacity8,
                fontSize: 15.sp,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                context.pop(); // Close the dialog
              },
              style: ButtonStyle(
                backgroundColor: const MaterialStatePropertyAll(Colors.red),
                elevation: const MaterialStatePropertyAll(3),
                shape: MaterialStateProperty.resolveWith<OutlinedBorder>(
                  (states) => RoundedRectangleBorder(
                    side: const BorderSide(
                      color: Colors.transparent,
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                ),
              ),
              child: Text(
                buttonText,
                style: GoogleFonts.cabin(
                  color: Colors.white,
                  fontSize: 23.sp,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
            10.horizontalSpace
          ],
          elevation: 2,
          backgroundColor: Colors.black.withOpacity(0.8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
                30.0.r), // Customize the border radius as needed
          ),
        );
      },
    );
  }
}
