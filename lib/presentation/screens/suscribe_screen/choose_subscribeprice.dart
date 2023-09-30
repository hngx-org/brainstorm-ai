// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:ai_brainstorm/presentation/screens/suscribe_screen/main_suscribe_screen.dart';

class ChooseSubsPrice extends StatefulWidget {
  final String howLong;
  final String length;
  final int radioValue;
  final FocusNode getFocus;

  const ChooseSubsPrice({
    Key? key,
    required this.howLong,
    required this.length,
    required this.radioValue,
    required this.getFocus,
  }) : super(key: key);

  @override
  State<ChooseSubsPrice> createState() => _ChooseSubsPriceState();
}

class _ChooseSubsPriceState extends State<ChooseSubsPrice> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        top: 10.h,
        bottom: 10.h,
      ),
      padding: EdgeInsets.all(10.sp),
      height: 100.h,
      width: 380.w,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(
          20.r,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              myContainerText(
                widget.howLong,
                FontWeight.w500,
                22.sp,
              ),
              SizedBox(
                height: 10.h,
              ),
              myContainerText(
                widget.length,
                FontWeight.w400,
                18.sp,
              ),
            ],
          ),
          Radio(
              onChanged: (radioValue) {
                setState(() {
                  selectedOption = radioValue;
                  print("Button value: $radioValue");
                });
              },
              value: widget.radioValue,
              groupValue: selectedOption,
              focusNode: widget.getFocus,
              fillColor: MaterialStateProperty.resolveWith<Color>(
                  (Set<MaterialState> states) {
                if (states.contains(MaterialState.disabled)) {
                  return Colors.orange.withOpacity(.32);
                }
                return Colors.orange;
              })),
        ],
      ),
    );
  }
}
