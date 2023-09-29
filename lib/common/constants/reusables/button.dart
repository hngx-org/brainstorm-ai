import 'package:ai_brainstorm/common/constants/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class ButtonWidget extends StatefulWidget {
  final void Function()? onPressed;
  final String? buttonText;
  final double fontSize;
  final bool? iconAllowed;
  final Icon? icon;
  final Color? textColor;
  final Widget? child;
  final Color? buttonColor;
  final Color? borderSideColor;
  const ButtonWidget({
    super.key,
    this.onPressed,
    required this.buttonText,
    required this.fontSize,
    this.icon,
    this.iconAllowed = false,
    this.textColor,
    this.child,
    this.buttonColor,
    this.borderSideColor
  });

  @override
  State<ButtonWidget> createState() => _ButtonWidgetState();
}

class _ButtonWidgetState extends State<ButtonWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.h),
      child: SizedBox(
        width: double.infinity,
        height: 55.h,
        child: ElevatedButton(
          onPressed: widget.onPressed,
          style: ButtonStyle(
            textStyle: MaterialStateTextStyle.resolveWith(
              (states) => GoogleFonts.lato(
                fontSize: widget.fontSize,
                fontWeight: FontWeight.w600,
              ),
            ),
            backgroundColor: MaterialStatePropertyAll(Colors.transparent),
            shape: MaterialStateProperty.resolveWith<OutlinedBorder>(
              (states) => RoundedRectangleBorder(
                side: BorderSide(
                  color: widget.borderSideColor ?? AppColor.whiteOpacity6,
                  width: 1.w,
                ),
                borderRadius: BorderRadius.circular(20.r),
              ),
            ),
            elevation: MaterialStatePropertyAll(0),
          ),
          child: widget.child ??
              Text(
                widget.buttonText ?? '',
                style: GoogleFonts.lato(
                  color: widget.textColor ?? AppColor.whiteOpacity6,
                  fontWeight: FontWeight.w700,
                ),
              ),
        ),
      ),
    );
  }
}
