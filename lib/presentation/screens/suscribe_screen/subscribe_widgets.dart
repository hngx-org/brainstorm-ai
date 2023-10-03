import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Text myContainerText(
  String myText,
  FontWeight myweight,
  double textSixe,
) {
  return Text(
    myText,
    textAlign: TextAlign.end,
    style: TextStyle(
      fontWeight: myweight,
      color: Colors.white,
      fontSize: textSixe,
    ),
  );
}

class ListOfText extends StatelessWidget {
  final String myText;
  final double textSixe;
  Color textColor;
  final FontWeight myweight;
  final bool showMark;
  ListOfText(this.myText, this.textSixe, this.myweight, this.showMark,
      [this.textColor = Colors.white]);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: showMark
          ? EdgeInsets.only(
              top: 8.sp,
              left: 10.sp,
            )
          : EdgeInsets.only(top: 20.sp),
      child: Row(
        mainAxisAlignment:
            showMark ? MainAxisAlignment.start : MainAxisAlignment.center,
        children: [
          showMark
              ? Icon(
                  Icons.verified,
                  color: Colors.white,
                  size: 22.sp,
                )
              : const SizedBox(),
          5.horizontalSpace,
          Text(
            myText,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: myweight,
              color: Colors.white,
              fontSize: textSixe,
            ),
          ),
        ],
      ),
    );
  }
}
