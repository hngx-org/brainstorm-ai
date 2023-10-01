import 'package:ai_brainstorm/common/constants/app_color.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomText extends StatelessWidget {
  const CustomText({
    super.key,
    required this.text, required this.fontSize, this.fontWeight, this.color, this.maxLines, this.textAlign,
  });

  final String text;
  final double fontSize;
  final FontWeight? fontWeight;
  final Color? color;
  final int? maxLines;
  final TextAlign? textAlign;

  @override
  Widget build(BuildContext context) {
    return Text(text, style: GoogleFonts.cabin(
        fontSize: fontSize,
        fontWeight: fontWeight ?? FontWeight.normal,
        color: color ?? AppColor.white,
        decoration: TextDecoration.none),
      softWrap: true,
      overflow: TextOverflow.ellipsis,
      maxLines: maxLines ?? 1,
      textAlign: textAlign,
    );
  }
}